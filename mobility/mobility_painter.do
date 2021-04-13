clear
cd \\rschfs1x\userrs\a-e\bp257_RS\Desktop\data\mobility
import delimited Google_mobility.csv
save google_mobility, replace
*****/
*cleaning data

drop country_region country_region_code census_fips_code iso_3166_2_code metro_area place_id
rename (sub_region_1 sub_region_2) (simport dimport)
rename (retail_and_recreation_percent_ch grocery_and_pharmacy_percent_cha parks_percent_change_from_baseli transit_stations_percent_change_ workplaces_percent_change_from_b residential_percent_change_from_) (retail_rec grocery_pharm parks transit workplace residential)
drop if dimport ==""

gen date2 = date(date, "YMD")
format date2 %td
drop if date2 >= date("20210101","YMD")
gen month = mofd(date2)
format month %tm
save monthly_mobility, replace

sort dimport month
by dimport month: egen retail_rec_av= mean(retail_rec)
by dimport month: egen grocery_pharm_av= mean(grocery_pharm)
by dimport month: egen workplace_av= mean(workplace)
by dimport month: egen residential_av= mean(residential)
by dimport month: keep if _n==1
egen av_mobility= rowmean(retail_rec_av grocery_pharm_av workplace_av)
drop date date2 retail_rec grocery_pharm workplace residential transit parks
save monthly_mobility, replace
*****/
*keep only a selected month. This needs to be done before the merge or not matched observations will not be displayed on the map. change month by changing the # after 2020m

keep if month == tm(2020m5)
*merging in pc11 names and _ID

sort simport dimport
merge m:1 simport dimport using import_names
rename (dimport simport) (google_districts google_states)
drop _merge
*****
*av_mobility map

spmap av_mobility using \\rschfs1x\userrs\a-e\bp257_RS\Desktop\data\shapefiles/2011_dist_coord, id(_ID) clnumber(4) clmethod(custom) clbreaks(-47 -33 -17.88 0 13) fcolor(red red*.5 red*.2 blue*.6) ndocolor(black) osize(vvthin vvthin vvthin vvthin vvthin) ndsize(vthin) legend(position(4) symysize(*1.5) symxsize(*1) textwidth(*9) keygap(*0.5) size(small))
//saving dont forget to change file name to kept month
cd \\rschfs1x\userrs\a-e\bp257_RS\Desktop\data\mobility\maps
graph save mobility_change_3 replace
graph export mobility_change_3.png, replace
*****
