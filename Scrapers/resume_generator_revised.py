from more_itertools import peekable
from playwright.sync_api import sync_playwright, Page
import re
import os
import argparse
import re
import jinja2
import time
import sys

environment = jinja2.Environment(loader=jinja2.FileSystemLoader('.'))

POS_LOC_REGEX = re.compile('(.+)\t(.+)')

def clean_doc(doc_lines: list[str]):
    cleaned_doc_lines = ['Personal Information:']
    cleaned_doc_lines.extend([re.sub(r'â€¢', '', i.strip()) for i in doc_lines if i.strip()])
    return cleaned_doc_lines

HEADERS = ['Personal Information:', 'Education:', 'Work Experience:', 'Projects:']
HEADERS_MAP = {
    'Personal Information:': 'personal_information',
    'Education:': 'education',
    'Work Experience:': 'work_experience',
    'Projects:': 'projects'
}

def parse_doc_lines(doc_lines: list[str]):
    obj = {
        'personal_information': [],
        'education': [],
        'work_experience': [],
        'projects': [],
        'skills': None,
        'languages': None
    }
    current_key = None
    
    # Regex to find years or year ranges
    year_range_regex = re.compile(r'(\d{4})-(\d{4})')  # Matches year ranges like 2018-2022
    year_regex = re.compile(r'\b(\d{4})\b')  # Matches single years like 2018
    
    def increment_years_in_text(text: str) -> str:
        """Helper function to increment all year numbers found in a string by 1."""
        # Increment year ranges (YYYY-YYYY)
        text = year_range_regex.sub(lambda x: f"{int(x.group(1)) + 1}-{int(x.group(2)) + 1}", text)
        
        # Increment individual years (YYYY)
        text = year_regex.sub(lambda x: f"{int(x.group(1)) + 1}", text)
        
        return text
    
    for line in doc_lines:
        if line in HEADERS_MAP.keys():
            current_key = HEADERS_MAP[line]
        else:
            if line.startswith('Skills:'):
                obj['skills'] = line

            elif line.startswith('Language:'):
                obj['languages'] = line

            else:
                # Apply year incrementing for education and work experience sections
                if current_key in ['education', 'work_experience']:
                    line = increment_years_in_text(line)
                
                obj[current_key].append(line)

    obj['personal_information'] = {'full_name': obj['personal_information'][0], 'email': obj['personal_information'][1]}
    obj['personal_information']['first_name'] = obj['personal_information']['full_name'].split(' ')[0]
    obj['personal_information']['last_name'] = ' '.join(obj['personal_information']['full_name'].split(' ')[1:])
    
    # Assuming education has a fixed structure of three lines: university, course, citizenship
    education = obj['education']
    university, year = education[0].split('\t')
    course, gpa = education[1].split('\t')
    citizenship = education[2]
    obj['personal_information']['immigration_status'] = citizenship
    obj['education'] = {
        'university': university,
        'year': year,
        'course': course,
        'gpa': gpa
    }
    
    if obj['skills']:
        obj['skills'] = obj['skills'].removeprefix('Skills:').strip().replace(', ', ',').split(',')
    if obj['languages']:
        obj['languages'] = obj['languages'].removeprefix('Language:').strip().replace(', ', ',').split(',')

    work_experience_uncleaned = obj['work_experience']
    work_experience_cleaned = []
    work_exp_iter = peekable(work_experience_uncleaned)
    current_exp = {}

    for line in work_exp_iter:
        if 'position' not in current_exp:
            comp_pos, current_exp['location'] = (line.split('\t') + [None, None])[:2]
            if comp_pos:
                current_exp['company'], current_exp['position'] = (comp_pos.split('|') + [None, None])[:2]
            current_exp['accomplishments'] = []
        elif 'date_range' not in current_exp:
            current_exp['date_range'] = line
        elif line.startswith('•'):
            current_exp['accomplishments'].append(line.removeprefix('•').strip())
            next_line_peek = work_exp_iter.peek(None)
            if next_line_peek is None:
                break
            if not next_line_peek.startswith('•'):
                if POS_LOC_REGEX.search(next_line_peek) is None:
                    next_line = next(work_exp_iter)
                    current_exp['accomplishments'][-1] = current_exp['accomplishments'][-1] + ' ' + next_line
                else:
                    work_experience_cleaned.append(current_exp.copy())
                    current_exp = {}
    
    if current_exp:
        work_experience_cleaned.append(current_exp.copy())

    obj['work_experience'] = work_experience_cleaned

    projects_uncleaned = obj['projects']
    projects_cleaned = []
    projects_iter = peekable(projects_uncleaned)
    current_project = {}
    
    for line in projects_iter:
        if 'project' not in current_project:
            current_project['project'] = line
            current_project['accomplishments'] = []
        elif line.startswith('•'):
            current_project['accomplishments'].append(line.removeprefix('•').strip())
            next_line_peek = projects_iter.peek(None)
            if next_line_peek is None:
                projects_cleaned.append(current_project.copy())
                current_project = {}

    obj['projects'] = projects_cleaned
    return obj

