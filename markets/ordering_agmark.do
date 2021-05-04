cd \\rschfs1x\userrs\a-e\bp257_RS\Desktop\data\markets
use agmark, clear

//convert to months
gen month= mofd(date)
format month %tm
duplicates drop pc11_district_id date group, force
bysort month pc11_district_id group: egen monthly_qty =mean(daily_qty)
bysort month pc11_district_id group: egen monthly_price =mean(daily_price)
duplicates drop pc11_district_id month group, force
keep pc11_state_id pc11_district_id group month monthly_qty monthly_price _ID
order pc11_state_id pc11_district_id group month monthly_qty monthly_price _ID

save agmark_monthly, replace
******
//create differences & differences of differences
	//puting dates in line
keep if month>tm(2019m12)
rename (monthly_qty monthly_price) (qty_20 price_20)
save agmark_ready, replace

use agmark_monthly, clear
keep if month>tm(2018m12)&month<tm(2020m1)
rename (monthly_qty monthly_price) (qty_19 price_19)
replace month =720 if month==tm(2019m1)
replace month =721 if month==tm(2019m2)
replace month =722 if month==tm(2019m3)
replace month =723 if month==tm(2019m4)
replace month =724 if month==tm(2019m5)
replace month =725 if month==tm(2019m6)
replace month =726 if month==tm(2019m7)
replace month =727 if month==tm(2019m8)
replace month =728 if month==tm(2019m9)
replace month =729 if month==tm(2019m10)
replace month =730 if month==tm(2019m11)
replace month =731 if month==tm(2019m12)
merge 1:1 month pc11_district_id group using agmark_ready
drop _merge
save agmark_ready, replace

use agmark_monthly, clear
keep if month<tm(2019m1)
rename (monthly_qty monthly_price) (qty_18 price_18)
replace month =720 if month==tm(2018m1)
replace month =721 if month==tm(2018m2)
replace month =722 if month==tm(2018m3)
replace month =723 if month==tm(2018m4)
replace month =724 if month==tm(2018m5)
replace month =725 if month==tm(2018m6)
replace month =726 if month==tm(2018m7)
replace month =727 if month==tm(2018m8)
replace month =728 if month==tm(2018m9)
replace month =729 if month==tm(2018m10)
replace month =730 if month==tm(2018m11)
replace month =731 if month==tm(2018m12)
merge 1:1 month pc11_district_id group using agmark_ready
drop _merge
sort pc11_state_id pc11_district_id month group

	//calculating differences
gen diff_qty= qty_20 - qty_19
gen diff_price= price_20 - price_19
gen exp_qty= (1+(qty_19 - qty_18)/qty_18)*qty_19
gen exp_price= (1+(price_19 - price_18)/price_18)*price_19
gen deviation_qty = diff_qty - exp_qty
gen deviation_price = diff_price - exp_price
drop exp_qty exp_price qty_18 qty_19 price_18 price_19
drop if qty_20 ==.& price_20 ==.

save agmark_ready, replace

//merge with monthly_all
use \\rschfs1x\userrs\a-e\bp257_RS\Desktop\data\general/monthly_all, clear

merge 1:m pc11_district_id month using agmark_ready
drop if _merge !=3
drop _merge




