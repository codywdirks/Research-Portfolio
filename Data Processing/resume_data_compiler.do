*********************************************** 
************ Resume Master Dataset ************
***********************************************

************* User Input Section *************
* Define US and CA specific parameters here *
local US_dir "/Users/codyw/Desktop/web_scraper/resumes_10_21_2024"
local CA_dir "/Users/codyw/Desktop/web_scraper/resumes_10_21_2024"
local US_seq "2024-10-21-13-18-42"  // US sequence (adjust this for new sequence)
local CA_seq "2024-10-21-13-18-05"  // CA sequence (adjust this for new sequence)
local n_groups 2000  // Number of groups
local n_members 3    // Number of members in each group
***********************************************

*********************
****** US Loop ******
*********************

*** Set Working Directory ***
	cd "`US_dir'"

*** Generating the Base Dataset ***
	clear 
	gen name_no = .
	save "US_resume_data_for_national_correspondence_study.dta", replace

********************************
*** Building the Loop for US ***
********************************

	forvalues x = 1/`n_groups' {  // Loop for US groups
		forvalues member = 1/`n_members' {  // Loop for members
        
			local group = string(`x', "%04.0f")  // Format group values to four digits
        
			*** Import Data ***
			import delimited using "RR_US_`US_seq'_`group'_`member'of`n_members'.csv", clear
        
			*** Data Cleaning ***
			drop filename numberofbatches numberofresumesperbatch yearmonthdayhourminutesecond v1_16
			rename batch group 
			rename resume resume_no
			rename v1_1 race 
			rename v1_4 university 
			rename v1_5 years
			rename v1_6 gpa 
			rename v1_8 residency_status
			rename v1_11 work_experience
			rename v1_12 work_experience_previous_2021
			rename v1_13 work_experience_previous_2020
			rename v1_19 skill_type
			rename v1_21 languages
        
			*** Names by Race ***
			forvalues n = 1/8 {
				capture confirm variable v1_1_`n'
				if _rc == 0 {
					rename v1_1_`n' name_no
				} 
			}
        
			*** GPA ***
			forvalues g = 1/2 {
				capture confirm variable v1_6_`g'
				if _rc == 0 {
					rename v1_6_`g' gpa_value
				}
			}
        
			*** Work Experience Current ***
			capture confirm variable v1_11_1_iter2023
			if _rc == 0 {
				rename v1_11_1_iter2023 work_experience_current
			}
        
			*** Work Experience 2021 ***
			capture confirm variable v1_12_1
			if _rc == 0 {
				rename v1_12_1 work_experience_2021
			}

			*** Work Experience 2020 ***
			capture confirm variable v1_13_1_iter2022
			if _rc == 0 {
				rename v1_13_1_iter2022 work_experience_2020
			}

			*** Skillsets ***
			forvalues s = 1/2 {
				capture confirm variable v1_19_`s'
				if _rc == 0 {
					rename v1_19_`s' skills_list
				}
			}
        
			*** Adding Country ***
			gen country = "US"
        
		
			*** Adding Names ***
			gen name = ""
		
			*** Group 1 - White Names ***
			replace name = "Thomas Wagner" if race == 1 & name_no == 1
			replace name = "Richard Hoffman" if race == 1 & name_no == 2
			replace name = "David Hansen" if race == 1 & name_no == 3
			replace name = "Zachary Meyer" if race == 1 & name_no == 4
			replace name = "Hunter McGrath" if race == 1 & name_no == 5
			replace name = "Logan Becker" if race == 1 & name_no == 6
			replace name = "Ryan Andersen" if race == 1 & name_no == 7
			replace name = "Matthew Larsen" if race == 1 & name_no == 8
			
			*** Group 2 - White Names (Group 2) ***
			replace name = "Thomas Wagner" if race == 2 & name_no == 1
			replace name = "Richard Hoffman" if race == 2 & name_no == 2
			replace name = "David Hansen" if race == 2 & name_no == 3
			replace name = "Zachary Meyer" if race == 2 & name_no == 4
			replace name = "Hunter McGrath" if race == 2 & name_no == 5
			replace name = "Logan Becker" if race == 2 & name_no == 6
			replace name = "Ryan Andersen" if race == 2 & name_no == 7
			replace name = "Matthew Larsen" if race == 2 & name_no == 8
			
			*** Group 3 - Chinese Names ***
			replace name = "Mao Zhang" if race == 3 & name_no == 1
			replace name = "Jin Chang" if race == 3 & name_no == 2
			replace name = "Peng Chen" if race == 3 & name_no == 3
			replace name = "Wei Li" if race == 3 & name_no == 4
			replace name = "Jian Liu" if race == 3 & name_no == 5
			replace name = "Lixin Yang" if race == 3 & name_no == 6
			replace name = "Qian Wang" if race == 3 & name_no == 7
			replace name = "Hong Zhao" if race == 3 & name_no == 8
			
			*** Group 4 - Indian Names ***
			replace name = "Aditya Kumar" if race == 4 & name_no == 1
			replace name = "Sanjay Shah" if race == 4 & name_no == 2
			replace name = "Avi Patel" if race == 4 & name_no == 3
			replace name = "Rakesh Agarwal" if race == 4 & name_no == 4
			replace name = "Deepak Patil" if race == 4 & name_no == 5
			replace name = "Amir Singh" if race == 4 & name_no == 6
			replace name = "Zahir Devi" if race == 4 & name_no == 7
			replace name = "Kamal Das" if race == 4 & name_no == 8
			
			*** Group 5 - Hispanic Names ***
			replace name = "Julio Perez" if race == 5 & name_no == 1
			replace name = "Javier Martinez" if race == 5 & name_no == 2
			replace name = "Alejandro Ramirez" if race == 5 & name_no == 3
			replace name = "Hector Gonzalez" if race == 5 & name_no == 4
			replace name = "Miguel Lopez" if race == 5 & name_no == 5
			replace name = "Salvador Ramirez" if race == 5 & name_no == 6
			replace name = "Juan Torres" if race == 5 & name_no == 7
			replace name = "Pedro Hernandez" if race == 5 & name_no == 8
			
			*** Group 6 - White-Sounding Chinese Names ***
			replace name = "Thomas Zhang" if race == 6 & name_no == 1
			replace name = "Richard Chang" if race == 6 & name_no == 2
			replace name = "David Chen" if race == 6 & name_no == 3
			replace name = "Zachary Li" if race == 6 & name_no == 4
			replace name = "Hunter Liu" if race == 6 & name_no == 5
			replace name = "Logan Yang" if race == 6 & name_no == 6
			replace name = "Ryan Wang" if race == 6 & name_no == 7
			replace name = "Matthew Zhao" if race == 6 & name_no == 8
			
			*** Group 7 - White-Sounding Indian Names ***
			replace name = "Thomas Kumar" if race == 7 & name_no == 1
			replace name = "Richard Shah" if race == 7 & name_no == 2
			replace name = "David Patel" if race == 7 & name_no == 3
			replace name = "Zachary Agarwal" if race == 7 & name_no == 4
			replace name = "Hunter Patil" if race == 7 & name_no == 5
			replace name = "Logan Singh" if race == 7 & name_no == 6
			replace name = "Ryan Devi" if race == 7 & name_no == 7
			replace name = "Matthew Das" if race == 7 & name_no == 8
			
			*** Group 8 - White-Sounding Hispanic Names ***
			replace name = "Thomas Perez" if race == 8 & name_no == 1
			replace name = "Richard Martinez" if race == 8 & name_no == 2
			replace name = "David Ramirez" if race == 8 & name_no == 3
			replace name = "Zachary Gonzalez" if race == 8 & name_no == 4
			replace name = "Hunter Lopez" if race == 8 & name_no == 5
			replace name = "Logan Ramirez" if race == 8 & name_no == 6
			replace name = "Ryan Torres" if race == 8 & name_no == 7
			replace name = "Matthew Hernandez" if race == 8 & name_no == 8
			
			*** Generating Race Name for VA Search ***
			gen race_name = ""
			replace race_name = "White" if race == 1 | race == 2 
			replace race_name = "Chinese" if race == 3
			replace race_name = "Indian" if race == 4
			replace race_name = "Hispanic" if race == 5
			replace race_name = "Chinese White-Sounding" if race == 6
			replace race_name = "Indian White-Sounding" if race == 7
			replace race_name = "Hispanic White-Sounding" if race == 8
			
			*** Generating In Task Variable for Compiler ***
			gen in_task = 0
			
			*** Append and Save Dataset ***
			append using "US_resume_data_for_national_correspondence_study.dta"
			save "US_resume_data_for_national_correspondence_study.dta", replace
			
		
		}
	}

	*** Save final US data ***
	save "`US_dir'/US_resume_data_for_national_correspondence_study.dta", replace

