*****Instructions*****
*jump to line 35 to add additional years/months
*****
clear
cd \\rschfs1x\userrs\a-e\bp257_RS\Desktop\data\markets\csv

foreach YY in 17 18 19{
clear
import delimited 20`YY'm1-15.csv, varnames(1)
drop if date == "-"
save agmark_append`YY', replace
foreach ds in 1-31 2-15 2-28 3-15 3-31 4-15 4-30 5-15 5-31 6-15 6-30 7-15 7-31 8-15 8-31 9-15 9-30 10-15 10-31 11-15 11-30 12-15 12-31{
clear
import delimited 20`YY'm`ds'.csv
rename (v1 v2 v3 v4 v5 v6 v7 v8) (state district mandi item group qty modeprice date)
drop if date == "-"
append using agmark_append`YY'
save agmark_append`YY', replace
}
}
foreach YY in 16 20{
clear
import delimited 20`YY'm1-15.csv, varnames(1)
drop if date == "-"
save agmark_append`YY', replace
foreach ds in 1-31 2-15 2-29 3-15 3-31 4-15 4-30 5-15 5-31 6-15 6-30 7-15 7-31 8-15 8-31 9-15 9-30 10-15 10-31 11-15 11-30 12-15 12-31{
clear
import delimited 20`YY'm`ds'.csv
rename (v1 v2 v3 v4 v5 v6 v7 v8) (state district mandi item group qty modeprice date)
drop if date == "-"
append using agmark_append`YY'
save agmark_append`YY', replace
}
}
/*Copy and paste the following section for each additional year being imported being sure to edit lines 37, 39, 42, 45, 46 to the appropriate year:
clear
import delimited 2016m1-15.csv, varnames(1)
drop if date == "-"
save agmark_append16, replace
foreach ds in 1-31 2-15 2-29 3-15 3-31 4-15 4-30 5-15 5-31 6-15 6-30 7-15 7-31 8-15 8-31 9-15 9-30 10-15 10-31 11-15 11-30 12-15 12-31{
clear
import delimited 2016m`ds'.csv
rename (v1 v2 v3 v4 v5 v6 v7 v8) (state district mandi item group qty modeprice date)
drop if date == "-"
append using agmark_append16
save agmark_append16, replace
}
*****/

use agmark_append16, clear
append using agmark_append17
append using agmark_append18
append using agmark_append19
append using agmark_append20
save \\rschfs1x\userrs\a-e\bp257_RS\Desktop\data\markets/agmark_append, replace
*erase agmark_append16 agmark_append17 agmark_append18 agmark_append19 agmark_append20
cd \\rschfs1x\userrs\a-e\bp257_RS\Desktop\data\markets

*****
//replace names for id's
drop if state =="state"
drop if state =="v1"
merge m:m state district using import_names, keepusing(pc11_state_id pc11_district_id _ID)
drop if _merge!=3
drop state district _merge
save agmark_append, replace

//convert to months
replace date = subinstr(date, "-", " ", .)
replace date = subinstr(date, " 20", " ", .)
gen date1 =date(date,"DMY", 2020)
format date1 %td
drop date
rename date1 date
gen month= mofd(date)
format month %tm
destring qty modeprice, force replace ignore(",")
bysort date pc11_district_id group: egen qtyperday =mean(qty)
bysort date pc11_district_id group: egen priceperday =mean(modeprice)
duplicates drop pc11_district_id date group, force
bysort month pc11_district_id group: egen monthly_qty =mean(qtyperday)
bysort month pc11_district_id group: egen monthly_price =mean(priceperday)
duplicates drop pc11_district_id month group, force
keep pc11_state_id pc11_district_id group date month monthly_qty monthly_price _ID
order pc11_state_id pc11_district_id group date month monthly_qty monthly_price _ID
save agmark_append, replace
