/*
data from:
http://getapi.indiatvnews.com/doc/listofRGBzones.pdf
*/
clear
use \\rschfs1x\userrs\a-e\bp257_RS\Desktop\data\mobility/unlock_colors

spmap strictness using \\rschfs1x\userrs\a-e\bp257_RS\Desktop\data\shapefiles/2011_dist_coord, id(_ID) fcolor(green*.6 orange*.6 red*.6 white) title("17/5 Lockdown Strictness") osize(vvthin vvthin vvthin vvthin) ocolor(white white white white) ndsize(vthin) ndocolor(black) legend(position(4) symysize(*1.5) symxsize(*1) textwidth(*9) keygap(*0.5) size(small))
*****

cd \\rschfs1x\userrs\a-e\bp257_RS\Desktop\data\mobility\maps
graph save lockdown_colors_17-5, replace
graph export lockdown_colors_17-5.png, replace