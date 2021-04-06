This folder contains data relevant to nighttime light analysis. Data was collected by the Earth Observation Group at the Colorado School on Mines (https://eogdata.mines.edu/products/vnl/) at (https://eogdata.mines.edu/nighttime_light/monthly/v10/).

GeoTIF files for 2019 have not been trimmed so are very large and have been omitted for up/downloading convenience.


Filing system:
	+ 2020_vcmcfg - VIIRS Cloud Mask data for year 2020.

	+ clip01-20 - A geoTIF file displaying the average radiance recorded across a given month (January 2020) with data rounded to the houndredth decimal. This TIF was clipped to only contain light data from within India.

	+ dist_av_19 and _20 - Contain values for the district-wide average of the average radiance recorded across a given month, for each month of 2019 and 2020, respectively.

	+ dist_sum_19 and _20 - Contain the values for district-wise sum of the average radiance recorded across a given month, for each month of 2019 and 2020, respectively. This dataset additionally supplies the /capita and /square kilometer for each month.

	+ import_dist_light.do - uses QGIS CSV output to generate dist_sum_19 and _20
