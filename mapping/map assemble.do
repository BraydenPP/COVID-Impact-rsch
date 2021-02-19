clear
cd \\rschfs1x\userrs\a-e\bp257_RS\Desktop\data

*******
*make data sheet compatable to district codes

use \\rschfs1x\userrs\a-e\bp257_RS\Desktop\covidpub\covid\pc11/district-wise_cases_deaths
sort pc11_district_id

by pc11_district_id: egen max_cases = max(total_cases)
by pc11_district_id: egen max_deaths = max(total_deaths)

keep if date == td("30jul2020")
destring pc11_district_id, replace

save distric-wise_sum_30jul, replace
*/

*******
*bring in district id data
use distric-wise_sum_30jul
merge 1:1 pc11_district_id using distCode2011
*drop if _merge!=3
drop _merge

*******
*use polygon data to map case data
cd \\rschfs1x\userrs\a-e\bp257_RS\Desktop\data\shapefiles
spmap max_cases using IND_2_coord, id(_ID) fcolor(Reds) clnumber(9)
spmap max_deaths using IND_2_coord, id(_ID) fcolor(Blues) clnumber(9)

*save cases_map, replace

*/