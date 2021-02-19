
clear
cd \\rschfs1x\userrs\a-e\bp257_RS\Desktop\data\shapefiles

*shp2dta using gadm36_IND_0, database(IND_0) coordinates(IND_0_coord) genid(country_id)
*shp2dta using gadm36_IND_1, database(IND_1) coordinates(IND_1_coord) genid(pc11_state_id)
shp2dta using gadm36_IND_2, database(IND_2) coordinates(IND_2_coord) genid(dist_ID)
*shp2dta using gadm36_IND_3, database(IND_3) coordinates(IND_3_coord) genid(pc11_subdistrict_id)

use IND_2, clear