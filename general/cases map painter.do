clear
cd \\rschfs1x\userrs\a-e\bp257_RS\Desktop\data\general
*****
/*make data sheet compatable to district codes

use district-wise_cases_deaths
sort pc11_district_id

by pc11_district_id: egen max_cases = max(total_cases)
by pc11_district_id: egen max_deaths = max(total_deaths)

keep if date == td("30jul2020")
destring pc11_district_id, replace

save distric-wise_sum_30jul, replace
*****/
*bring in district id data

use distric-wise_sum_30jul
merge 1:1 pc11_district_id using 2011_Dist_1
drop _merge
recode max_cases . = 0
recode max_deaths . = 0
*****/
*use polygon data to map case data

cd \\rschfs1x\userrs\a-e\bp257_RS\Desktop\data\mobility\maps

spmap max_cases using \\rschfs1x\userrs\a-e\bp257_RS\Desktop\data\shapefiles/2011_Dist_coord, id(_ID) fcolor(Reds) clnumber(5)
graph save cases_map, replace
graph export cases_map.png, replace

spmap max_deaths using \\rschfs1x\userrs\a-e\bp257_RS\Desktop\data\shapefiles/2011_Dist_coord, id(_ID) fcolor(Blues) clnumber(5)
graph save deaths_map, replace
graph export deaths_map.png, replace
