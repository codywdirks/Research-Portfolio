import os
import sys
import pandas as pd
import re
import argparse
import random

# Set up argument parser
parser = argparse.ArgumentParser(description="Process and filter job data.")
parser.add_argument('--input', required=True, help='Directory containing the input file')
parser.add_argument('--file', required=True, help='Name of the CSV file to process')

# Parse arguments
args = parser.parse_args()

# Get input directory and file name
input_directory = args.input
input_filename = args.file

# Construct the full path to the web scraper output file
web_scraper_output = os.path.join(input_directory, input_filename)

# Construct the path to the filter terms file (assumed to be in the current working directory)
filter_terms_file = "List_NegativeFilterTerms.xlsx"

# Generate the output file name (saved in the same directory as the Python script)
output_file = os.path.join(os.getcwd(), "filtered_" + input_filename)

# Load data
df = pd.read_csv(web_scraper_output)
df_terms = pd.read_excel(filter_terms_file)

# Display data for verification
print("Web Scraper Output Data:")
print(df.head())

print("Filter Terms Data:")
print(df_terms.head())

# Convert filter terms to list, ensuring they are strings and stripping whitespace
term_list = df_terms['List of terms'].astype(str).str.strip().tolist()

# Refined filtering function with context-sensitive negative terms
def filter_descriptions(df, term_list):
    for term in term_list:
        if not isinstance(term, str):
            continue
        pattern = re.compile(r'\\b' + re.escape(term) + r'\\b', re.IGNORECASE)
        mask_desc = df['Description'].apply(lambda x: bool(pattern.search(x)) if isinstance(x, str) else False)
        print(f"Filtering with term: {term}")
        df = df[~mask_desc]  # Remove rows that contain the term
    return df

# Apply the filter
df_filtered = filter_descriptions(df, term_list)

# Debug: Print filtered data
print("Filtered data:")
print(df_filtered)

# Create the "Canada" column: 1 for Canada (External_Apply starts with 'http://ca'), 0 for US (starts with 'http://www')
df_filtered['Canada'] = df_filtered['External_Apply'].apply(lambda x: 1 if str(x).startswith('http://ca') else 0)

# Count the number of Canadian jobs (Canada column is 1)
num_canadian_jobs = df_filtered[df_filtered['Canada'] == 1].shape[0]
print(f"Number of Canadian jobs: {num_canadian_jobs}")

# Count the number of US jobs (Canada column is 0)
num_us_jobs = df_filtered[df_filtered['Canada'] == 0].shape[0]
print(f"Number of US jobs: {num_us_jobs}")

# If the number of US jobs exceeds Canadian jobs, drop random US jobs
if num_us_jobs > num_canadian_jobs:
    num_to_drop = num_us_jobs - num_canadian_jobs
    print(f"Dropping {num_to_drop} US jobs to match the number of Canadian jobs.")
    
    # Randomly select rows to drop where Canada == 0 (US jobs)
    us_jobs_to_drop = df_filtered[df_filtered['Canada'] == 0].sample(n=num_to_drop, random_state=42).index
    df_filtered = df_filtered.drop(us_jobs_to_drop)

# Debug: Print data after balancing US and Canadian jobs
print("Data after balancing US and Canadian jobs:")
print(df_filtered)

# Save the filtered data to a new CSV file in the same directory as the Python script
df_filtered.to_csv(output_file, index=False)
print(f"Filtered and balanced data with Canada column saved to {output_file}")