*************************
****** Canada Loop ******
*************************

*** Set Working Directory ***
	cd "`CA_dir'"

*** Generating the Base Dataset ***
	clear 
	gen name_no = .
	save "CA_resume_data_for_national_correspondence_study.dta", replace

************************************
*** Building the Loop for Canada ***
************************************

	forvalues x = 1/`n_groups' {  // Loop for Canada groups
		forvalues member = 1/`n_members' {  // Loop for members
			
			local group = string(`x', "%04.0f")  // Format group values to four digits
			
			*** Import Data ***
			import delimited using "RR_CA_`CA_seq'_`group'_`member'of`n_members'.csv", clear
			
			*** Data Cleaning ***
			drop filename numberofbatches numberofresumesperbatch yearmonthdayhourminutesecond v1_16
			rename batch group 
			rename resume resume_no
			rename v1_1 race 
			rename v1_4 university 
			rename v1_5 years
			rename v1_6 gpa 
			rename v1_8 residency_status
			rename v1_11 work_experience
			rename v1_12 work_experience_previous_2021
			rename v1_13 work_experience_previous_2020
			rename v1_19 skill_type
			rename v1_21 languages
			
			*** Names by Race ***
			forvalues n = 1/8 {
				capture confirm variable v1_1_`n'
				if _rc == 0 {
					rename v1_1_`n' name_no
				}
			}
			
			*** GPA ***
			forvalues g = 1/2 {
				capture confirm variable v1_6_`g'
				if _rc == 0 {
					rename v1_6_`g' gpa_value
				}
			}

			*** Work Experience Current ***
			capture confirm variable v1_11_1_iter2023
			if _rc == 0 {
				rename v1_11_1_iter2023 work_experience_current
			}

			*** Work Experience 2021 ***
			capture confirm variable v1_12_1
			if _rc == 0 {
				rename v1_12_1 work_experience_2021
			}

			*** Work Experience 2020 ***
			capture confirm variable v1_13_1_iter2022
			if _rc == 0 {
				rename v1_13_1_iter2022 work_experience_2020
			}

			*** Skillsets ***
			forvalues s = 1/2 {
				capture confirm variable v1_19_`s'
				if _rc == 0 {
					rename v1_19_`s' skills_list
				}
			}
			
			*** Adding Country ***
			gen country = "CA"
			
			*** Adding Names ***
			gen name = ""
			
			*** Group 1 - White Names ***
			replace name = "Thomas Wagner" if race == 1 & name_no == 1
			replace name = "Richard Hoffman" if race == 1 & name_no == 2
			replace name = "David Hansen" if race == 1 & name_no == 3
			replace name = "Zachary Meyer" if race == 1 & name_no == 4
			replace name = "Hunter McGrath" if race == 1 & name_no == 5
			replace name = "Logan Becker" if race == 1 & name_no == 6
			replace name = "Ryan Andersen" if race == 1 & name_no == 7
			replace name = "Matthew Larsen" if race == 1 & name_no == 8
			
			*** Group 2 - White Names (Group 2) ***
			replace name = "Thomas Wagner" if race == 2 & name_no == 1
			replace name = "Richard Hoffman" if race == 2 & name_no == 2
			replace name = "David Hansen" if race == 2 & name_no == 3
			replace name = "Zachary Meyer" if race == 2 & name_no == 4
			replace name = "Hunter McGrath" if race == 2 & name_no == 5
			replace name = "Logan Becker" if race == 2 & name_no == 6
			replace name = "Ryan Andersen" if race == 2 & name_no == 7
			replace name = "Matthew Larsen" if race == 2 & name_no == 8
			
			*** Group 3 - Chinese Names ***
			replace name = "Mao Zhang" if race == 3 & name_no == 1
			replace name = "Jin Chang" if race == 3 & name_no == 2
			replace name = "Peng Chen" if race == 3 & name_no == 3
			replace name = "Wei Li" if race == 3 & name_no == 4
			replace name = "Jian Liu" if race == 3 & name_no == 5
			replace name = "Lixin Yang" if race == 3 & name_no == 6
			replace name = "Qian Wang" if race == 3 & name_no == 7
			replace name = "Hong Zhao" if race == 3 & name_no == 8
			
			*** Group 4 - Indian Names ***
			replace name = "Aditya Kumar" if race == 4 & name_no == 1
			replace name = "Sanjay Shah" if race == 4 & name_no == 2
			replace name = "Avi Patel" if race == 4 & name_no == 3
			replace name = "Rakesh Agarwal" if race == 4 & name_no == 4
			replace name = "Deepak Patil" if race == 4 & name_no == 5
			replace name = "Amir Singh" if race == 4 & name_no == 6
			replace name = "Zahir Devi" if race == 4 & name_no == 7
			replace name = "Kamal Das" if race == 4 & name_no == 8
			
			*** Group 5 - Hispanic Names ***
			replace name = "Julio Perez" if race == 5 & name_no == 1
			replace name = "Javier Martinez" if race == 5 & name_no == 2
			replace name = "Alejandro Ramirez" if race == 5 & name_no == 3
			replace name = "Hector Gonzalez" if race == 5 & name_no == 4
			replace name = "Miguel Lopez" if race == 5 & name_no == 5
			replace name = "Salvador Ramirez" if race == 5 & name_no == 6
			replace name = "Juan Torres" if race == 5 & name_no == 7
			replace name = "Pedro Hernandez" if race == 5 & name_no == 8
			
			*** Group 6 - White-Sounding Chinese Names ***
			replace name = "Thomas Zhang" if race == 6 & name_no == 1
			replace name = "Richard Chang" if race == 6 & name_no == 2
			replace name = "David Chen" if race == 6 & name_no == 3
			replace name = "Zachary Li" if race == 6 & name_no == 4
			replace name = "Hunter Liu" if race == 6 & name_no == 5
			replace name = "Logan Yang" if race == 6 & name_no == 6
			replace name = "Ryan Wang" if race == 6 & name_no == 7
			replace name = "Matthew Zhao" if race == 6 & name_no == 8
			
			*** Group 7 - White-Sounding Indian Names ***
			replace name = "Thomas Kumar" if race == 7 & name_no == 1
			replace name = "Richard Shah" if race == 7 & name_no == 2
			replace name = "David Patel" if race == 7 & name_no == 3
			replace name = "Zachary Agarwal" if race == 7 & name_no == 4
			replace name = "Hunter Patil" if race == 7 & name_no == 5
			replace name = "Logan Singh" if race == 7 & name_no == 6
			replace name = "Ryan Devi" if race == 7 & name_no == 7
			replace name = "Matthew Das" if race == 7 & name_no == 8
			
			*** Group 8 - White-Sounding Hispanic Names ***
			replace name = "Thomas Perez" if race == 8 & name_no == 1
			replace name = "Richard Martinez" if race == 8 & name_no == 2
			replace name = "David Ramirez" if race == 8 & name_no == 3
			replace name = "Zachary Gonzalez" if race == 8 & name_no == 4
			replace name = "Hunter Lopez" if race == 8 & name_no == 5
			replace name = "Logan Ramirez" if race == 8 & name_no == 6
			replace name = "Ryan Torres" if race == 8 & name_no == 7
			replace name = "Matthew Hernandez" if race == 8 & name_no == 8
			
			*** Generating Race Name for VA Search ***
			gen race_name = ""
			replace race_name = "White" if race == 1 | race == 2 
			replace race_name = "Chinese" if race == 3
			replace race_name = "Indian" if race == 4
			replace race_name = "Hispanic" if race == 5
			replace race_name = "Chinese White-Sounding" if race == 6
			replace race_name = "Indian White-Sounding" if race == 7
			replace race_name = "Hispanic White-Sounding" if race == 8
			
			*** Generating In Task Variable for Compiler ***
			gen in_task = 0
			
			*** Append and Save Dataset ***
			append using "CA_resume_data_for_national_correspondence_study.dta"
			save "CA_resume_data_for_national_correspondence_study.dta", replace
		}
	}

*** Save final Canada data ***
	save "`CA_dir'/CA_resume_data_for_national_correspondence_study.dta", replace

*** Save Combined Data ***
	clear
	append using "`US_dir'/US_resume_data_for_national_correspondence_study.dta"
	append using "`CA_dir'/CA_resume_data_for_national_correspondence_study.dta"
	save "/Users/codyw/Desktop/web_scraper/Data/resume_data_for_national_correspondence_study.dta", replace
