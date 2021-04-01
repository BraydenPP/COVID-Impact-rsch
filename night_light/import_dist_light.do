*import csv data from QGIS
clear
cd \\rschfs1x\userrs\a-e\bp257_RS\Desktop\data\night_light
import delimited pc11_dist_light.csv
rename (censuscode district st_nm st_cen_cd) (pc11_district_id pc11_district_name pc11_state_name pc11_state_id)
rename (_mean v7 v8 v9 v10 v11 v12 v13 v14 v15 v16 v17) (nl01_20 nl02_20 nl03_20 nl04_20 nl05_20 nl06_20 nl07_20 nl08_20 nl09_20 nl10_20 nl11_20 nl12_20)
rename (v18 v19 v20 v21 v22 v23 v24 v25 v26 v27 v28 v29) (nl01_19 nl02_19 nl03_19 nl04_19 nl05_19 nl06_19 nl07_19 nl08_19 nl09_19 nl10_19 nl11_19 nl12_19)
drop dt_cen_cd
save dist_light_20, replace
*****
*importing _ID

merge 1:1 pc11_state_name pc11_district_id using \\rschfs1x\userrs\a-e\bp257_RS\Desktop\data\general/2011_Dist_1
drop _merge sequence district_scode
save dist_light_20, replace
*****
*seperating 2019 and 2020

preserve
drop nl01_20 nl02_20 nl03_20 nl04_20 nl05_20 nl06_20 nl07_20 nl08_20 nl09_20 nl10_20 nl11_20 nl12_20
save dist_light_19, replace
restore

drop nl01_19 nl02_19 nl03_19 nl04_19 nl05_19 nl06_19 nl07_19 nl08_19 nl09_19 nl10_19 nl11_19 nl12_19
save dist_light_20, replace