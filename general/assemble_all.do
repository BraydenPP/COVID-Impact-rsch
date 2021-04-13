/*
//this first section only saves over itself so does not need to be run any more.
clear
use \\rschfs1x\userrs\a-e\bp257_RS\Desktop\data\mobility/monthly_mobility
sort simport dimport
merge m:1 simport dimport using import_names
rename (dimport simport) (google_districts google_states)
drop if _merge !=3
drop _merge google_districts google_states
save monthly_mobility, replace
*****/

//montly_light.dta will hold night light per capita data for each district in each month
clear
cd \\rschfs1x\userrs\a-e\bp257_RS\Desktop\data\night_light
use dist_sum_20
gen date = date("20200201", "YMD")
format date %td
gen month = mofd(date)
format month %tm
keep pc11_district_id pc11_state_id month sum02_20_perCapita
rename sum02_20_perCapita light_perCapita
save monthly_light, replace

foreach mo in 03 04 05 06 07 08 09 10 11 12 {
clear
use dist_sum_20
gen date = date("2020`mo'01'", "YMD")
format date %td
gen month = mofd(date)
format month %tm
keep pc11_state_id pc11_district_id month sum`mo'_20_perCapita
rename sum`mo'_20_perCapita light_perCapita

sort pc11_district_id month
append using monthly_light
save monthly_light, replace
}

cd \\rschfs1x\userrs\a-e\bp257_RS\Desktop\data\night_light
foreach mo in 02 03 04 05 06 07 08 09 10 11 12 {
clear
use dist_sum_19
gen date = date("2020`mo'01'", "YMD")
format date %td
gen month = mofd(date)
format month %tm
keep pc11_state_id pc11_district_id month sum`mo'_19_perCapita
rename sum`mo'_19_perCapita light_perCapita_19

sort pc11_district_id month
merge 1:1 pc11_district_id month using monthly_light
drop _merge
save monthly_light, replace
}
gen differences = light_perCapita - light_perCapita_19
sort pc11_state_id pc11_district_id month
order pc11_state_id pc11_district_id month
save monthly_light, replace
cd \\rschfs1x\userrs\a-e\bp257_RS\Desktop\data\general
save monthly_all, replace
*****

//merging other datasets
merge 1:1 pc11_district_id month using \\rschfs1x\userrs\a-e\bp257_RS\Desktop\data\mobility/unlock_colors, keepusing(strictness)
rename strictness zone_color
drop _merge
save monthly_all, replace

foreach mo in 06 07 {
clear
use \\rschfs1x\userrs\a-e\bp257_RS\Desktop\data\mobility/containment_&_quarantine
gen date = date("2020`mo'01'", "YMD")
format date %td
gen month = mofd(date)
format month %tm
keep pc11_state_id month containment_days interstate_quarantine

sort pc11_state_id month
merge 1:m pc11_state_id month using monthly_all
drop if _merge ==1
drop _merge
save monthly_all, replace
}

merge 1:1 pc11_district_id month using \\rschfs1x\userrs\a-e\bp257_RS\Desktop\data\mobility/monthly_mobility, keepusing(av_mobility grocery_pharm_av residential_av workplace_av)
drop _merge

merge m:1 pc11_district_id using 2011_Dist_1, keepusing(_ID)
drop _merge
drop if pc11_district_id==0
sort pc11_state_id pc11_district_id month
order pc11_state_id pc11_district_id month
save monthly_all, replace
*****

//correlation, regression, visualize
cd \\rschfs1x\userrs\a-e\bp257_RS\Desktop\data\general
use monthly_all, clear





