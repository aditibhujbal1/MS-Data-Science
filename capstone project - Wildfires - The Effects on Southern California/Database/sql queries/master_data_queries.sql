select county_key, incident_creation_date, count(1)
from wildfire_fact
where incident_type = 'WF' 
group by county_key, incident_creation_date;

--alter table wildfire_fact add wildfire_frequency number(38,8) null;
--commit;

select distinct county_key, incident_creation_date, wildfire_frequency from wildfire_fact where incident_type = 'WF';

select * from counties_dim;
-------------------------------------------------------------------------------------------------------------------------------------
select * from wui_dim;

select * from dw_olap.wildfire_fact where incident_name = 'SECA';

select * from counties_dim where county_key = 6071;

select distinct c.county_code, c.county_name, w.INCIDENT_CREATION_DATE,
wt.TEMP_MAX, wt.TEMP_MIN, wt.PRECIPITATION,
r.TOTAL_POPULATION,
i.INCOME, i.TOTPOP_BELOWPOV, i.PCT_TOTPOP_BELOWPOV, 
wui.TOTAL_AREA as "WUI_AREA", wui.HOUSING, wui.POPULATION,
w.wildfire_key, w.wildfire_frequency, w.INCIDENT_ACRES_BURNED, w.wildfire_frequency, 
w.INCIDENT_LONGITUDE, w.INCIDENT_LATITUDE, w.INCIDENT_NAME, w.INCIDENT_TYPE, w.INCIDENT_ID, w.ACTIVE_IND, w.CALFIRE_INC,
--ce.TOTAL_FUEL_CONSUMPTION, ce.CO2_EMISSIONS_TONS, ce.CO2_EMISSIONS_METRICTONNES
sum(ce.TOTAL_FUEL_CONSUMPTION), sum(ce.CO2_EMISSIONS_TONS), sum(ce.CO2_EMISSIONS_METRICTONNES)
from dw_olap.wildfire_fact w
left outer join dw_olap.counties_dim c on (c.county_key = w.county_key)
left outer join dw_olap.carbonemissions_dim ce on (ce.emissions_key = w.emission_key)
left outer join dw_olap.weather_dim wt on (wt.weather_key = w.weather_key)
left outer join dw_olap.respop_dim r on (r.population_key = w.population_key)
left outer join dw_olap.income_dim i on (i.income_key = w.income_key)
left outer join dw_olap.wui_dim wui on (wui.wui_key = w.wui_key)
group by (c.county_code, c.county_name, w.INCIDENT_CREATION_DATE,
wt.TEMP_MAX, wt.TEMP_MIN, wt.PRECIPITATION,
r.TOTAL_POPULATION,
i.INCOME, i.TOTPOP_BELOWPOV, i.PCT_TOTPOP_BELOWPOV,
wui.TOTAL_AREA, wui.HOUSING, wui.POPULATION,
w.wildfire_key, w.wildfire_frequency, w.INCIDENT_ACRES_BURNED,
w.INCIDENT_LONGITUDE, w.INCIDENT_LATITUDE, w.INCIDENT_NAME, w.INCIDENT_TYPE, w.INCIDENT_ID, w.ACTIVE_IND, w.CALFIRE_INC)
;