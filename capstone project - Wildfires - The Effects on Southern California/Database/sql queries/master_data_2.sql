
select distinct c.county_code, c.county_name, w.Incident_Creation_Date, wt.Temp_Max, wt.Temp_Min, wt.Precipitation, r.Total_Population, 
    i.Income, i.Totpop_Belowpov, i.Pct_Totpop_Belowpov, w.Wildfire_Frequency, w.Incident_Acres_Burned, W.Wildfire_Frequency, 
    w.Incident_Longitude, w.Incident_Latitude, w.Incident_Name, w.Incident_Type, w.Incident_Id, w.Active_Ind, w.Calfire_Inc, 
    ce.Total_Fuel_Consumption, ce.Co2_Emissions_Tons, ce.Co2_Emissions_Metrictonnes
from dw_olap.wildfire_fact w
left outer join dw_olap.counties_dim c on (c.county_key = w.county_key)
left outer join dw_olap.carbonemissions_dim ce on (ce.emissions_key = w.emission_key)
left outer join dw_olap.weather_dim wt on (wt.weather_key = w.weather_key)
left outer join dw_olap.respop_dim r on (r.population_key = w.population_key)
left outer join dw_olap.income_dim i on (i.income_key = w.income_key)
;
--24905



/*
group by (c.county_code, c.county_name, w.INCIDENT_CREATION_DATE,
wt.TEMP_MAX, wt.TEMP_MIN, wt.PRECIPITATION,
r.TOTAL_POPULATION,
i.INCOME, i.TOTPOP_BELOWPOV, i.PCT_TOTPOP_BELOWPOV,
wui.TOTAL_AREA, wui.HOUSING, wui.POPULATION,
w.wildfire_frequency, w.INCIDENT_ACRES_BURNED,
w.INCIDENT_LONGITUDE, w.INCIDENT_LATITUDE, w.INCIDENT_NAME, w.INCIDENT_TYPE, w.INCIDENT_ID, w.ACTIVE_IND, w.CALFIRE_INC))
;
*/
--1603

select * from dw_olap.carbonemissions_dim;
select * from dw_olap.weather_dim ;
select * from dw_olap.Respop_dim;
select * from dw_olap.income_dim;
select * from dw_olap.WUI_dim;

select to_char(INCIDENT_DATEONLY_CREATED, 'MMYYYY') from dw_oltp.wildfire where to_char(incident_dateonly_created, 'DD-MON-YY') = '20-APR-13';
--to_char(INCIDENT_DATEONLY_CREATED, 'MMYYYY')
select * from dw_oltp.wildfire;

select distinct to_char(incident_dateonly_created, 'MMYYYY') from dw_oltp.wildfire order by 1;
select * from dw_oltp.weather order by year, month; 
select to_char(respop_date, 'MMYYYY') from respop_dim order by 1;
select to_char(Income_date, 'MMYYYY') from income_dim order by 1;
select to_char(observation_date, 'MMYYYY') from carbonemissions_dim order by 1;

select count(*) from dw_olap.wildfire_fact;

select * from respop_dim;
select count(distinct wildfire_key) from wildfire_fact;
select count(*) from dw_oltp.wildfire;
select * from carbonemissions_dim;



select * from wildfire_fact w
left join carbonemissions_dim c on (c.emissions_key = w.emission_key);

select * from carbonemissions_dim;
select county_code, observation_date, count(*) from carbonemissions_dim
group  by county_code, observation_date;

select * from dw_oltp.wildfire
where to_char(INCIDENT_DATEONLY_CREATED,'YYYY') <= '2020';

--==========================================================================================

--add wildfire frequency to wildfire_fact;
select distinct to_char(incident_dateonly_created, 'MMYYYY'), incident_county, count(ID) 
from dw_oltp.wildfire
group by to_char(incident_dateonly_created, 'MMYYYY'), incident_county;

select * from dw_oltp.wildfire;

select county_key, incident_creation_date, count(1)
from dw_oltp.wildfire
where incident_type = 'WF' 
group by county_key, incident_creation_date;