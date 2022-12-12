--insert into dw_olap.respop_dim
(select Populations_seq.nextval, p.county_code, P.county, p.observation_date, p.TOTALPOP, u.totpop_under18, u.TOTPOP_AGE_18TO64, u.TOTPOP_AGE_65ANDOVER, p.men, p.women
from populations p 
left outer join uscensus_poverty u on (u.county_code = p.county_code and to_char(u.observation_date, 'yyyy')= to_char(p.observation_date, 'yyyy')));

commit;
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--insert into dw_olap.income_Dim
select income_seq.nextval, p.county_code, P.county, p.observation_date, p.income, u.TOTPOP_BELOWPOV, u.PERCENT_TOTPOP_BELOWPOV
from populations p
left outer join uscensus_poverty u on (u.county_code = p.county_code and to_char(u.observation_date, 'yyyy')= to_char(p.observation_date, 'yyyy'))
;

commit;
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--insert into dw_olap.WUI_DIM
(select WUI_seq.NEXTVAL, county_code, county, observation_date, wui_category, area_squarekm, housing_number, population_count
from WUI);

commit;
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--Data has been imported from Date_Time_Source excel files
select * from dw_olap.time_dim;

commit;
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--insert into dw_olap.counties_dim
(select distinct FIPS, county_code, county, state, 'Southern California' as Resgion
from dw_oltp.Populations);

commit;
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--prepare data from dw_oltp.weather to load into weather_dim
--select distinct area_code, county_name from dw_oltp.weather where county_name not like 'CA:%';
select * from dw_oltp.weather;

select case length(month)
when 1 then to_date('0'||month||'01'||year, 'mmddyyyy')
when 2 then to_date(month||'01'||year, 'mmddyyyy')
end
from dw_oltp.weather;

/*
weather_key number,
County_code varchar2(10),
county varchar2(50),
Weather_date date,
Temp_Max number,
Temp_Min Number,
Precipitation number
*/

--load weather data to weather_DIM
insert into weather_dim
(select weather_seq.nextval, 
case area_code
    when 6025 then 'IMP'
    when 6029 then 'KER'
    when 6037 then 'LA'
    when 6059 then 'ORA'
    when 6065 then 'RIV'
    when 6071 then 'SBD'
    when 6073 then 'SD'
    when 6079 then 'SLO'
    when 6083 then 'SB'
    when 6111 then 'VEN'
end as Count_code,
county_name, 
case length(month)
when 1 then to_date('0'||month||'01'||year, 'mmddyyyy')
when 2 then to_date(month||'01'||year, 'mmddyyyy')
end as Weather_date, 
AVG_TMAX, AVG_TMIN, avg_prcp
from dw_oltp.weather
where county_name not like 'CA:%');

commit;

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
insert into dw_olap.CarbonEmissions_DIM
(
    select CarbonEmission_seq.nextval, 
        County_Code, County,
        to_date('01/01/'||YEAR, 'MM/DD/YYYY'), 
        Plant_Code, Plant_Name, Sector_Group, 
        Sector_Code, Fuel_Code, Generation, 
        Total_Fuel_Consumption, 
        Fuel_Consumption_For_Electric_Generation, 
        Co2_Emissions_Tons, Co2_Emissions_Metrictonnes
    from dw_oltp.carbon_emission
);

select * from dw_olap.carbonemissions_dim;
select to_char(OBSERVATION_DATE, 'MMYYYY') from dw_olap.carbonemissions_dim;
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--dw_oltp.Wildfire and dw_olap.wildfire_fact

select * from dw_olap.wildfire_fact;
--alter table dw_olap.wildfire_fact drop column Acres_Burned;
commit;
/*
--County_Key number,
--Time_Key number,
--Emission_Key number,
--Weather_Key number,
--Population_Key number,
--Income_Key number,
WUI_Key number,
*/

select * from dw_olap.wildfire_fact;

