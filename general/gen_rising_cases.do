clear
use \\rschfs1x\userrs\a-e\bp257_RS\Desktop\data\raw/covid_infected_deaths_pc11

destring pc11_district_id pc11_state_id, replace
drop if pc11_district_id==0
gen month = mofd(date)
format month %tm

bysort pc11_district_id month: egen case_count = min(total_cases)
gen monthly_cases = total_cases - case_count
bysort pc11_district_id month: egen rising_cases = mean(monthly_cases)

bysort pc11_district_id month: egen death_count = min(total_deaths)
gen monthly_deaths = total_deaths - death_count
bysort pc11_district_id month: egen rising_deaths = mean(monthly_deaths)

bysort pc11_district_id month: keep if _n==_N
keep pc11_state_id pc11_district_id month total_cases total_deaths monthly_cases rising_cases monthly_deaths rising_deaths
order pc11_state_id pc11_district_id month total_cases total_deaths monthly_cases rising_cases monthly_deaths rising_deaths
save \\rschfs1x\userrs\a-e\bp257_RS\Desktop\data\general/district-wise_cases_deaths, replace