def get_doc_lines(doc):
    with open(doc, 'r', encoding='utf-8') as f:
        return f.readlines()


def generate_template(page: Page, template: str, context: dict, pdf_file: str):
    template = environment.get_template(template)
    html = template.render(context=context)
    page.set_content(html, wait_until='commit')
    time.sleep(2)
    page.pdf(path=pdf_file, format='Legal')


def determine_template_and_filename(doc_name: str):
    """Determine the template and the output filename based on the file name ending."""
    if doc_name.endswith('1of3.doc'):
        return 'template1.html', 'Resume.pdf'
    elif doc_name.endswith('2of3.doc'):
        return 'template2.html', 'CV.pdf'
    elif doc_name.endswith('3of3.doc'):
        return 'template3.html', 'main_resume.pdf'
    else:
        raise ValueError(f"Unknown file ending for {doc_name}")


def extract_group_number(doc_name: str):
    """Extract the group number from the filename (e.g., RR_US_2024-10-15-17-36-19_0607_2of3.doc -> 0607)."""
    match = re.search(r'_(\d{4})_(1of3|2of3|3of3)', doc_name)
    if match:
        return int(match.group(1))  # Return the group number as an integer
    else:
        raise ValueError(f"Could not determine group number from {doc_name}")


def determine_output_directory(doc_name: str, us_output_dir: str, ca_output_dir: str):
    """Determine the output directory (US or CA) based on the file name prefix (RR_US or RR_CA)."""
    if doc_name.startswith('RR_US'):
        return us_output_dir
    elif doc_name.startswith('RR_CA'):
        return ca_output_dir
    else:
        raise ValueError(f"Unknown country prefix in filename {doc_name}. Expected 'RR_US' or 'RR_CA'.")


def main(folder: str, us_output_dir: str, ca_output_dir: str):
    print(f"Processing files in directory: {folder}")
    
    with sync_playwright() as p:
        p.chromium.launch()
        browser = p.chromium.launch()
        page = browser.new_page()
        
        files_processed = 0
        
        for i in os.listdir(folder):
            if not i.endswith('.doc'):
                print(f"Skipping non-.doc file: {i}")
                continue

            print(f"Processing file: {i}")
            files_processed += 1
            
            doc_file = os.path.join(folder, i)
            doc_lines = get_doc_lines(doc_file)

            # Check if file lines were read correctly
            if not doc_lines:
                print(f"Could not read lines from {doc_file}")
                continue

            cleaned_doc_lines = clean_doc(doc_lines)
            obj = parse_doc_lines(cleaned_doc_lines)

            # Determine whether to use US or CA output directory
            country_output_dir = determine_output_directory(i, us_output_dir, ca_output_dir)
            print(f"Using output directory: {country_output_dir}")

            # Determine the group number and create group folder if necessary
            group_number = extract_group_number(i)
            group_folder = os.path.join(country_output_dir, f'Group {group_number}')
            if not os.path.exists(group_folder):
                os.makedirs(group_folder)
                print(f"Created folder: {group_folder}")

            # Determine the template and the output file name based on the file name
            template, output_file_name = determine_template_and_filename(i)
            pdf_file = os.path.join(group_folder, output_file_name)

            # Generate the PDF with the selected template
            print(f"Generating PDF: {pdf_file}")
            generate_template(page, template, obj, pdf_file)
        
        if files_processed == 0:
            print("No .doc files found in the directory.")
        else:
            print(f"Processed {files_processed} files.")


if __name__ == '__main__':
    parser = argparse.ArgumentParser()
    parser.add_argument('--directory', type=str, required=True, dest='directory')
    parser.add_argument('--us-output', type=str, required=True, dest='us_output_dir')
    parser.add_argument('--ca-output', type=str, required=True, dest='ca_output_dir')
    args = parser.parse_args()

    if not os.path.isdir(args.directory):
        print("DIRECTORY DOES NOT EXIST")
        sys.exit()

    if not os.path.isabs(args.us_output_dir):
        print("PLEASE ENTER THE ABSOLUTE PATH OF THE US OUTPUT DIRECTORY")
        exit()

    if not os.path.isabs(args.ca_output_dir):
        print("PLEASE ENTER THE ABSOLUTE PATH OF THE CA OUTPUT DIRECTORY")
        exit()

    # Ensure that output directories exist
    if not os.path.exists(args.us_output_dir):
        os.makedirs(args.us_output_dir)

    if not os.path.exists(args.ca_output_dir):
        os.makedirs(args.ca_output_dir)

    main(args.directory, args.us_output_dir, args.ca_output_dir)