/*
--insert into dw_olap.wildfire_fact
(select --wildfire_seq.nextval as wildfire_key, 
c.county_key,
(select time_key from dw_olap.time_dim where full_date = to_date(trunc(sysdate), 'DD-MON-YY')) as time_key,
ce.emissions_key,
wt.weather_key, r.POPULATION_KEY, i.INCOME_KEY, wui.wui_key,
w.INCIDENT_LONGITUDE, w.INCIDENT_LATITUDE, w.INCIDENT_DATEONLY_CREATED, w.INCIDENT_DATEONLY_EXTINGUISHED, w.INCIDENT_COUNTY, w.INCIDENT_STATE, 
w.INCIDENT_ACRES_BURNED, w.DAILYACRES, w.DISCOVERYACRES, w.INCIDENT_NAME, w.INCIDENT_TYPE, w.INCIDENT_ID,
    case 
     when w.INCIDENT_DATEONLY_EXTINGUISHED is null then 'YES'
     when w.INCIDENT_DATEONLY_EXTINGUISHED is not null then 'No'
    end as Active_ind,
    case
     when w.INCIDENT_ID is null then 'No'
     when w.INCIDENT_ID is not null then 'Yes'
    end as CalFire_Inc
from dw_oltp.wildfire w
left outer join dw_olap.counties_dim c on (c.county_name = w.INCIDENT_COUNTY)
left outer join dw_olap.CarbonEmissions_DIM ce on (ce.county_code = w.County_code and to_char(ce.OBSERVATION_DATE, 'MMYYYY') = to_char(w.INCIDENT_DATEONLY_CREATED, 'MMYYYY'))
left outer join dw_olap.weather_dim wt on (wt.county_code = w.county_code and to_char(wt.weather_date, 'MMYYYY')=to_char(w.INCIDENT_DATEONLY_CREATED, 'MMYYYY'))
left outer join dw_olap.ResPop_dim r on (r.county_code = wt.county_code and to_char(r.ResPop_date, 'MMYYYY') = to_char(w.INCIDENT_DATEONLY_CREATED, 'MMYYYY'))
left outer join dw_olap.Income_dim i on (i.county_code = wt.county_code and to_char(i.Income_date, 'MMYYYY') = to_char(w.INCIDENT_DATEONLY_CREATED, 'MMYYYY'))
left outer join dw_olap.WUI_dim wui on (wui.county_code = wt.county_code and to_char(wui.WUI_date, 'MMYYYY') = to_char(w.INCIDENT_DATEONLY_CREATED, 'MMYYYY'))
);
*/

--insert into dw_olap.wildfire_fact
(select --wildfire_seq.nextval as wildfire_key, 
c.county_key,
(select time_key from dw_olap.time_dim where full_date = to_date(trunc(sysdate), 'DD-MON-YY')) as time_key,
ce.emissions_key,
wt.weather_key, r.POPULATION_KEY, i.INCOME_KEY, wui.wui_key,
w.INCIDENT_LONGITUDE, w.INCIDENT_LATITUDE,
w.INCIDENT_DATEONLY_CREATED, w.INCIDENT_DATEONLY_EXTINGUISHED, 
--w.INCIDENT_COUNTY, w.INCIDENT_STATE, 
w.INCIDENT_ACRES_BURNED, w.DAILYACRES, w.DISCOVERYACRES, w.INCIDENT_NAME, w.INCIDENT_TYPE, w.INCIDENT_ID,
    case 
     when w.INCIDENT_DATEONLY_EXTINGUISHED is null then 'YES'
     when w.INCIDENT_DATEONLY_EXTINGUISHED is not null then 'No'
    end as Active_ind,
    case
     when w.INCIDENT_ID is null then 'No'
     when w.INCIDENT_ID is not null then 'Yes'
    end as CalFire_Inc,
    null
from dw_oltp.wildfire w 
inner join dw_olap.ResPop_dim r on (r.county_code = w.county_code and to_char(r.ResPop_date, 'MMYYYY') = to_char(w.INCIDENT_DATEONLY_CREATED, 'MMYYYY'))
inner join dw_olap.Income_dim i on (i.county_code = w.county_code and to_char(i.Income_date, 'MMYYYY') = to_char(w.INCIDENT_DATEONLY_CREATED, 'MMYYYY'))
inner join dw_olap.WUI_dim wui on (wui.county_code = w.county_code and to_char(wui.WUI_date, 'MMYYYY') = to_char(w.INCIDENT_DATEONLY_CREATED, 'MMYYYY'))
inner join dw_olap.counties_dim c on (c.county_code = w.county_code)
inner join dw_olap.CarbonEmissions_DIM ce on (ce.county_code = w.County_code and to_char(ce.OBSERVATION_DATE, 'MMYYYY') = to_char(w.INCIDENT_DATEONLY_CREATED, 'MMYYYY'))
inner join dw_olap.weather_dim wt on (wt.county_code = w.county_code and to_char(wt.weather_date, 'MMYYYY')=to_char(w.INCIDENT_DATEONLY_CREATED, 'MMYYYY'))
);
--114,552 rows inserted.

--queries to verify the data for Keys selected from dim tables to load in wildfire_fact .
select * from dw_oltp.wildfire;
select * from dw_olap.counties_dim;
select * from dw_olap.time_dim;
select time_key from dw_olap.time_dim where full_date = to_date(trunc(sysdate), 'DD-MON-YY');
select to_char(INCIDENT_DATEONLY_CREATED, 'MMYYYY') from dw_oltp.wildfire;
select * from dw_olap.weather_dim where weather_key = 13236;--07-JAN-20	San Bernardino
select * from dw_olap.ResPop_dim where population_key = 6967;--07-JAN-20	San Bernardino
select * from income_dim where income_key = 7167;--
select * from dw_olap.WUI_dim where wui_key = 26297;--

select * from dw_olap.wildfire_fact;