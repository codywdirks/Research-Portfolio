*******************************************
****** Job Posting Assignment Script ******
*******************************************

**************************************************************************************
*** User Input Section ***
global master_path "/Users/codyw/Desktop/web_scraper/Data/" // master meaning the resume data
global master_file "resume_data_for_national_correspondence_study.dta" // master meaning the resume data
global using_path "/Users/codyw/Desktop/web_scraper/IndeedScraper/output/" // using meaning the job posting data
global using_file "Indeed - 22-10-2024.csv" // using meaning the job posting data
global output_file job_postings_10-24-2024
**************************************************************************************

*** Load the Master Data (Resume Data) ***
use "$master_path$master_file", clear

*** Dropping Observations that Have Already Been Assigned ***
drop if in_task == 1

*** Save as Temporary File ***
tempfile master_temp
save `master_temp'

*** Load the Using Dataset (Job Posting Data) ***
import delimited "$using_path$using_file", clear varnames(1)

*** Adding Country Variable (Will need to be deleted before actual experiment) ***
gen country = ""
replace country = "US" if strpos(external_apply, "http://www.") == 1
replace country = "CA" if strpos(external_apply, "http://ca.") == 1

*** Generating Artificial Grouping ***
bysort country: gen group = _n

*** Expanding the Data by Three to Match Number of Resumes ***
expand 3

*** Generating Resume Numbers ***
bysort posting_url: gen resume_no = _n

*** Save as Temporary File ***
tempfile using_temp
save `using_temp'

*** Merging the Master Data with the Using Data ***
use `master_temp', clear
merge m:1 country group resume_no using `using_temp'

*** Creating Temporary File for Non-Matched Groups ***
preserve
keep if _merge == 1  
keep if in_task == 0
drop _merge
sort country group
bysort country group: gen new_group = _n == 1
bysort country (group): replace new_group = sum(new_group)
keep country group resume_no race name new_group race_name years
tempfile available_groups
save `available_groups'
restore

*** Check for Unmatched Job Postings and Save to Unmatched Tasks if Needed ***
count if _merge == 2
local merge_2_exists = r(N) > 0 // Store the result in a local macro

if `merge_2_exists' {
    preserve
    keep if _merge == 2
    drop _merge
    sort country group
    bysort country group: gen new_group = _n == 1
    bysort country (group): replace new_group = sum(new_group)
    tempfile unmatched_tasks
    save `unmatched_tasks'
    restore 
}

*** Save Matched Observations to Output File ***
keep if _merge == 3 
drop _merge 
save "$output_file.dta", replace 

*** Append Unmatched Job Postings if Needed ***
if `merge_2_exists' {
    use `available_groups', clear
    merge 1:1 country new_group resume_no using `unmatched_tasks'
    
    *** Ensure only merged observations are kept after appending ***
    keep if _merge == 3
    drop _merge
    append using "$output_file.dta"
    save "$output_file.dta", replace
}


*********************************************
*** Generating a Useable Dataset for VA's ***
*********************************************

*** Importing Indeed Login Info ***
	import excel "/Users/codyw/Desktop/web_scraper/email_aliases.xlsx", first clear
	rename Name name
	drop AliasEmail
	rename AliasPassword indeed_password
	rename IndeedAccountCreated indeed_email
	tempfile email_aliases
	save `email_aliases'

*** Import Dataset ***
	use $output_file, clear 

*** Generating a Variable for Years of Experience ***
	gen experience = 0 
	replace experience = 2 if years == 1
	replace experience = 4 if years == 2
	
*** Keep Necessary Variables 
	keep country group race resume_no name race_name external_apply experience 

*** Merging with Alias Data ***
	merge n:1 name using `email_aliases', nogenerate 

*** Generating Other Necessary Variables ***
	foreach i in incomplete_application application_date responded test_requested rejected {
		gen `i' = ""
	}

*** Sorting the Data ***
	gsort -country race name 
	
*** Dropping Final Variable ***
	drop race

*** Ordering the Data ***
	order country group resume_no race_name name indeed_email indeed_password external_apply experience 
	
*** Exporting the File Excel ***
	export excel "/Users/codyw/Desktop/web_scraper/Data/$output_file.xlsx", firstrow(variables) replace 
