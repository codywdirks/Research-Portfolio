*********************************
****** The Do File of Fate ******
*********************************

*** Change Directory ***
	*cd "E:\Research Papers\RBG3 Paper\data"
	cd "/Volumes/Samsung USB/Research Papers/RBG3 Paper/data"
	
*** Import Data ***
	use rbg3_master_data, clear 
	
*****************************
****** Final Data Prep ******
*****************************

*** Cleaing some Data ***
	forvalues x = 1/3{
		drop if grade == "Grade `x'"
	}
	forvalues x = 5/7{
		drop if grade == "Grade `x'"
	}
	forvalues x = 9/13{
		drop if grade == "Grade `x'"
	}
	foreach x in PK KG{
		drop if grade == "`x'"
	}
	forvalues x = 1/3{
		drop if grade == "Grade 0`x'"
	}
	forvalues x = 5/7{
		drop if grade == "Grade 0`x'"
	}
	drop if grade == "Grade 09"
	
	drop if grade == "No Category Codes"
	drop if grade == "A"
	tab grade 
	
	drop if st == "NA"
	drop if grade == "Grade 8"
	
	forvalues x = 1/50{
	gen rbg3_flag_`x' = 0 
	replace rbg3_flag_`x' = 1 if rbg3 == 1 
	replace rbg3_flag_`x' = 0 if stateid == `x'
	}
	
	drop if year == 2022
	save rbg3_data, replace 

	

******************************************************************
****** Synthetic Control Method (Nevada + Synthetic Nevada) ******
******************************************************************

**************
*** Nevada ***
**************
	use rbg3_data, clear 
	drop if rbg3_flag_33 == 1 
	tsset stateid year 
	#delimit
	synth score_np score_np(2005) score_np(2007) score_np(2009) score_np(2011) score_np(2013) score_np(2015)
	per_white per_asian per_black per_hispanic per_native pps,
	trunit(33) xperiod (2005(2)2017) trperiod(2017) nested allopt
	keep(synth_rbg3_33_33.dta, replace);
	#delimit cr

***********************
*** Graphing Nevada ***
***********************
	use synth_rbg3_33_33, clear 
	twoway(line _Y_treated _time, lwidth(medthick) lcolor(black) xline(1988, lpattern(dot) lwidth(medthick) lcolor(black))) (line _Y_synthetic _time, lwidth(medthick) lpattern(dash) lcolor(black)),legend(lab(1 "Nevada") lab(2 "Synthetic Nevada") size(medsmall) pos(1) ring(0) cols(1)) xtitle("Year") xline(2017) xlab(2005[2]2019) ytitle("NRP Score") graphregion(color(white)) bgcolor(white) plotregion(color(white))
	
**********************
*** Control States ***
**********************

*** Alabama ***
	use rbg3_data, clear 
	drop if rbg3_flag_33 == 1
	tsset stateid year 
	#delimit
	synth score_np score_np(2005) score_np(2007) score_np(2009) score_np(2011) score_np(2013) score_np(2015)
	per_white per_asian per_black per_hispanic per_native pps,
	trunit(1) xperiod (2005(2)2015) trperiod(2017) 
	keep(synth_rbg3_1_33.dta, replace);
	#delimit cr

*** California ***
	use rbg3_data, clear 
	drop if rbg3_flag_33 == 1
	tsset stateid year 
	#delimit
	synth score_np score_np(2005) score_np(2007) score_np(2009) score_np(2011) score_np(2013) score_np(2015)
	per_white per_asian per_black per_hispanic per_native pps,
	trunit(4) xperiod (2005(2)2015) trperiod(2017) 
	keep(synth_rbg3_4_33.dta, replace);
	#delimit cr

*** Washington DC ***
	use rbg3_data, clear 
	drop if rbg3_flag_33 == 1
	tsset stateid year 
	#delimit
	synth score_np score_np(2005) score_np(2007) score_np(2009) score_np(2011) score_np(2013) score_np(2015)
	per_white per_asian per_black per_hispanic per_native pps,
	trunit(7) xperiod (2005(2)2015) trperiod(2017) 
	keep(synth_rbg3_7_33.dta, replace);
	#delimit cr

*** Idaho ***
	use rbg3_data, clear 
	drop if rbg3_flag_33 == 1
	tsset stateid year 
	#delimit
	synth score_np score_np(2005) score_np(2007) score_np(2009) score_np(2011) score_np(2013) score_np(2015)
	per_white per_asian per_black per_hispanic per_native pps,
	trunit(12) xperiod (2005(2)2015) trperiod(2017) 
	keep(synth_rbg3_12_33.dta, replace);
	#delimit cr


*** Illinois ***
	use rbg3_data, clear 
	drop if rbg3_flag_33 == 1
	tsset stateid year 
	#delimit
	synth score_np score_np(2005) score_np(2007) score_np(2009) score_np(2011) score_np(2013) score_np(2015)
	per_white per_asian per_black per_hispanic per_native pps,
	trunit(13) xperiod (2005(2)2015) trperiod(2017)
	keep(synth_rbg3_13_33.dta, replace);
	#delimit cr

*** Kansas ***
	use rbg3_data, clear 
	drop if rbg3_flag_33 == 1
	tsset stateid year 
	#delimit
	synth score_np score_np(2005) score_np(2007) score_np(2009) score_np(2011) score_np(2013) score_np(2015)
	per_white per_asian per_black per_hispanic per_native pps,
	trunit(15) xperiod (2005(2)2015) trperiod(2017) 
	keep(synth_rbg3_15_33.dta, replace);
	#delimit cr

*** Kentucky ***
	use rbg3_data, clear 
	drop if rbg3_flag_33 == 1
	tsset stateid year 
	#delimit
	synth score_np score_np(2005) score_np(2007) score_np(2009) score_np(2011) score_np(2013) score_np(2015)
	per_white per_asian per_black per_hispanic per_native pps,
	trunit(16) xperiod (2005(2)2015) trperiod(2017) 
	keep(synth_rbg3_16_33.dta, replace);
	#delimit cr


*** Louisiana ***
	use rbg3_data, clear 
	drop if rbg3_flag_33 == 1
	tsset stateid year 
	#delimit
	synth score_np score_np(2005) score_np(2007) score_np(2009) score_np(2011) score_np(2013) score_np(2015)
	per_white per_asian per_black per_hispanic per_native pps,
	trunit(17) xperiod (2005(2)2015) trperiod(2017)
	keep(synth_rbg3_17_33.dta, replace);
	#delimit cr

*** Montana ***
	use rbg3_data, clear 
	drop if rbg3_flag_33 == 1
	tsset stateid year 
	#delimit
	synth score_np score_np(2005) score_np(2007) score_np(2009) score_np(2011) score_np(2013) score_np(2015)
	per_white per_asian per_black per_hispanic per_native pps,
	trunit(25) xperiod (2005(2)2015) trperiod(2017)
	keep(synth_rbg3_25_33.dta, replace);
	#delimit cr

