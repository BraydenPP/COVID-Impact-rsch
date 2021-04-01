clear
cd \\rschfs1x\userrs\a-e\bp257_RS\Desktop\data\mobility
import delimited Google_mobility.csv
save google_mobility, replace
*****/
*cleaning data

drop country_region country_region_code census_fips_code iso_3166_2_code metro_area place_id
rename (sub_region_1 sub_region_2) (simport dimport)
rename (retail_and_recreation_percent_ch grocery_and_pharmacy_percent_cha parks_percent_change_from_baseli transit_stations_percent_change_ workplaces_percent_change_from_b residential_percent_change_from_) (retail_rec grocery_pharm parks transit workplace residential)
drop if simport ==""
egen av_mobility= rowmean(retail_rec grocery_pharm workplace)
save google_mobility, replace
*****/
//the following dates all have the maximum or near maximum observations of 633 districts
*use google_mobility

*keep if date == "2020-06-15"
*keep if date == "2020-06-30"
*keep if date == "2020-07-01"
keep if date == "2020-07-15"
*keep if date == "2020-07-30"
*keep if date == "2020-08-15"
*...
*****/
*merging in pc11 names and _ID

sort simport dimport
merge m:1 simport dimport using import_names
rename (dimport simport) (google_districts google_states)
*****
*av_mobility map

spmap av_mobility using \\rschfs1x\userrs\a-e\bp257_RS\Desktop\data\shapefiles/2011_dist_coord, id(_ID) clnumber(5) clmethod(custom) clbreaks(-79 -50 -20 0 20 51) fcolor(red red*.6 red*.3 blue*.3 blue*.9) ndocolor(black) osize(vvthin vvthin vvthin vvthin vvthin) ndsize(vthin) legend(position(4) symysize(*1.5) symxsize(*1) textwidth(*9) keygap(*0.5) size(small))
cd \\rschfs1x\userrs\a-e\bp257_RS\Desktop\data\mobility\maps
graph save \\rschfs1x\userrs\a-e\bp257_RS\Desktop\data\mobility\mapsav_mobility_15-7, replace
graph export av_mobility_15-7.png, replace
*****
/*grocery_pharm mobility map

spmap grocery_pharm using \\rschfs1x\userrs\a-e\bp257_RS\Desktop\data\shapefiles/2011_dist_coord, id(_ID) clnumber(5) clmethod(custom) clbreaks(-76 -25 0 25 75 276) fcolor(red*.7 red*.3 blue*.2 blue*.5 blue) ndocolor(black) osize(vvthin vvthin vvthin vvthin vvthin) ndsize(vthin) legend(position(4) symysize(*1.5) symxsize(*1) textwidth(*9) keygap(*0.5) size(small))
cd \\rschfs1x\userrs\a-e\bp257_RS\Desktop\data\mobility\maps
graph save av_mobility_15-7, replace
graph export av_mobility_15-7.png, replace
*****/