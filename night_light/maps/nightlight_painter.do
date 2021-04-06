clear
cd \\rschfs1x\userrs\a-e\bp257_RS\Desktop\data\night_light
use dist_sum_20
cd\\rschfs1x\userrs\a-e\bp257_RS\Desktop\data\night_light\maps


foreach month in sum01_20_perCap sum02_20_perCap sum03_20_perCap sum04_20_perCap sum05_20_perCap sum06_20_perCap sum07_20_perCap sum08_20_perCap sum09_20_perCap sum10_20_perCap sum11_20_perCap sum12_20_perCap {
spmap `month' using \\rschfs1x\userrs\a-e\bp257_RS\Desktop\data\shapefiles/2011_Dist_coord, ///
id(_ID) title() osize(*0.1 *0.1 *0.1 *0.1 *0.1) ocolor(white white white white white) ndsize(0.01)  ndocolor(black) fcolor(green*0.7 yellow*0.6 orange*0.5 red*0.7 white) ///
legend(position(4) symysize(*1.5) symxsize(*1) textwidth(*9) keygap(*0.5) size(small))
graph export `month', as(png) replace
}

******* testing set-up
spmap sum04_20_perK2 using \\rschfs1x\userrs\a-e\bp257_RS\Desktop\data\shapefiles/2011_Dist_coord, ///
id(_ID) title(Nighttime Light) clbreaks(-1 0.4 0.8 1.2 1.6 2) fcolor(black*.9 black*.8 black*.6 black*.4 black*.1) ocolor(white white white white white) osize(*0.1 *0.1 *0.1 *0.1 *0.1) ///
legend(position(4) symysize(*1.5) symxsize(*1) textwidth(*9) keygap(*0.5) size(small))

