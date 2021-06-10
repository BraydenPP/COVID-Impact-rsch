cd \\rschfs1x\userrs\a-e\bp257_RS\Desktop\data\markets
use agmark_append, clear

******
//puting dates in line
keep if month>tm(2019m12)&month<tm(2021m1)
rename (monthly_qty monthly_price) (qty_20 price_20)
save agmark_monthly, replace

use agmark_append, clear
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
merge 1:1 month pc11_district_id group using agmark_monthly
drop _merge
save agmark_monthly, replace

use agmark_append, clear
keep if month>tm(2017m12)&month<tm(2019m1)
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
merge 1:1 month pc11_district_id group using agmark_monthly
drop _merge
sort pc11_state_id pc11_district_id month group
save agmark_monthly, replace

use agmark_append, clear
keep if month>tm(2016m12)&month<tm(2018m1)
rename (monthly_qty monthly_price) (qty_17 price_17)
replace month =720 if month==tm(2017m1)
replace month =721 if month==tm(2017m2)
replace month =722 if month==tm(2017m3)
replace month =723 if month==tm(2017m4)
replace month =724 if month==tm(2017m5)
replace month =725 if month==tm(2017m6)
replace month =726 if month==tm(2017m7)
replace month =727 if month==tm(2017m8)
replace month =728 if month==tm(2017m9)
replace month =729 if month==tm(2017m10)
replace month =730 if month==tm(2017m11)
replace month =731 if month==tm(2017m12)
merge 1:1 month pc11_district_id group using agmark_monthly
drop _merge
save agmark_monthly, replace

use agmark_append, clear
keep if month>tm(2015m12)&month<tm(2017m1)
rename (monthly_qty monthly_price) (qty_16 price_16)
replace month =720 if month==tm(2016m1)
replace month =721 if month==tm(2016m2)
replace month =722 if month==tm(2016m3)
replace month =723 if month==tm(2016m4)
replace month =724 if month==tm(2016m5)
replace month =725 if month==tm(2016m6)
replace month =726 if month==tm(2016m7)
replace month =727 if month==tm(2016m8)
replace month =728 if month==tm(2016m9)
replace month =729 if month==tm(2016m10)
replace month =730 if month==tm(2016m11)
replace month =731 if month==tm(2016m12)
merge 1:1 pc11_district_id month group using agmark_monthly
drop _merge
save agmark_monthly, replace

***paste a section from above here to append more years/months (edit years!!!)***

//calculating difference of differences of growth rates
	//price
gen AGR16 = (price_17 - price_16)/price_16 + 1
gen AGR17 = (price_18 - price_17)/price_17 + 1
gen AGR18 = (price_19 - price_18)/price_18 + 1
gen diff20 = price_20 - price_19
egen AARG = rowmean(AGR16 AGR17 AGR18)
gen deviation_price20 = diff20 - (AARG * price_19)
//for 2021:
*gen diff21 = price_21 - price_20
*gen deviation_price21 = diff21 - (AARG * price_20)
*drop diff21
drop AGR16 AGR17 AGR18 AARG diff20
	//qty
gen AGR16 = (qty_17 - qty_16)/qty_16 + 1
gen AGR17 = (qty_18 - qty_17)/qty_17 + 1
gen AGR18 = (qty_19 - qty_18)/qty_18 + 1
gen diff20 = qty_20 - qty_19
egen AARG = rowmean(AGR16 AGR17 AGR18)
gen deviation_qty20 = diff20 - (AARG * qty_19)
//for 2021:
*gen diff21 = qty_21 - qty_20
*gen deviation_qty21 = diff21 - (AARG * qty_20)
*drop diff21
drop AGR16 AGR17 AGR18 AARG diff20

save agmark_monthly, replace