*** North Dakota, Nebraska, New Hampshire, New Jersey, & New Mexico ***
	forvalues x = 28/32{
	use rbg3_data, clear 
	drop if rbg3_flag_33 == 1
	tsset stateid year 
	#delimit
	synth score_np score_np(2005) score_np(2007) score_np(2009) score_np(2011) score_np(2013) score_np(2015)
	per_white per_asian per_black per_hispanic per_native pps,
	trunit(`x') xperiod (2005(2)2015) trperiod(2017) 
	keep(synth_rbg3_`x'_33.dta, replace);
	#delimit cr
	}

*** Oregon, Pennsylvania, & Rhode Island ***
	forvalues x = 37/39{
	use rbg3_data, clear 
	drop if rbg3_flag_33 == 1
	tsset stateid year 
	#delimit
	synth score_np score_np(2005) score_np(2007) score_np(2009) score_np(2011) score_np(2013) score_np(2015)
	per_white per_asian per_black per_hispanic per_native pps,
	trunit(`x') xperiod (2005(2)2015) trperiod(2017) 
	keep(synth_rbg3_`x'_33.dta, replace);
	#delimit cr
	}

*** South Dakota ***
	use rbg3_data, clear 
	drop if rbg3_flag_33 == 1
	tsset stateid year 
	#delimit
	synth score_np score_np(2005) score_np(2007) score_np(2009) score_np(2011) score_np(2013) score_np(2015)
	per_white per_asian per_black per_hispanic per_native pps,
	trunit(41) xperiod (2005(2)2015) trperiod(2017)
	keep(synth_rbg3_41_33.dta, replace);
	#delimit cr
	
*** Texas, Utah, Virginia, & Vermont ***
	forvalues x = 43/46{
	use rbg3_data, clear 
	drop if rbg3_flag_33 == 1
	tsset stateid year 
	#delimit
	synth score_np score_np(2005) score_np(2007) score_np(2009) score_np(2011) score_np(2013) score_np(2015)
	per_white per_asian per_black per_hispanic per_native pps,
	trunit(`x') xperiod (2005(2)2015) trperiod(2017) 
	keep(synth_rbg3_`x'_33.dta, replace);
	#delimit cr
	}
	
*** Wisconsin ***
	use rbg3_data, clear 
	drop if rbg3_flag_33 == 1
	tsset stateid year 
	#delimit
	synth score_np score_np(2005) score_np(2007) score_np(2009) score_np(2011) score_np(2013) score_np(2015)
	per_white per_asian per_black per_hispanic per_native pps,
	trunit(48) xperiod (2005(2)2015) trperiod(2017)
	keep(synth_rbg3_48_33.dta, replace);
	#delimit cr

*** Wyoming ***
	use rbg3_data, clear 
	drop if rbg3_flag_33 == 1
	tsset stateid year 
	#delimit
	synth score_np score_np(2005) score_np(2007) score_np(2009) score_np(2011) score_np(2013) score_np(2015)
	per_white per_asian per_black per_hispanic per_native pps,
	trunit(50) xperiod (2005(2)2015) trperiod(2017)
	keep(synth_rbg3_50_33.dta, replace);
	#delimit cr
	
****************************************
****** Infrence and Interpretaion ******
****************************************
	
*** Edit and Merge Dataset ***

*** Nevada ***
	use synth_rbg3_33_33, clear
	rename _time year
	rename _Y_synthetic _Y_synthetic_33
	rename _Y_treated _Y_treated_33
	gen alpha33 = _Y_treated - _Y_synthetic 
	keep alpha33 _Y_* year 
	drop if missing(year)
	save synth_results_33_33, replace 
	
*** Alabama ***
	use synth_rbg3_1_33, clear
	rename _time year
	rename _Y_synthetic _Y_synthetic_1
	rename _Y_treated _Y_treated_1
	gen alpha1 = _Y_treated - _Y_synthetic 
	keep alpha1 _Y_* year 
	drop if missing(year)
	merge 1:1 year using synth_results_33_33, nogenerate
	save synth_results_33_33, replace

*** California ***
	use synth_rbg3_4_33, clear
	rename _time year
	rename _Y_synthetic _Y_synthetic_4
	rename _Y_treated _Y_treated_4
	gen alpha4 = _Y_treated - _Y_synthetic 
	keep alpha4 _Y_* year 
	drop if missing(year)
	merge 1:1 year using synth_results_33_33, nogenerate
	save synth_results_33_33, replace
	
*** Washington DC ***
	use synth_rbg3_7_33, clear
	rename _time year
	rename _Y_synthetic _Y_synthetic_7
	rename _Y_treated _Y_treated_7
	gen alpha7 = _Y_treated - _Y_synthetic 
	keep alpha7 _Y_* year 
	drop if missing(year)
	merge 1:1 year using synth_results_33_33, nogenerate
	save synth_results_33_33, replace

	
*** Idhao & Illinois ***
	forvalues x = 12/13{
	use synth_rbg3_`x'_33, clear
	rename _time year
	rename _Y_synthetic _Y_synthetic_`x'
	rename _Y_treated _Y_treated_`x'
	gen alpha`x' = _Y_treated - _Y_synthetic 
	keep alpha`x' _Y_* year 
	drop if missing(year)
	merge 1:1 year using synth_results_33_33, nogenerate
	save synth_results_33_33, replace
	}
	
*** Kansas, Kentucky, & Louisiana ***
	forvalues x = 15/17{
	use synth_rbg3_`x'_33, clear
	rename _time year
	rename _Y_synthetic _Y_synthetic_`x'
	rename _Y_treated _Y_treated_`x'
	gen alpha`x' = _Y_treated - _Y_synthetic 
	keep alpha`x' _Y_* year 
	drop if missing(year)
	merge 1:1 year using synth_results_33_33, nogenerate
	save synth_results_33_33, replace
	}
	
*** Montana ***
	use synth_rbg3_25_33, clear
	rename _time year
	rename _Y_synthetic _Y_synthetic_25
	rename _Y_treated _Y_treated_25
	gen alpha25 = _Y_treated - _Y_synthetic 
	keep alpha25 _Y_* year 
	drop if missing(year)
	merge 1:1 year using synth_results_33_33, nogenerate
	save synth_results_33_33, replace
	
*** North Dakota, Nebraska, New Hampshire, New Jersey, New Mexico ***
	forvalues x = 28/32{
	use synth_rbg3_`x'_33, clear
	rename _time year
	rename _Y_synthetic _Y_synthetic_`x'
	rename _Y_treated _Y_treated_`x'
	gen alpha`x' = _Y_treated - _Y_synthetic 
	keep alpha`x' _Y_* year 
	drop if missing(year)
	merge 1:1 year using synth_results_33_33, nogenerate
	save synth_results_33_33, replace
	}

	
*** Oregon, Pennsylvania, & Rhode Island ***
	forvalues x = 37/39{
	use synth_rbg3_`x'_33, clear
	rename _time year
	rename _Y_synthetic _Y_synthetic_`x'
	rename _Y_treated _Y_treated_`x'
	gen alpha`x' = _Y_treated - _Y_synthetic 
	keep alpha`x' _Y_* year 
	drop if missing(year)
	merge 1:1 year using synth_results_33_33, nogenerate
	save synth_results_33_33, replace
	}
	
*** South Dakota ***
	use synth_rbg3_41_33, clear
	rename _time year
	rename _Y_synthetic _Y_synthetic_41
	rename _Y_treated _Y_treated_41
	gen alpha41 = _Y_treated - _Y_synthetic 
	keep alpha41 _Y_* year 
	drop if missing(year)
	merge 1:1 year using synth_results_33_33, nogenerate
	save synth_results_33_33, replace

	
*** Texas, Utah, Virginia, & Vermont ***
	forvalues x = 43/46{
	use synth_rbg3_`x'_33, clear
	rename _time year
	rename _Y_synthetic _Y_synthetic_`x'
	rename _Y_treated _Y_treated_`x'
	gen alpha`x' = _Y_treated - _Y_synthetic 
	keep alpha`x' _Y_* year 
	drop if missing(year)
	merge 1:1 year using synth_results_33_33, nogenerate
	save synth_results_33_33, replace
	}
	
*** Wisconsin ***
	use synth_rbg3_48_33, clear
	rename _time year
	rename _Y_synthetic _Y_synthetic_48
	rename _Y_treated _Y_treated_48
	gen alpha48 = _Y_treated - _Y_synthetic 
	keep alpha48 _Y_* year 
	drop if missing(year)
	merge 1:1 year using synth_results_33_33, nogenerate
	save synth_results_33_33, replace


*** Wyoming ***
	use synth_rbg3_50_33, clear
	rename _time year
	rename _Y_synthetic _Y_synthetic_50
	rename _Y_treated _Y_treated_50
	gen alpha50 = _Y_treated - _Y_synthetic 
	keep alpha50 _Y_* year 
	drop if missing(year)
	merge 1:1 year using synth_results_33_33, nogenerate
	save synth_results_33_33, replace

	
*** Restructure Dataset ***
	use synth_results_33_33, clear 
	keep alpha* year 
	reshape long alpha, i(year) j(state)

*** Graphing the Synthetic Control ***
	use synth_results_33_33, clear 
	keep alpha* year 
	reshape long alpha, i(year) j(state)
	
    
	twoway (line alpha year if state == 1, lcolor(gs10)) (line alpha year if state == 4, lcolor(gs10)) (line alpha year if state == 7, lcolor(gs10))(line alpha year if state == 12, lcolor(gs10)) (line alpha year if state == 13, lcolor(gs10)) (line alpha year if state == 15, lcolor(gs10)) (line alpha year if state == 16, lcolor(gs10)) (line alpha year if state == 17, lcolor(gs10)) (line alpha year if state == 25, lcolor(gs10)) (line alpha year if state == 28, lcolor(gs10)) (line alpha year if state == 29, lcolor(gs10)) (line alpha year if state == 30, lcolor(gs10)) (line alpha year if state == 31, lcolor(gs10)) (line alpha year if state == 32, lcolor(gs10)) (line alpha year if state == 37, lcolor(gs10)) (line alpha year if state == 38, lcolor(gs10)) (line alpha year if state == 39, lcolor(gs10)) (line alpha year if state == 41, lcolor(gs10)) (line alpha year if state == 43, lcolor(gs10)) (line alpha year if state == 44, lcolor(gs10)) (line alpha year if state == 45, lcolor(gs10)) (line alpha year if state == 46, lcolor(gs10)) (line alpha year if state == 48, lcolor(gs10)) (line alpha year if state == 50, lcolor(gs10)) (line alpha year if state == 33, lwidth(thick) lcolor(red)), xlabel(2005(2)2019) leg(lab(33 "Nevada") lab(1 "Control states") size(medsmall) pos(11) order(39 1) ring(0) cols(1)) xtitle("Year") ytitle("Gap in NRP Score")

*** Getting Exact P-Value ***
	use synth_results_33_33, clear   
	reshape long alpha, i(year) j(state)
	gen alphasqrd = alpha * alpha
	bysort state: egen pre_mspe = mean(alphasqrd) if year <= 2015
	bysort state: egen post_mspe = mean(alphasqrd) if year > 2015
	
	sum pre_mspe if state == 1
	replace pre_mspe = r(mean) if state == 1
	sum post_mspe if state == 1
	replace post_mspe = r(mean) if state == 1
	
	sum pre_mspe if state == 7
	replace pre_mspe = r(mean) if state == 7
	sum post_mspe if state == 7
	replace post_mspe = r(mean) if state == 7
	
	sum pre_mspe if state == 4
	replace pre_mspe = r(mean) if state == 4
	sum post_mspe if state == 4
	replace post_mspe = r(mean) if state == 4
	
	forvalues x = 12/13{
	sum pre_mspe if state == `x'
	replace pre_mspe = r(mean) if state == `x'
	sum post_mspe if state == `x'
	replace post_mspe = r(mean) if state == `x'
	}
	forvalues x = 15/17{
	sum pre_mspe if state == `x'
	replace pre_mspe = r(mean) if state == `x'
	sum post_mspe if state == `x'
	replace post_mspe = r(mean) if state == `x'
	}
	
	sum pre_mspe if state == 25
	replace pre_mspe = r(mean) if state == 25
	sum post_mspe if state == 25
	replace post_mspe = r(mean) if state == 25
	
	forvalues x = 28/33{
	sum pre_mspe if state == `x'
	replace pre_mspe = r(mean) if state == `x'
	sum post_mspe if state == `x'
	replace post_mspe = r(mean) if state == `x'
	}
	
	forvalues x = 37/41{
	sum pre_mspe if state == `x'
	replace pre_mspe = r(mean) if state == `x'
	sum post_mspe if state == `x'
	replace post_mspe = r(mean) if state == `x'
	}
	
	sum pre_mspe if state == 41
	replace pre_mspe = r(mean) if state == 41
	sum post_mspe if state == 41
	replace post_mspe = r(mean) if state == 41
	
	forvalues x = 43/46{
	sum pre_mspe if state == `x'
	replace pre_mspe = r(mean) if state == `x'
	sum post_mspe if state == `x'
	replace post_mspe = r(mean) if state == `x'
	}
	
	sum pre_mspe if state == 48
	replace pre_mspe = r(mean) if state == 48
	sum post_mspe if state == 48
	replace post_mspe = r(mean) if state == 48
	
	sum pre_mspe if state == 50
	replace pre_mspe = r(mean) if state == 50
	sum post_mspe if state == 50
	replace post_mspe = r(mean) if state == 50
	
	gen post_pre_ratio = post_mspe/pre_mspe
	duplicates drop state, force 
	
	gsort -post_pre_ratio
	gen rank = _n
	gen pvalue = rank/_N if state == 33
	list pvalue if state == 33

*************************************************************************************
****** COVID Synthetic Control Method (Robustness Check For Post-COVID Results ******
*************************************************************************************
	use rbg3_master_data, clear 
	
*****************************
****** Final Data Prep ******
*****************************

*** Cleaing some Data ***
	forvalues x = 1/3{
		drop if grade == "Grade `x'"
	}
	forvalues x = 5/7{
		drop if grade == "Grade `x'"
	}
	forvalues x = 9/13{
		drop if grade == "Grade `x'"
	}
	foreach x in PK KG{
		drop if grade == "`x'"
	}
	forvalues x = 1/3{
		drop if grade == "Grade 0`x'"
	}
	forvalues x = 5/7{
		drop if grade == "Grade 0`x'"
	}
	drop if grade == "Grade 09"
	
	drop if grade == "No Category Codes"
	drop if grade == "A"
	tab grade 
	
	drop if st == "NA"
	drop if grade == "Grade 8"
	
	forvalues x = 1/50{
	gen rbg3_flag_`x' = 0 
	replace rbg3_flag_`x' = 1 if rbg3 == 1 
	replace rbg3_flag_`x' = 0 if stateid == `x'
	}
	
	save c_rbg3_data, replace 

**************
*** Nevada ***
**************
	use c_rbg3_data, clear 
	drop if rbg3_flag_33 == 1 
	tsset stateid year 
	#delimit
	synth score_np score_np(2005) score_np(2007) score_np(2009) score_np(2011) score_np(2013) score_np(2015)
	score_np per_white per_asian per_black per_hispanic per_native pps,
	trunit(33) xperiod (2005(2)2017) trperiod(2017) nested allopt
	keep(c_synth_rbg3_33_33.dta, replace);
	#delimit cr

***********************
*** Graphing Nevada ***
***********************

*** Percent Proficient ***
use c_synth_rbg3_33_33, clear 
	
	twoway(line _Y_treated _time, lwidth(medthick) lcolor(black) xline(1988, lpattern(dot) lwidth(medthick) lcolor(black))) (line _Y_synthetic _time, lwidth(medthick) lpattern(dash) lcolor(black)),legend(lab(1 "Nevada") lab(2 "Synthetic Nevada") size(medsmall) pos(1) ring(0) cols(1)) xtitle("Year") xline(2017) xlab(2005[2]2019) ytitle("NRP Score") graphregion(color(white)) bgcolor(white) plotregion(color(white))
	
*********************
*** Control States***
*********************

*** Alabama ***
	use c_rbg3_data, clear 
	drop if rbg3_flag_33 == 1
	tsset stateid year 
	#delimit
	synth score_np score_np(2005) score_np(2007) score_np(2009) score_np(2011) score_np(2013) score_np(2015)
	score_np per_white per_asian per_black per_hispanic per_native pps,
	trunit(1) xperiod (2005(2)2015) trperiod(2017) 
	keep(c_synth_rbg3_1_33.dta, replace);
	#delimit cr

*** California ***
	use c_rbg3_data, clear  
	drop if rbg3_flag_33 == 1
	tsset stateid year 
	#delimit
	synth score_np score_np(2005) score_np(2007) score_np(2009) score_np(2011) score_np(2013) score_np(2015)
	score_np per_white per_asian per_black per_hispanic per_native pps,
	trunit(4) xperiod (2005(2)2015) trperiod(2017) 
	keep(c_synth_rbg3_4_33.dta, replace);
	#delimit cr

*** Washington DC ***
	use c_rbg3_data, clear  
	drop if rbg3_flag_33 == 1
	tsset stateid year 
	#delimit
	synth score_np score_np(2005) score_np(2007) score_np(2009) score_np(2011) score_np(2013) score_np(2015)
	score_np per_white per_asian per_black per_hispanic per_native pps,
	trunit(7) xperiod (2005(2)2015) trperiod(2017) 
	keep(c_synth_rbg3_7_33.dta, replace);
	#delimit cr

*** Idaho ***
	use c_rbg3_data, clear  
	drop if rbg3_flag_33 == 1
	tsset stateid year 
	#delimit
	synth score_np score_np(2005) score_np(2007) score_np(2009) score_np(2011) score_np(2013) score_np(2015)
	score_np per_white per_asian per_black per_hispanic per_native pps,
	trunit(12) xperiod (2005(2)2015) trperiod(2017) 
	keep(c_synth_rbg3_12_33.dta, replace);
	#delimit cr


*** Illinois ***
	use c_rbg3_data, clear  
	drop if rbg3_flag_33 == 1
	tsset stateid year 
	#delimit
	synth score_np score_np(2005) score_np(2007) score_np(2009) score_np(2011) score_np(2013) score_np(2015)
	score_np per_white per_asian per_black per_hispanic per_native pps,
	trunit(13) xperiod (2005(2)2015) trperiod(2017)
	keep(c_synth_rbg3_13_33.dta, replace);
	#delimit cr

*** Kansas ***
	use c_rbg3_data, clear 
	drop if rbg3_flag_33 == 1
	tsset stateid year 
	#delimit
	synth score_np score_np(2005) score_np(2007) score_np(2009) score_np(2011) score_np(2013) score_np(2015)
	score_np per_white per_asian per_black per_hispanic per_native pps,
	trunit(15) xperiod (2005(2)2015) trperiod(2017) 
	keep(c_synth_rbg3_15_33.dta, replace);
	#delimit cr

*** Kentucky ***
	use c_rbg3_data, clear  
	drop if rbg3_flag_33 == 1
	tsset stateid year 
	#delimit
	synth score_np score_np(2005) score_np(2007) score_np(2009) score_np(2011) score_np(2013) score_np(2015)
	score_np per_white per_asian per_black per_hispanic per_native pps,
	trunit(16) xperiod (2005(2)2015) trperiod(2017) 
	keep(c_synth_rbg3_16_33.dta, replace);
	#delimit cr


*** Louisiana ***
	use c_rbg3_data, clear  
	drop if rbg3_flag_33 == 1
	tsset stateid year 
	#delimit
	synth score_np score_np(2005) score_np(2007) score_np(2009) score_np(2011) score_np(2013) score_np(2015)
	score_np per_white per_asian per_black per_hispanic per_native pps,
	trunit(17) xperiod (2005(2)2015) trperiod(2017)
	keep(c_synth_rbg3_17_33.dta, replace);
	#delimit cr

*** Montana ***
	use c_rbg3_data, clear  
	drop if rbg3_flag_33 == 1
	tsset stateid year 
	#delimit
	synth score_np score_np(2005) score_np(2007) score_np(2009) score_np(2011) score_np(2013) score_np(2015)
	score_np per_white per_asian per_black per_hispanic per_native pps,
	trunit(25) xperiod (2005(2)2015) trperiod(2017)
	keep(c_synth_rbg3_25_33.dta, replace);
	#delimit cr

*** North Dakota, Nebraska, New Hampshire, New Jersey, & New Mexico ***
	forvalues x = 28/32{
	use c_rbg3_data, clear 
	drop if rbg3_flag_33 == 1
	tsset stateid year 
	#delimit
	synth score_np score_np(2005) score_np(2007) score_np(2009) score_np(2011) score_np(2013) score_np(2015)
	score_np per_white per_asian per_black per_hispanic per_native pps,
	trunit(`x') xperiod (2005(2)2015) trperiod(2017) 
	keep(c_synth_rbg3_`x'_33.dta, replace);
	#delimit cr
	}

*** Oregon, Pennsylvania, & Rhode Island ***
	forvalues x = 37/39{
	use c_rbg3_data, clear  
	drop if rbg3_flag_33 == 1
	tsset stateid year 
	#delimit
	synth score_np score_np(2005) score_np(2007) score_np(2009) score_np(2011) score_np(2013) score_np(2015)
	score_np per_white per_asian per_black per_hispanic per_native pps,
	trunit(`x') xperiod (2005(2)2015) trperiod(2017) 
	keep(c_synth_rbg3_`x'_33.dta, replace);
	#delimit cr
	}

*** South Dakota ***
	use c_rbg3_data, clear  
	drop if rbg3_flag_33 == 1
	tsset stateid year 
	#delimit
	synth score_np score_np(2005) score_np(2007) score_np(2009) score_np(2011) score_np(2013) score_np(2015)
	score_np per_white per_asian per_black per_hispanic per_native pps,
	trunit(41) xperiod (2005(2)2015) trperiod(2017)
	keep(c_synth_rbg3_41_33.dta, replace);
	#delimit cr
	
*** Texas, Utah, Virginia, & Vermont ***
	forvalues x = 43/46{
	use c_rbg3_data, clear 
	drop if rbg3_flag_33 == 1
	tsset stateid year 
	#delimit
	synth score_np score_np(2005) score_np(2007) score_np(2009) score_np(2011) score_np(2013) score_np(2015)
	score_np per_white per_asian per_black per_hispanic per_native pps,
	trunit(`x') xperiod (2005(2)2015) trperiod(2017) 
	keep(c_synth_rbg3_`x'_33.dta, replace);
	#delimit cr
	}
	
*** Wisconsin ***
	use c_rbg3_data, clear  
	drop if rbg3_flag_33 == 1
	tsset stateid year 
	#delimit
	synth score_np score_np(2005) score_np(2007) score_np(2009) score_np(2011) score_np(2013) score_np(2015)
	score_np per_white per_asian per_black per_hispanic per_native pps,
	trunit(48) xperiod (2005(2)2015) trperiod(2017)
	keep(c_synth_rbg3_48_33.dta, replace);
	#delimit cr

*** Wyoming ***
	use c_rbg3_data, clear  
	drop if rbg3_flag_33 == 1
	tsset stateid year 
	#delimit
	synth score_np score_np(2005) score_np(2007) score_np(2009) score_np(2011) score_np(2013) score_np(2015)
	score_np per_white per_asian per_black per_hispanic per_native pps,
	trunit(50) xperiod (2005(2)2015) trperiod(2017)
	keep(c_synth_rbg3_50_33.dta, replace);
	#delimit cr
	
****************************************
****** Infrence and Interpretaion ******
****************************************
	
*** Edit and Merge Dataset ***

*** Nevada ***
	use c_synth_rbg3_33_33, clear
	rename _time year
	rename _Y_synthetic _Y_synthetic_33
	rename _Y_treated _Y_treated_33
	gen alpha33 = _Y_treated - _Y_synthetic 
	keep alpha33 _Y_* year 
	drop if missing(year)
	save c_synth_results_33_33, replace 
	
*** Alabama ***
	use c_synth_rbg3_1_33, clear
	rename _time year
	rename _Y_synthetic _Y_synthetic_1
	rename _Y_treated _Y_treated_1
	gen alpha1 = _Y_treated - _Y_synthetic 
	keep alpha1 _Y_* year 
	drop if missing(year)
	merge 1:1 year using c_synth_results_33_33, nogenerate
	save c_synth_results_33_33, replace

*** California ***
	use c_synth_rbg3_4_33, clear
	rename _time year
	rename _Y_synthetic _Y_synthetic_4
	rename _Y_treated _Y_treated_4
	gen alpha4 = _Y_treated - _Y_synthetic 
	keep alpha4 _Y_* year 
	drop if missing(year)
	merge 1:1 year using c_synth_results_33_33, nogenerate
	save c_synth_results_33_33, replace
	
*** Washington DC ***
	use c_synth_rbg3_7_33, clear
	rename _time year
	rename _Y_synthetic _Y_synthetic_7
	rename _Y_treated _Y_treated_7
	gen alpha7 = _Y_treated - _Y_synthetic 
	keep alpha7 _Y_* year 
	drop if missing(year)
	merge 1:1 year using c_synth_results_33_33, nogenerate
	save c_synth_results_33_33, replace

	
*** Idhao & Illinois ***
	forvalues x = 12/13{
	use c_synth_rbg3_`x'_33, clear
	rename _time year
	rename _Y_synthetic _Y_synthetic_`x'
	rename _Y_treated _Y_treated_`x'
	gen alpha`x' = _Y_treated - _Y_synthetic 
	keep alpha`x' _Y_* year 
	drop if missing(year)
	merge 1:1 year using c_synth_results_33_33, nogenerate
	save c_synth_results_33_33, replace
	}
	
*** Kansas, Kentucky, & Louisiana ***
	forvalues x = 15/17{
	use c_synth_rbg3_`x'_33, clear
	rename _time year
	rename _Y_synthetic _Y_synthetic_`x'
	rename _Y_treated _Y_treated_`x'
	gen alpha`x' = _Y_treated - _Y_synthetic 
	keep alpha`x' _Y_* year 
	drop if missing(year)
	merge 1:1 year using c_synth_results_33_33, nogenerate
	save c_synth_results_33_33, replace
	}
	
*** Montana ***
	use c_synth_rbg3_25_33, clear
	rename _time year
	rename _Y_synthetic _Y_synthetic_25
	rename _Y_treated _Y_treated_25
	gen alpha25 = _Y_treated - _Y_synthetic 
	keep alpha25 _Y_* year 
	drop if missing(year)
	merge 1:1 year using c_synth_results_33_33, nogenerate
	save c_synth_results_33_33, replace
	
*** North Dakota, Nebraska, New Hampshire, New Jersey, New Mexico ***
	forvalues x = 28/32{
	use c_synth_rbg3_`x'_33, clear
	rename _time year
	rename _Y_synthetic _Y_synthetic_`x'
	rename _Y_treated _Y_treated_`x'
	gen alpha`x' = _Y_treated - _Y_synthetic 
	keep alpha`x' _Y_* year 
	drop if missing(year)
	merge 1:1 year using c_synth_results_33_33, nogenerate
	save c_synth_results_33_33, replace
	}

	
*** Oregon, Pennsylvania, & Rhode Island ***
	forvalues x = 37/39{
	use c_synth_rbg3_`x'_33, clear
	rename _time year
	rename _Y_synthetic _Y_synthetic_`x'
	rename _Y_treated _Y_treated_`x'
	gen alpha`x' = _Y_treated - _Y_synthetic 
	keep alpha`x' _Y_* year 
	drop if missing(year)
	merge 1:1 year using c_synth_results_33_33, nogenerate
	save c_synth_results_33_33, replace
	}
	
*** South Dakota ***
	use c_synth_rbg3_41_33, clear
	rename _time year
	rename _Y_synthetic _Y_synthetic_41
	rename _Y_treated _Y_treated_41
	gen alpha41 = _Y_treated - _Y_synthetic 
	keep alpha41 _Y_* year 
	drop if missing(year)
	merge 1:1 year using c_synth_results_33_33, nogenerate
	save c_synth_results_33_33, replace

	
*** Texas, Utah, Virginia, & Vermont ***
	forvalues x = 43/46{
	use c_synth_rbg3_`x'_33, clear
	rename _time year
	rename _Y_synthetic _Y_synthetic_`x'
	rename _Y_treated _Y_treated_`x'
	gen alpha`x' = _Y_treated - _Y_synthetic 
	keep alpha`x' _Y_* year 
	drop if missing(year)
	merge 1:1 year using c_synth_results_33_33, nogenerate
	save c_synth_results_33_33, replace
	}
	
*** Wisconsin ***
	use c_synth_rbg3_48_33, clear
	rename _time year
	rename _Y_synthetic _Y_synthetic_48
	rename _Y_treated _Y_treated_48
	gen alpha48 = _Y_treated - _Y_synthetic 
	keep alpha48 _Y_* year 
	drop if missing(year)
	merge 1:1 year using c_synth_results_33_33, nogenerate
	save c_synth_results_33_33, replace


*** Wyoming ***
	use c_synth_rbg3_50_33, clear
	rename _time year
	rename _Y_synthetic _Y_synthetic_50
	rename _Y_treated _Y_treated_50
	gen alpha50 = _Y_treated - _Y_synthetic 
	keep alpha50 _Y_* year 
	drop if missing(year)
	merge 1:1 year using c_synth_results_33_33, nogenerate
	save c_synth_results_33_33, replace

	
*** Restructure Dataset ***
	use c_synth_results_33_33, clear 
	keep alpha* year 
	reshape long alpha, i(year) j(state)

*** Graphing the Synthetic Control ***
	use c_synth_results_33_33, clear 
	keep alpha* year 
	reshape long alpha, i(year) j(state)
	
	twoway (line alpha year if state == 1, lcolor(gs10)) (line alpha year if state == 4, lcolor(gs10)) (line alpha year if state == 7, lcolor(gs10))(line alpha year if state == 12, lcolor(gs10)) (line alpha year if state == 13, lcolor(gs10)) (line alpha year if state == 15, lcolor(gs10)) (line alpha year if state == 16, lcolor(gs10)) (line alpha year if state == 17, lcolor(gs10)) (line alpha year if state == 25, lcolor(gs10)) (line alpha year if state == 28, lcolor(gs10)) (line alpha year if state == 29, lcolor(gs10)) (line alpha year if state == 30, lcolor(gs10)) (line alpha year if state == 31, lcolor(gs10)) (line alpha year if state == 32, lcolor(gs10)) (line alpha year if state == 37, lcolor(gs10)) (line alpha year if state == 38, lcolor(gs10)) (line alpha year if state == 39, lcolor(gs10)) (line alpha year if state == 41, lcolor(gs10)) (line alpha year if state == 43, lcolor(gs10)) (line alpha year if state == 44, lcolor(gs10)) (line alpha year if state == 45, lcolor(gs10)) (line alpha year if state == 46, lcolor(gs10)) (line alpha year if state == 48, lcolor(gs10)) (line alpha year if state == 50, lcolor(gs10)) (line alpha year if state == 33, lwidth(thick) lcolor(red)), xlabel(2005(2)2023) leg(lab(33 "Nevada") lab(1 "Control states") size(medsmall) pos(11) order(39 1) ring(0) cols(1)) xtitle("Year") ytitle("Gap in NRP Scoer") 

*** Getting Exact P-Value ***
	use c_synth_results_33_33, clear   
	reshape long alpha, i(year) j(state)
	gen alphasqrd = alpha * alpha
	bysort state: egen pre_mspe = mean(alphasqrd) if year <= 2015
	bysort state: egen post_mspe = mean(alphasqrd) if year > 2015
	
	sum pre_mspe if state == 1
	replace pre_mspe = r(mean) if state == 1
	sum post_mspe if state == 1
	replace post_mspe = r(mean) if state == 1
	
	sum pre_mspe if state == 7
	replace pre_mspe = r(mean) if state == 7
	sum post_mspe if state == 7
	replace post_mspe = r(mean) if state == 7
	
	sum pre_mspe if state == 4
	replace pre_mspe = r(mean) if state == 4
	sum post_mspe if state == 4
	replace post_mspe = r(mean) if state == 4
	
	forvalues x = 12/13{
	sum pre_mspe if state == `x'
	replace pre_mspe = r(mean) if state == `x'
	sum post_mspe if state == `x'
	replace post_mspe = r(mean) if state == `x'
	}
	forvalues x = 15/17{
	sum pre_mspe if state == `x'
	replace pre_mspe = r(mean) if state == `x'
	sum post_mspe if state == `x'
	replace post_mspe = r(mean) if state == `x'
	}
	
	sum pre_mspe if state == 25
	replace pre_mspe = r(mean) if state == 25
	sum post_mspe if state == 25
	replace post_mspe = r(mean) if state == 25
	
	forvalues x = 28/33{
	sum pre_mspe if state == `x'
	replace pre_mspe = r(mean) if state == `x'
	sum post_mspe if state == `x'
	replace post_mspe = r(mean) if state == `x'
	}
	
	forvalues x = 37/41{
	sum pre_mspe if state == `x'
	replace pre_mspe = r(mean) if state == `x'
	sum post_mspe if state == `x'
	replace post_mspe = r(mean) if state == `x'
	}
	
	sum pre_mspe if state == 41
	replace pre_mspe = r(mean) if state == 41
	sum post_mspe if state == 41
	replace post_mspe = r(mean) if state == 41
	
	forvalues x = 43/46{
	sum pre_mspe if state == `x'
	replace pre_mspe = r(mean) if state == `x'
	sum post_mspe if state == `x'
	replace post_mspe = r(mean) if state == `x'
	}
	
	sum pre_mspe if state == 48
	replace pre_mspe = r(mean) if state == 48
	sum post_mspe if state == 48
	replace post_mspe = r(mean) if state == 48
	
	sum pre_mspe if state == 50
	replace pre_mspe = r(mean) if state == 50
	sum post_mspe if state == 50
	replace post_mspe = r(mean) if state == 50
	
	gen post_pre_ratio = post_mspe/pre_mspe
	duplicates drop state, force 
	
	gsort -post_pre_ratio
	gen rank = _n
	gen pvalue = rank/_N if state == 33
	list pvalue if state == 33

************************************************************************************
****** MATH Synthetic Control Method (Falsification Test Against Math Scores) ******
************************************************************************************
	use rbg3_master_data, clear 
	
*****************************
****** Final Data Prep ******
*****************************

*** Cleaing some Data ***
	forvalues x = 1/3{
		drop if grade == "Grade `x'"
	}
	forvalues x = 5/7{
		drop if grade == "Grade `x'"
	}
	forvalues x = 9/13{
		drop if grade == "Grade `x'"
	}
	foreach x in PK KG{
		drop if grade == "`x'"
	}
	forvalues x = 1/3{
		drop if grade == "Grade 0`x'"
	}
	forvalues x = 5/7{
		drop if grade == "Grade 0`x'"
	}
	drop if grade == "Grade 09"
	
	drop if grade == "No Category Codes"
	drop if grade == "A"
	tab grade 
	
	drop if st == "NA"
	drop if grade == "Grade 8"
	
	forvalues x = 1/50{
	gen rbg3_flag_`x' = 0 
	replace rbg3_flag_`x' = 1 if rbg3 == 1 
	replace rbg3_flag_`x' = 0 if stateid == `x'
	}
	
	drop if year == 2022
	save m_rbg3_data, replace 

**************
*** Nevada ***
**************
	use m_rbg3_data, clear 
	drop if rbg3_flag_33 == 1 
	tsset stateid year 
	#delimit
	synth m_score_np m_score_np(2005) m_score_np(2007) m_score_np(2009) m_score_np(2011) m_score_np(2013) m_score_np(2015)
	m_score_np per_white per_asian per_black per_hispanic per_native pps,
	trunit(33) xperiod (2005(2)2017) trperiod(2017) nested allopt
	keep(m_synth_rbg3_33_33.dta, replace);
	#delimit cr

***********************
*** Graphing Nevada ***
***********************

*** Percent Proficient ***
use m_synth_rbg3_33_33, clear 
	
	twoway(line _Y_treated _time, lwidth(medthick) lcolor(black) xline(1988, lpattern(dot) lwidth(medthick) lcolor(black))) (line _Y_synthetic _time, lwidth(medthick) lpattern(dash) lcolor(black)),legend(lab(1 "Nevada") lab(2 "Synthetic Nevada") size(medsmall) pos(1) ring(0) cols(1)) xtitle("Year") xline(2017) xlab(2005[2]2019) ytitle("NRP Score") graphregion(color(white)) bgcolor(white) plotregion(color(white))
	
**********************
*** Control States ***
**********************

*** Alabama ***
	use m_rbg3_data, clear 
	drop if rbg3_flag_33 == 1
	tsset stateid year 
	#delimit
	synth m_score_np m_score_np(2005) m_score_np(2007) m_score_np(2009) m_score_np(2011) m_score_np(2013) m_score_np(2015)
	m_score_np per_white per_asian per_black per_hispanic per_native pps,
	trunit(1) xperiod (2005(2)2015) trperiod(2017) 
	keep(m_synth_rbg3_1_33.dta, replace);
	#delimit cr

*** California ***
	use m_rbg3_data, clear 
	drop if rbg3_flag_33 == 1
	tsset stateid year 
	#delimit
	synth m_score_np m_score_np(2005) m_score_np(2007) m_score_np(2009) m_score_np(2011) m_score_np(2013) m_score_np(2015)
	m_score_np per_white per_asian per_black per_hispanic per_native pps,
	trunit(4) xperiod (2005(2)2015) trperiod(2017) 
	keep(m_synth_rbg3_4_33.dta, replace);
	#delimit cr

*** Washington DC ***
	use m_rbg3_data, clear 
	drop if rbg3_flag_33 == 1
	tsset stateid year 
	#delimit
	synth m_score_np m_score_np(2005) m_score_np(2007) m_score_np(2009) m_score_np(2011) m_score_np(2013) m_score_np(2015)
	m_score_np per_white per_asian per_black per_hispanic per_native pps,
	trunit(7) xperiod (2005(2)2015) trperiod(2017) 
	keep(m_synth_rbg3_7_33.dta, replace);
	#delimit cr

*** Idaho ***
	use m_rbg3_data, clear 
	drop if rbg3_flag_33 == 1
	tsset stateid year 
	#delimit
	synth m_score_np m_score_np(2005) m_score_np(2007) m_score_np(2009) m_score_np(2011) m_score_np(2013) m_score_np(2015)
	m_score_np per_white per_asian per_black per_hispanic per_native pps,
	trunit(12) xperiod (2005(2)2015) trperiod(2017) 
	keep(m_synth_rbg3_12_33.dta, replace);
	#delimit cr


*** Illinois ***
	use m_rbg3_data, clear 
	drop if rbg3_flag_33 == 1
	tsset stateid year 
	#delimit
	synth m_score_np m_score_np(2005) m_score_np(2007) m_score_np(2009) m_score_np(2011) m_score_np(2013) m_score_np(2015)
	m_score_np per_white per_asian per_black per_hispanic per_native pps,
	trunit(13) xperiod (2005(2)2015) trperiod(2017)
	keep(m_synth_rbg3_13_33.dta, replace);
	#delimit cr

*** Kansas ***
	use m_rbg3_data, clear 
	drop if rbg3_flag_33 == 1
	tsset stateid year 
	#delimit
	synth m_score_np m_score_np(2005) m_score_np(2007) m_score_np(2009) m_score_np(2011) m_score_np(2013) m_score_np(2015)
	m_score_np per_white per_asian per_black per_hispanic per_native pps,
	trunit(15) xperiod (2005(2)2015) trperiod(2017) 
	keep(m_synth_rbg3_15_33.dta, replace);
	#delimit cr

*** Kentucky ***
	use m_rbg3_data, clear 
	drop if rbg3_flag_33 == 1
	tsset stateid year 
	#delimit
	synth m_score_np m_score_np(2005) m_score_np(2007) m_score_np(2009) m_score_np(2011) m_score_np(2013) m_score_np(2015)
	m_score_np per_white per_asian per_black per_hispanic per_native pps,
	trunit(16) xperiod (2005(2)2015) trperiod(2017) 
	keep(m_synth_rbg3_16_33.dta, replace);
	#delimit cr


*** Louisiana ***
	use m_rbg3_data, clear 
	drop if rbg3_flag_33 == 1
	tsset stateid year 
	#delimit
	synth m_score_np m_score_np(2005) m_score_np(2007) m_score_np(2009) m_score_np(2011) m_score_np(2013) m_score_np(2015)
	m_score_np per_white per_asian per_black per_hispanic per_native pps,
	trunit(17) xperiod (2005(2)2015) trperiod(2017)
	keep(m_synth_rbg3_17_33.dta, replace);
	#delimit cr

*** Montana ***
	use m_rbg3_data, clear 
	drop if rbg3_flag_33 == 1
	tsset stateid year 
	#delimit
	synth m_score_np m_score_np(2005) m_score_np(2007) m_score_np(2009) m_score_np(2011) m_score_np(2013) m_score_np(2015)
	m_score_np per_white per_asian per_black per_hispanic per_native pps,
	trunit(25) xperiod (2005(2)2015) trperiod(2017)
	keep(m_synth_rbg3_25_33.dta, replace);
	#delimit cr

*** North Dakota, Nebraska, New Hampshire, New Jersey, & New Mexico ***
	forvalues x = 28/32{
	use m_rbg3_data, clear 
	drop if rbg3_flag_33 == 1
	tsset stateid year 
	#delimit
	synth m_score_np m_score_np(2005) m_score_np(2007) m_score_np(2009) m_score_np(2011) m_score_np(2013) m_score_np(2015)
	m_score_np per_white per_asian per_black per_hispanic per_native pps,
	trunit(`x') xperiod (2005(2)2015) trperiod(2017) 
	keep(m_synth_rbg3_`x'_33.dta, replace);
	#delimit cr
	}

*** Oregon, Pennsylvania, & Rhode Island ***
	forvalues x = 37/39{
	use m_rbg3_data, clear 
	drop if rbg3_flag_33 == 1
	tsset stateid year 
	#delimit
	synth m_score_np m_score_np(2005) m_score_np(2007) m_score_np(2009) m_score_np(2011) m_score_np(2013) m_score_np(2015)
	m_score_np per_white per_asian per_black per_hispanic per_native pps,
	trunit(`x') xperiod (2005(2)2015) trperiod(2017) 
	keep(m_synth_rbg3_`x'_33.dta, replace);
	#delimit cr
	}

*** South Dakota ***
	use m_rbg3_data, clear 
	drop if rbg3_flag_33 == 1
	tsset stateid year 
	#delimit
	synth m_score_np m_score_np(2005) m_score_np(2007) m_score_np(2009) m_score_np(2011) m_score_np(2013) m_score_np(2015)
	m_score_np per_white per_asian per_black per_hispanic per_native pps,
	trunit(41) xperiod (2005(2)2015) trperiod(2017)
	keep(m_synth_rbg3_41_33.dta, replace);
	#delimit cr
	
*** Texas, Utah, Virginia, & Vermont ***
	forvalues x = 43/46{
	use m_rbg3_data, clear 
	drop if rbg3_flag_33 == 1
	tsset stateid year 
	#delimit
	synth m_score_np m_score_np(2005) m_score_np(2007) m_score_np(2009) m_score_np(2011) m_score_np(2013) m_score_np(2015)
	m_score_np per_white per_asian per_black per_hispanic per_native pps,
	trunit(`x') xperiod (2005(2)2015) trperiod(2017) 
	keep(m_synth_rbg3_`x'_33.dta, replace);
	#delimit cr
	}
	
*** Wisconsin ***
	use m_rbg3_data, clear 
	drop if rbg3_flag_33 == 1
	tsset stateid year 
	#delimit
	synth m_score_np m_score_np(2005) m_score_np(2007) m_score_np(2009) m_score_np(2011) m_score_np(2013) m_score_np(2015)
	m_score_np per_white per_asian per_black per_hispanic per_native pps,
	trunit(48) xperiod (2005(2)2015) trperiod(2017)
	keep(m_synth_rbg3_48_33.dta, replace);
	#delimit cr

*** Wyoming ***
	use m_rbg3_data, clear 
	drop if rbg3_flag_33 == 1
	tsset stateid year 
	#delimit
	synth m_score_np m_score_np(2005) m_score_np(2007) m_score_np(2009) m_score_np(2011) m_score_np(2013) m_score_np(2015)
	m_score_np per_white per_asian per_black per_hispanic per_native pps,
	trunit(50) xperiod (2005(2)2015) trperiod(2017)
	keep(m_synth_rbg3_50_33.dta, replace);
	#delimit cr
	
****************************************
****** Infrence and Interpretaion ******
****************************************
	
*** Edit and Merge Dataset ***

*** Nevada ***
	use m_synth_rbg3_33_33, clear
	rename _time year
	rename _Y_synthetic _Y_synthetic_33
	rename _Y_treated _Y_treated_33
	gen alpha33 = _Y_treated - _Y_synthetic 
	keep alpha33 _Y_* year 
	drop if missing(year)
	save m_synth_results_33_33, replace 
	
*** Alabama ***
	use m_synth_rbg3_1_33, clear
	rename _time year
	rename _Y_synthetic _Y_synthetic_1
	rename _Y_treated _Y_treated_1
	gen alpha1 = _Y_treated - _Y_synthetic 
	keep alpha1 _Y_* year 
	drop if missing(year)
	merge 1:1 year using m_synth_results_33_33, nogenerate
	save m_synth_results_33_33, replace

*** California ***
	use m_synth_rbg3_4_33, clear
	rename _time year
	rename _Y_synthetic _Y_synthetic_4
	rename _Y_treated _Y_treated_4
	gen alpha4 = _Y_treated - _Y_synthetic 
	keep alpha4 _Y_* year 
	drop if missing(year)
	merge 1:1 year using m_synth_results_33_33, nogenerate
	save m_synth_results_33_33, replace
	
*** Washington DC ***
	use m_synth_rbg3_7_33, clear
	rename _time year
	rename _Y_synthetic _Y_synthetic_7
	rename _Y_treated _Y_treated_7
	gen alpha7 = _Y_treated - _Y_synthetic 
	keep alpha7 _Y_* year 
	drop if missing(year)
	merge 1:1 year using m_synth_results_33_33, nogenerate
	save m_synth_results_33_33, replace

	
*** Idhao & Illinois ***
	forvalues x = 12/13{
	use m_synth_rbg3_`x'_33, clear
	rename _time year
	rename _Y_synthetic _Y_synthetic_`x'
	rename _Y_treated _Y_treated_`x'
	gen alpha`x' = _Y_treated - _Y_synthetic 
	keep alpha`x' _Y_* year 
	drop if missing(year)
	merge 1:1 year using m_synth_results_33_33, nogenerate
	save m_synth_results_33_33, replace
	}
	
*** Kansas, Kentucky, & Louisiana ***
	forvalues x = 15/17{
	use m_synth_rbg3_`x'_33, clear
	rename _time year
	rename _Y_synthetic _Y_synthetic_`x'
	rename _Y_treated _Y_treated_`x'
	gen alpha`x' = _Y_treated - _Y_synthetic 
	keep alpha`x' _Y_* year 
	drop if missing(year)
	merge 1:1 year using m_synth_results_33_33, nogenerate
	save m_synth_results_33_33, replace
	}
	
*** Montana ***
	use m_synth_rbg3_25_33, clear
	rename _time year
	rename _Y_synthetic _Y_synthetic_25
	rename _Y_treated _Y_treated_25
	gen alpha25 = _Y_treated - _Y_synthetic 
	keep alpha25 _Y_* year 
	drop if missing(year)
	merge 1:1 year using m_synth_results_33_33, nogenerate
	save m_synth_results_33_33, replace
	
*** North Dakota, Nebraska, New Hampshire, New Jersey, New Mexico ***
	forvalues x = 28/32{
	use m_synth_rbg3_`x'_33, clear
	rename _time year
	rename _Y_synthetic _Y_synthetic_`x'
	rename _Y_treated _Y_treated_`x'
	gen alpha`x' = _Y_treated - _Y_synthetic 
	keep alpha`x' _Y_* year 
	drop if missing(year)
	merge 1:1 year using m_synth_results_33_33, nogenerate
	save m_synth_results_33_33, replace
	}

	
*** Oregon, Pennsylvania, & Rhode Island ***
	forvalues x = 37/39{
	use m_synth_rbg3_`x'_33, clear
	rename _time year
	rename _Y_synthetic _Y_synthetic_`x'
	rename _Y_treated _Y_treated_`x'
	gen alpha`x' = _Y_treated - _Y_synthetic 
	keep alpha`x' _Y_* year 
	drop if missing(year)
	merge 1:1 year using m_synth_results_33_33, nogenerate
	save m_synth_results_33_33, replace
	}
	
*** South Dakota ***
	use m_synth_rbg3_41_33, clear
	rename _time year
	rename _Y_synthetic _Y_synthetic_41
	rename _Y_treated _Y_treated_41
	gen alpha41 = _Y_treated - _Y_synthetic 
	keep alpha41 _Y_* year 
	drop if missing(year)
	merge 1:1 year using m_synth_results_33_33, nogenerate
	save m_synth_results_33_33, replace

	
*** Texas, Utah, Virginia, & Vermont ***
	forvalues x = 43/46{
	use m_synth_rbg3_`x'_33, clear
	rename _time year
	rename _Y_synthetic _Y_synthetic_`x'
	rename _Y_treated _Y_treated_`x'
	gen alpha`x' = _Y_treated - _Y_synthetic 
	keep alpha`x' _Y_* year 
	drop if missing(year)
	merge 1:1 year using m_synth_results_33_33, nogenerate
	save m_synth_results_33_33, replace
	}
	
*** Wisconsin ***
	use m_synth_rbg3_48_33, clear
	rename _time year
	rename _Y_synthetic _Y_synthetic_48
	rename _Y_treated _Y_treated_48
	gen alpha48 = _Y_treated - _Y_synthetic 
	keep alpha48 _Y_* year 
	drop if missing(year)
	merge 1:1 year using m_synth_results_33_33, nogenerate
	save m_synth_results_33_33, replace


*** Wyoming ***
	use m_synth_rbg3_50_33, clear
	rename _time year
	rename _Y_synthetic _Y_synthetic_50
	rename _Y_treated _Y_treated_50
	gen alpha50 = _Y_treated - _Y_synthetic 
	keep alpha50 _Y_* year 
	drop if missing(year)
	merge 1:1 year using m_synth_results_33_33, nogenerate
	save m_synth_results_33_33, replace

	
*** Restructure Dataset ***
	use m_synth_results_33_33, clear 
	keep alpha* year 
	reshape long alpha, i(year) j(state)

*** Graphing Synthetic Control ***
	use m_synth_results_33_33, clear 
	keep alpha* year 
	reshape long alpha, i(year) j(state)
	
	twoway (line alpha year if state == 1, lcolor(gs10)) (line alpha year if state == 4, lcolor(gs10)) (line alpha year if state == 7, lcolor(gs10))(line alpha year if state == 12, lcolor(gs10)) (line alpha year if state == 13, lcolor(gs10)) (line alpha year if state == 15, lcolor(gs10)) (line alpha year if state == 16, lcolor(gs10)) (line alpha year if state == 17, lcolor(gs10)) (line alpha year if state == 25, lcolor(gs10)) (line alpha year if state == 28, lcolor(gs10)) (line alpha year if state == 29, lcolor(gs10)) (line alpha year if state == 30, lcolor(gs10)) (line alpha year if state == 31, lcolor(gs10)) (line alpha year if state == 32, lcolor(gs10)) (line alpha year if state == 37, lcolor(gs10)) (line alpha year if state == 38, lcolor(gs10)) (line alpha year if state == 39, lcolor(gs10)) (line alpha year if state == 41, lcolor(gs10)) (line alpha year if state == 43, lcolor(gs10)) (line alpha year if state == 44, lcolor(gs10)) (line alpha year if state == 45, lcolor(gs10)) (line alpha year if state == 46, lcolor(gs10)) (line alpha year if state == 48, lcolor(gs10)) (line alpha year if state == 50, lcolor(gs10)) (line alpha year if state == 33, lwidth(thick) lcolor(red)), xlabel(2005(2)2019) leg(lab(33 "Nevada") lab(1 "Control states") size(medsmall) pos(11) order(39 1) ring(0) cols(1)) xtitle("Year") ytitle("Gap in NRP Score") 

*** Getting Exact P-Value ***
	use m_synth_results_33_33, clear   
	reshape long alpha, i(year) j(state)
	gen alphasqrd = alpha * alpha
	bysort state: egen pre_mspe = mean(alphasqrd) if year <= 2015
	bysort state: egen post_mspe = mean(alphasqrd) if year > 2015
	
	sum pre_mspe if state == 1
	replace pre_mspe = r(mean) if state == 1
	sum post_mspe if state == 1
	replace post_mspe = r(mean) if state == 1
	
	sum pre_mspe if state == 7
	replace pre_mspe = r(mean) if state == 7
	sum post_mspe if state == 7
	replace post_mspe = r(mean) if state == 7
	
	sum pre_mspe if state == 4
	replace pre_mspe = r(mean) if state == 4
	sum post_mspe if state == 4
	replace post_mspe = r(mean) if state == 4
	
	forvalues x = 12/13{
	sum pre_mspe if state == `x'
	replace pre_mspe = r(mean) if state == `x'
	sum post_mspe if state == `x'
	replace post_mspe = r(mean) if state == `x'
	}
	forvalues x = 15/17{
	sum pre_mspe if state == `x'
	replace pre_mspe = r(mean) if state == `x'
	sum post_mspe if state == `x'
	replace post_mspe = r(mean) if state == `x'
	}
	
	sum pre_mspe if state == 25
	replace pre_mspe = r(mean) if state == 25
	sum post_mspe if state == 25
	replace post_mspe = r(mean) if state == 25
	
	forvalues x = 28/33{
	sum pre_mspe if state == `x'
	replace pre_mspe = r(mean) if state == `x'
	sum post_mspe if state == `x'
	replace post_mspe = r(mean) if state == `x'
	}
	
	forvalues x = 37/41{
	sum pre_mspe if state == `x'
	replace pre_mspe = r(mean) if state == `x'
	sum post_mspe if state == `x'
	replace post_mspe = r(mean) if state == `x'
	}
	
	sum pre_mspe if state == 41
	replace pre_mspe = r(mean) if state == 41
	sum post_mspe if state == 41
	replace post_mspe = r(mean) if state == 41
	
	forvalues x = 43/46{
	sum pre_mspe if state == `x'
	replace pre_mspe = r(mean) if state == `x'
	sum post_mspe if state == `x'
	replace post_mspe = r(mean) if state == `x'
	}
	
	sum pre_mspe if state == 48
	replace pre_mspe = r(mean) if state == 48
	sum post_mspe if state == 48
	replace post_mspe = r(mean) if state == 48
	
	sum pre_mspe if state == 50
	replace pre_mspe = r(mean) if state == 50
	sum post_mspe if state == 50
	replace post_mspe = r(mean) if state == 50
	
	gen post_pre_ratio = post_mspe/pre_mspe
	duplicates drop state, force 
	
gsort -post_pre_ratio
gen rank = _n
gen pvalue = rank/_N if state == 33
list pvalue if state == 33

****************************************************************************************************
****** Grade 8 Synthetic Control Method (Falsification Test Against 8th Grade Reading Scores) ******
****************************************************************************************************
	use rbg3_master_data, clear 
	
*****************************
****** Final Data Prep ******
*****************************

*** Cleaing some Data ***
	forvalues x = 1/3{
		drop if grade == "Grade `x'"
	}
	forvalues x = 5/7{
		drop if grade == "Grade `x'"
	}
	forvalues x = 9/13{
		drop if grade == "Grade `x'"
	}
	foreach x in PK KG{
		drop if grade == "`x'"
	}
	forvalues x = 1/3{
		drop if grade == "Grade 0`x'"
	}
	forvalues x = 5/7{
		drop if grade == "Grade 0`x'"
	}
	drop if grade == "Grade 09"
	
	drop if grade == "No Category Codes"
	drop if grade == "A"
	tab grade 
	
	drop if st == "NA"
	drop if grade == "Grade 4"
	
	forvalues x = 1/50{
	gen rbg3_flag_`x' = 0 
	replace rbg3_flag_`x' = 1 if rbg3 == 1 
	replace rbg3_flag_`x' = 0 if stateid == `x'
	}
	
	drop if year == 2022
	save 8_rbg3_data, replace 

**************
*** Nevada ***
**************
	use 8_rbg3_data, clear 
	drop if rbg3_flag_33 == 1 
	tsset stateid year 
	#delimit
	synth score_np score_np(2005) score_np(2007) score_np(2009)
	score_np per_white per_asian per_black per_hispanic per_native pps,
	trunit(33) xperiod (2005(2)2017) trperiod(2017) nested allopt
	keep(8_synth_rbg3_33_33.dta, replace);
	#delimit cr

***********************
*** Graphing Nevada ***
***********************

*** Percent Proficient ***
use 8_synth_rbg3_33_33, clear 
	
	twoway(line _Y_treated _time, lwidth(medthick) lcolor(black) xline(1988, lpattern(dot) lwidth(medthick) lcolor(black))) (line _Y_synthetic _time, lwidth(medthick) lpattern(dash) lcolor(black)),legend(lab(1 "Nevada") lab(2 "Synthetic Nevada") size(medsmall) pos(1) ring(0) cols(1)) xtitle("Year") xline(2017) xlab(2005[2]2019) ytitle("NPR Score") graphregion(color(white)) bgcolor(white) plotregion(color(white))
	
**********************
*** Control States ***
**********************

*** Alabama ***
	use 8_rbg3_data, clear 
	drop if rbg3_flag_33 == 1
	tsset stateid year 
	#delimit
	synth score_np score_np(2005) score_np(2007) score_np(2009) score_np(2011) score_np(2013) score_np(2015)
	score_np per_white per_asian per_black per_hispanic per_native pps,
	trunit(1) xperiod (2005(2)2015) trperiod(2017) 
	keep(8_synth_rbg3_1_33.dta, replace);
	#delimit cr

*** California ***
	use 8_rbg3_data, clear 
	drop if rbg3_flag_33 == 1
	tsset stateid year 
	#delimit
	synth score_np score_np(2005) score_np(2007) score_np(2009) score_np(2011) score_np(2013) score_np(2015)
	score_np per_white per_asian per_black per_hispanic per_native pps,
	trunit(4) xperiod (2005(2)2015) trperiod(2017) 
	keep(8_synth_rbg3_4_33.dta, replace);
	#delimit cr

*** Washington DC ***
	use 8_rbg3_data, clear 
	drop if rbg3_flag_33 == 1
	tsset stateid year 
	#delimit
	synth score_np score_np(2005) score_np(2007) score_np(2009) score_np(2011) score_np(2013) score_np(2015)
	score_np per_white per_asian per_black per_hispanic per_native pps,
	trunit(7) xperiod (2005(2)2015) trperiod(2017) 
	keep(8_synth_rbg3_7_33.dta, replace);
	#delimit cr

*** Idaho ***
	use 8_rbg3_data, clear 
	drop if rbg3_flag_33 == 1
	tsset stateid year 
	#delimit
	synth score_np score_np(2005) score_np(2007) score_np(2009) score_np(2011) score_np(2013) score_np(2015)
	score_np per_white per_asian per_black per_hispanic per_native pps,
	trunit(12) xperiod (2005(2)2015) trperiod(2017) 
	keep(8_synth_rbg3_12_33.dta, replace);
	#delimit cr


*** Illinois ***
	use 8_rbg3_data, clear 
	drop if rbg3_flag_33 == 1
	tsset stateid year 
	#delimit
	synth score_np score_np(2005) score_np(2007) score_np(2009) score_np(2011) score_np(2013) score_np(2015)
	score_np per_white per_asian per_black per_hispanic per_native pps,
	trunit(13) xperiod (2005(2)2015) trperiod(2017)
	keep(8_synth_rbg3_13_33.dta, replace);
	#delimit cr

*** Kansas ***
	use 8_rbg3_data, clear 
	drop if rbg3_flag_33 == 1
	tsset stateid year 
	#delimit
	synth score_np score_np(2005) score_np(2007) score_np(2009) score_np(2011) score_np(2013) score_np(2015)
	score_np per_white per_asian per_black per_hispanic per_native pps,
	trunit(15) xperiod (2005(2)2015) trperiod(2017) 
	keep(8_synth_rbg3_15_33.dta, replace);
	#delimit cr

*** Kentucky ***
	use 8_rbg3_data, clear 
	drop if rbg3_flag_33 == 1
	tsset stateid year 
	#delimit
	synth score_np score_np(2005) score_np(2007) score_np(2009) score_np(2011) score_np(2013) score_np(2015)
	score_np per_white per_asian per_black per_hispanic per_native pps,
	trunit(16) xperiod (2005(2)2015) trperiod(2017) 
	keep(8_synth_rbg3_16_33.dta, replace);
	#delimit cr


*** Louisiana ***
	use 8_rbg3_data, clear 
	drop if rbg3_flag_33 == 1
	tsset stateid year 
	#delimit
	synth score_np score_np(2005) score_np(2007) score_np(2009) score_np(2011) score_np(2013) score_np(2015)
	score_np per_white per_asian per_black per_hispanic per_native pps,
	trunit(17) xperiod (2005(2)2015) trperiod(2017)
	keep(8_synth_rbg3_17_33.dta, replace);
	#delimit cr

*** Montana ***
	use 8_rbg3_data, clear 
	drop if rbg3_flag_33 == 1
	tsset stateid year 
	#delimit
	synth score_np score_np(2005) score_np(2007) score_np(2009) score_np(2011) score_np(2013) score_np(2015)
	score_np per_white per_asian per_black per_hispanic per_native pps,
	trunit(25) xperiod (2005(2)2015) trperiod(2017)
	keep(8_synth_rbg3_25_33.dta, replace);
	#delimit cr

*** North Dakota, Nebraska, New Hampshire, New Jersey, & New Mexico ***
	forvalues x = 28/32{
	use 8_rbg3_data, clear 
	drop if rbg3_flag_33 == 1
	tsset stateid year 
	#delimit
	synth score_np score_np(2005) score_np(2007) score_np(2009) score_np(2011) score_np(2013) score_np(2015)
	score_np per_white per_asian per_black per_hispanic per_native pps,
	trunit(`x') xperiod (2005(2)2015) trperiod(2017) 
	keep(8_synth_rbg3_`x'_33.dta, replace);
	#delimit cr
	}

*** Oregon, Pennsylvania, & Rhode Island ***
	forvalues x = 37/39{
	use 8_rbg3_data, clear 
	drop if rbg3_flag_33 == 1
	tsset stateid year 
	#delimit
	synth score_np score_np(2005) score_np(2007) score_np(2009) score_np(2011) score_np(2013) score_np(2015)
	score_np per_white per_asian per_black per_hispanic per_native pps,
	trunit(`x') xperiod (2005(2)2015) trperiod(2017) 
	keep(8_synth_rbg3_`x'_33.dta, replace);
	#delimit cr
	}

*** South Dakota ***
	use 8_rbg3_data, clear 
	drop if rbg3_flag_33 == 1
	tsset stateid year 
	#delimit
	synth score_np score_np(2005) score_np(2007) score_np(2009) score_np(2011) score_np(2013) score_np(2015)
	score_np per_white per_asian per_black per_hispanic per_native pps,
	trunit(41) xperiod (2005(2)2015) trperiod(2017)
	keep(8_synth_rbg3_41_33.dta, replace);
	#delimit cr
	
*** Texas, Utah, Virginia, & Vermont ***
	forvalues x = 43/46{
	use 8_rbg3_data, clear 
	drop if rbg3_flag_33 == 1
	tsset stateid year 
	#delimit
	synth score_np score_np(2005) score_np(2007) score_np(2009) score_np(2011) score_np(2013) score_np(2015)
	score_np per_white per_asian per_black per_hispanic per_native pps,
	trunit(`x') xperiod (2005(2)2015) trperiod(2017) 
	keep(8_synth_rbg3_`x'_33.dta, replace);
	#delimit cr
	}
	
*** Wisconsin ***
	use 8_rbg3_data, clear 
	drop if rbg3_flag_33 == 1
	tsset stateid year 
	#delimit
	synth score_np score_np(2005) score_np(2007) score_np(2009) score_np(2011) score_np(2013) score_np(2015)
	score_np per_white per_asian per_black per_hispanic per_native pps,
	trunit(48) xperiod (2005(2)2015) trperiod(2017)
	keep(8_synth_rbg3_48_33.dta, replace);
	#delimit cr

*** Wyoming ***
	use 8_rbg3_data, clear 
	drop if rbg3_flag_33 == 1
	tsset stateid year 
	#delimit
	synth score_np score_np(2005) score_np(2007) score_np(2009) score_np(2011) score_np(2013) score_np(2015)
	score_np per_white per_asian per_black per_hispanic per_native pps,
	trunit(50) xperiod (2005(2)2015) trperiod(2017)
	keep(8_synth_rbg3_50_33.dta, replace);
	#delimit cr
	
****************************************
****** Infrence and Interpretaion ******
****************************************
	
*** Edit and Merge Dataset ***

*** Nevada ***
	use 8_synth_rbg3_33_33, clear
	rename _time year
	rename _Y_synthetic _Y_synthetic_33
	rename _Y_treated _Y_treated_33
	gen alpha33 = _Y_treated - _Y_synthetic 
	keep alpha33 _Y_* year 
	drop if missing(year)
	save 8_synth_results_33_33, replace 
	
*** Alabama ***
	use 8_synth_rbg3_1_33, clear
	rename _time year
	rename _Y_synthetic _Y_synthetic_1
	rename _Y_treated _Y_treated_1
	gen alpha1 = _Y_treated - _Y_synthetic 
	keep alpha1 _Y_* year 
	drop if missing(year)
	merge 1:1 year using 8_synth_results_33_33, nogenerate
	save 8_synth_results_33_33, replace

*** California ***
	use 8_synth_rbg3_4_33, clear
	rename _time year
	rename _Y_synthetic _Y_synthetic_4
	rename _Y_treated _Y_treated_4
	gen alpha4 = _Y_treated - _Y_synthetic 
	keep alpha4 _Y_* year 
	drop if missing(year)
	merge 1:1 year using 8_synth_results_33_33, nogenerate
	save 8_synth_results_33_33, replace
	
*** Washington DC ***
	use 8_synth_rbg3_7_33, clear
	rename _time year
	rename _Y_synthetic _Y_synthetic_7
	rename _Y_treated _Y_treated_7
	gen alpha7 = _Y_treated - _Y_synthetic 
	keep alpha7 _Y_* year 
	drop if missing(year)
	merge 1:1 year using 8_synth_results_33_33, nogenerate
	save 8_synth_results_33_33, replace

	
*** Idhao & Illinois ***
	forvalues x = 12/13{
	use 8_synth_rbg3_`x'_33, clear
	rename _time year
	rename _Y_synthetic _Y_synthetic_`x'
	rename _Y_treated _Y_treated_`x'
	gen alpha`x' = _Y_treated - _Y_synthetic 
	keep alpha`x' _Y_* year 
	drop if missing(year)
	merge 1:1 year using 8_synth_results_33_33, nogenerate
	save 8_synth_results_33_33, replace
	}
	
*** Kansas, Kentucky, & Louisiana ***
	forvalues x = 15/17{
	use 8_synth_rbg3_`x'_33, clear
	rename _time year
	rename _Y_synthetic _Y_synthetic_`x'
	rename _Y_treated _Y_treated_`x'
	gen alpha`x' = _Y_treated - _Y_synthetic 
	keep alpha`x' _Y_* year 
	drop if missing(year)
	merge 1:1 year using 8_synth_results_33_33, nogenerate
	save 8_synth_results_33_33, replace
	}
	
*** Montana ***
	use 8_synth_rbg3_25_33, clear
	rename _time year
	rename _Y_synthetic _Y_synthetic_25
	rename _Y_treated _Y_treated_25
	gen alpha25 = _Y_treated - _Y_synthetic 
	keep alpha25 _Y_* year 
	drop if missing(year)
	merge 1:1 year using 8_synth_results_33_33, nogenerate
	save 8_synth_results_33_33, replace
	
*** North Dakota, Nebraska, New Hampshire, New Jersey, New Mexico ***
	forvalues x = 28/32{
	use 8_synth_rbg3_`x'_33, clear
	rename _time year
	rename _Y_synthetic _Y_synthetic_`x'
	rename _Y_treated _Y_treated_`x'
	gen alpha`x' = _Y_treated - _Y_synthetic 
	keep alpha`x' _Y_* year 
	drop if missing(year)
	merge 1:1 year using 8_synth_results_33_33, nogenerate
	save 8_synth_results_33_33, replace
	}

	
*** Oregon, Pennsylvania, & Rhode Island ***
	forvalues x = 37/39{
	use 8_synth_rbg3_`x'_33, clear
	rename _time year
	rename _Y_synthetic _Y_synthetic_`x'
	rename _Y_treated _Y_treated_`x'
	gen alpha`x' = _Y_treated - _Y_synthetic 
	keep alpha`x' _Y_* year 
	drop if missing(year)
	merge 1:1 year using 8_synth_results_33_33, nogenerate
	save 8_synth_results_33_33, replace
	}
	
*** South Dakota ***
	use 8_synth_rbg3_41_33, clear
	rename _time year
	rename _Y_synthetic _Y_synthetic_41
	rename _Y_treated _Y_treated_41
	gen alpha41 = _Y_treated - _Y_synthetic 
	keep alpha41 _Y_* year 
	drop if missing(year)
	merge 1:1 year using 8_synth_results_33_33, nogenerate
	save 8_synth_results_33_33, replace

	
*** Texas, Utah, Virginia, & Vermont ***
	forvalues x = 43/46{
	use 8_synth_rbg3_`x'_33, clear
	rename _time year
	rename _Y_synthetic _Y_synthetic_`x'
	rename _Y_treated _Y_treated_`x'
	gen alpha`x' = _Y_treated - _Y_synthetic 
	keep alpha`x' _Y_* year 
	drop if missing(year)
	merge 1:1 year using 8_synth_results_33_33, nogenerate
	save 8_synth_results_33_33, replace
	}
	
*** Wisconsin ***
	use 8_synth_rbg3_48_33, clear
	rename _time year
	rename _Y_synthetic _Y_synthetic_48
	rename _Y_treated _Y_treated_48
	gen alpha48 = _Y_treated - _Y_synthetic 
	keep alpha48 _Y_* year 
	drop if missing(year)
	merge 1:1 year using 8_synth_results_33_33, nogenerate
	save 8_synth_results_33_33, replace


*** Wyoming ***
	use 8_synth_rbg3_50_33, clear
	rename _time year
	rename _Y_synthetic _Y_synthetic_50
	rename _Y_treated _Y_treated_50
	gen alpha50 = _Y_treated - _Y_synthetic 
	keep alpha50 _Y_* year 
	drop if missing(year)
	merge 1:1 year using 8_synth_results_33_33, nogenerate
	save 8_synth_results_33_33, replace

	
*** Restructure Dataset ***
	use 8_synth_results_33_33, clear 
	keep alpha* year 
	reshape long alpha, i(year) j(state)

*** Graphing Synthetic Control ***
	use 8_synth_results_33_33, clear 
	keep alpha* year 
	reshape long alpha, i(year) j(state)
	
	twoway (line alpha year if state == 1, lcolor(gs10)) (line alpha year if state == 4, lcolor(gs10)) (line alpha year if state == 7, lcolor(gs10))(line alpha year if state == 12, lcolor(gs10)) (line alpha year if state == 13, lcolor(gs10)) (line alpha year if state == 15, lcolor(gs10)) (line alpha year if state == 16, lcolor(gs10)) (line alpha year if state == 17, lcolor(gs10)) (line alpha year if state == 25, lcolor(gs10)) (line alpha year if state == 28, lcolor(gs10)) (line alpha year if state == 29, lcolor(gs10)) (line alpha year if state == 30, lcolor(gs10)) (line alpha year if state == 31, lcolor(gs10)) (line alpha year if state == 32, lcolor(gs10)) (line alpha year if state == 37, lcolor(gs10)) (line alpha year if state == 38, lcolor(gs10)) (line alpha year if state == 39, lcolor(gs10)) (line alpha year if state == 41, lcolor(gs10)) (line alpha year if state == 43, lcolor(gs10)) (line alpha year if state == 44, lcolor(gs10)) (line alpha year if state == 45, lcolor(gs10)) (line alpha year if state == 46, lcolor(gs10)) (line alpha year if state == 48, lcolor(gs10)) (line alpha year if state == 50, lcolor(gs10)) (line alpha year if state == 33, lwidth(thick) lcolor(red)), xlabel(2005(2)2019) leg(lab(33 "Nevada") lab(1 "Control states") size(medsmall) pos(11) order(39 1) ring(0) cols(1)) xtitle("Year") ytitle("Gap in Percentage of Student Body Deemed Proficient") 

*** Getting Exact P-Value ***
	use 8_synth_results_33_33, clear   
	reshape long alpha, i(year) j(state)
	gen alphasqrd = alpha * alpha
	bysort state: egen pre_mspe = mean(alphasqrd) if year <= 2015
	bysort state: egen post_mspe = mean(alphasqrd) if year > 2015
	
	sum pre_mspe if state == 1
	replace pre_mspe = r(mean) if state == 1
	sum post_mspe if state == 1
	replace post_mspe = r(mean) if state == 1
	
	sum pre_mspe if state == 7
	replace pre_mspe = r(mean) if state == 7
	sum post_mspe if state == 7
	replace post_mspe = r(mean) if state == 7
	
	sum pre_mspe if state == 4
	replace pre_mspe = r(mean) if state == 4
	sum post_mspe if state == 4
	replace post_mspe = r(mean) if state == 4
	
	forvalues x = 12/13{
	sum pre_mspe if state == `x'
	replace pre_mspe = r(mean) if state == `x'
	sum post_mspe if state == `x'
	replace post_mspe = r(mean) if state == `x'
	}
	forvalues x = 15/17{
	sum pre_mspe if state == `x'
	replace pre_mspe = r(mean) if state == `x'
	sum post_mspe if state == `x'
	replace post_mspe = r(mean) if state == `x'
	}
	
	sum pre_mspe if state == 25
	replace pre_mspe = r(mean) if state == 25
	sum post_mspe if state == 25
	replace post_mspe = r(mean) if state == 25
	
	forvalues x = 28/33{
	sum pre_mspe if state == `x'
	replace pre_mspe = r(mean) if state == `x'
	sum post_mspe if state == `x'
	replace post_mspe = r(mean) if state == `x'
	}
	
	forvalues x = 37/41{
	sum pre_mspe if state == `x'
	replace pre_mspe = r(mean) if state == `x'
	sum post_mspe if state == `x'
	replace post_mspe = r(mean) if state == `x'
	}
	
	sum pre_mspe if state == 41
	replace pre_mspe = r(mean) if state == 41
	sum post_mspe if state == 41
	replace post_mspe = r(mean) if state == 41
	
	forvalues x = 43/46{
	sum pre_mspe if state == `x'
	replace pre_mspe = r(mean) if state == `x'
	sum post_mspe if state == `x'
	replace post_mspe = r(mean) if state == `x'
	}
	
	sum pre_mspe if state == 48
	replace pre_mspe = r(mean) if state == 48
	sum post_mspe if state == 48
	replace post_mspe = r(mean) if state == 48
	
	sum pre_mspe if state == 50
	replace pre_mspe = r(mean) if state == 50
	sum post_mspe if state == 50
	replace post_mspe = r(mean) if state == 50
	
	gen post_pre_ratio = post_mspe/pre_mspe
	duplicates drop state, force 
	
	gsort -post_pre_ratio
	gen rank = _n
	gen pvalue = rank/_N if state == 33
	list pvalue if state == 33
