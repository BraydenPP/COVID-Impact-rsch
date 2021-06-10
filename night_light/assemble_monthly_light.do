*montly_light.dta will hold night light per capita and per K^2 for each district in each month

clear
cd \\rschfs1x\userrs\a-e\bp257_RS\Desktop\data\night_light
use dist_sum_20
gen date = date("20200201", "YMD")
format date %td
gen month = mofd(date)
format month %tm
keep pc11_district_id pc11_state_id month sum02_20_perCapita
rename sum02_20_perCapita light_perCapita20
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
save monthly_light, replace
*****
cd \\rschfs1x\userrs\a-e\bp257_RS\Desktop\data\night_light
foreach mo in 02 03 04 05 06 07 08 09 10 11 12 {
clear
use dist_sum_20
gen date = date("2020`mo'01'", "YMD")
format date %td
gen month = mofd(date)
format month %tm
keep pc11_state_id pc11_district_id month sum`mo'_20_perK2
rename sum`mo'_20_perK2 light_perK2

sort pc11_district_id month
merge 1:1 pc11_district_id month using monthly_light
drop _merge
save monthly_light, replace
}
foreach mo in 02 03 04 05 06 07 08 09 10 11 12 {
clear
use dist_sum_19
gen date = date("2020`mo'01'", "YMD")
format date %td
gen month = mofd(date)
format month %tm
keep pc11_state_id pc11_district_id month sum`mo'_19_perK2
rename sum`mo'_19_perK2 light_perK2_19

sort pc11_district_id month
merge 1:1 pc11_district_id month using monthly_light
drop _merge
save monthly_light, replace
}