*Import the distrcit-wise Sum of radiance
*import csv data from QGIS

clear
cd \\rschfs1x\userrs\a-e\bp257_RS\Desktop\data\night_light
import delimited pc11_light_sum.csv
rename (censuscode district st_nm st_cen_cd) (pc11_district_id pc11_district_name pc11_state_name pc11_state_id)
rename (_sum _sum_1 _sum_2 _sum_3 _sum_4 _sum_5 _sum_6 _sum_7 _sum_8 _sum_9 _sum_10 _sum_11) (sum01_20 sum02_20 sum03_20 sum04_20 sum05_20 sum06_20 sum07_20 sum08_20 sum09_20 sum10_20 sum11_20 sum12_20)
rename (v18 v19 v20 v21 v22 v23 v24 v25 v26 v27 v28 v29) (sum01_19 sum02_19 sum03_19 sum04_19 sum05_19 sum06_19 sum07_19 sum08_19 sum09_19 sum10_19 sum11_19 sum12_19)
drop dt_cen_cd
save dist_sum_20, replace
*****
*importing _ID and population & area data

merge 1:1 pc11_state_name pc11_district_id using \\rschfs1x\userrs\a-e\bp257_RS\Desktop\data\general/2011_Dist_1
drop _merge sequence district_scode
merge 1:1 pc11_state_id pc11_district_id using \\rschfs1x\userrs\a-e\bp257_RS\Desktop\data\general/census_data
drop _merge
save dist_sum_20, replace
*****
*seperating 2019 and 2020

drop sum01_20 sum02_20 sum03_20 sum04_20 sum05_20 sum06_20 sum07_20 sum08_20 sum09_20 sum10_20 sum11_20 sum12_20
foreach month in sum01_19 sum02_19 sum03_19 sum04_19 sum05_19 sum06_19 sum07_19 sum08_19 sum09_19 sum10_19 sum11_19 sum12_19 {
	gen `month'_perCapita = `month'/pc11_pop
	gen `month'_perK2 = `month'/pc11_area
}
save dist_sum_19, replace

clear
use dist_sum_20
drop sum01_19 sum02_19 sum03_19 sum04_19 sum05_19 sum06_19 sum07_19 sum08_19 sum09_19 sum10_19 sum11_19 sum12_19
foreach month in sum01_20 sum02_20 sum03_20 sum04_20 sum05_20 sum06_20 sum07_20 sum08_20 sum09_20 sum10_20 sum11_20 sum12_20 {
	gen `month'_perCapita = `month'/pc11_pop
	gen `month'_perK2 = `month'/pc11_area
}
save dist_sum_20, replace
*****