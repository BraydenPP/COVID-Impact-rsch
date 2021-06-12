clear
use \\rschfs1x\userrs\a-e\bp257_RS\Desktop\data\general/district-wise_cases_deaths
*****

*bring in district id data
merge 1:1 pc11_district_id using \\rschfs1x\userrs\a-e\bp257_RS\Desktop\data\raw/2011_Dist_1
drop _merge

// Map june or july total
*keep if month ==tm(2020m6)
*keep if month ==tm(2020m7)

//Change XXX and YYY in the spmap commands below to "total" or "monthly" to map the cases/deaths up to the end of a month or within a month, respectively
///Change the name of the save file if you want both options

*use polygon data to map case data
cd \\rschfs1x\userrs\a-e\bp257_RS\Desktop\data\general\visuals

spmap XXX_cases using \\rschfs1x\userrs\a-e\bp257_RS\Desktop\data\shapefiles/2011_Dist_coord, id(_ID) fcolor(Reds) clnumber(5)
graph save cases_map, replace
graph export cases_map.png, replace

spmap YYY_deaths using \\rschfs1x\userrs\a-e\bp257_RS\Desktop\data\shapefiles/2011_Dist_coord, id(_ID) fcolor(Blues) clnumber(5)
graph save deaths_map, replace
graph export deaths_map.png, replace
