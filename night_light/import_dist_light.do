/*1st we import the distrcit-wise AVERAGE radiance
*import csv data from QGIS

clear
cd \\rschfs1x\userrs\a-e\bp257_RS\Desktop\data\night_light
import delimited pc11_light_av.csv
rename (censuscode district st_nm st_cen_cd) (pc11_district_id pc11_district_name pc11_state_name pc11_state_id)
rename (_mean _mean_1 _mean_2 _mean_3 _mean_4 _mean_5 _mean_6 _mean_7 _mean_8 _mean_9 _mean_10 _mean_11) (mean01_20 mean02_20 mean03_20 mean04_20 mean05_20 mean06_20 mean07_20 mean08_20 mean09_20 mean10_20 mean11_20 mean12_20)
rename (v18 v19 v20 v21 v22 v23 v24 v25 v26 v27 v28 v29) (mean01_19 mean02_19 mean03_19 mean04_19 mean05_19 mean06_19 mean07_19 mean08_19 mean09_19 mean10_19 mean11_19 mean12_19)
drop dt_cen_cd
save dist_av_20, replace
*****
*importing _ID

merge 1:1 pc11_state_name pc11_district_id using \\rschfs1x\userrs\a-e\bp257_RS\Desktop\data\general/2011_Dist_1
drop _merge sequence district_scode
save dist_av_20, replace
*****
*seperating 2019 and 2020

preserve
drop mean01_20 mean02_20 mean03_20 mean04_20 mean05_20 mean06_20 mean07_20 mean08_20 mean09_20 mean10_20 mean11_20 mean12_20
save dist_av_19, replace
restore

drop mean01_19 mean02_19 mean03_19 mean04_19 mean05_19 mean06_19 mean07_19 mean08_19 mean09_19 mean10_19 mean11_19 mean12_19
save dist_av_20, replace
***************/

***************
*doing the above for distrcit-wise SUM of night light
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