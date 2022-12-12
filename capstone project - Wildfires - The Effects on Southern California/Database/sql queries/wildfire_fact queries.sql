Create table Wildfire_Fact
(
Wildfire_Key number,
County_Key number,
Time_Key number,
Emission_Key number,
Weather_Key number,
Population_Key number,
Income_Key number,
WUI_Key number,
INCIDENT_LONGITUDE number,
INCIDENT_LATITUDE number,
INCIDENT_CREATION_DATE date,
INCIDENT_EXTINGUISHED_DATE date,
INCIDENT_ACRES_BURNED number,
DAILYACRES	NUMBER,
DISCOVERYACRES	NUMBER,
INCIDENT_NAME	VARCHAR2(50),
INCIDENT_TYPE	VARCHAR2(26),
INCIDENT_ID	VARCHAR2(50),
Acres_Burned number,
Active_ind varchar2(5),
CalFire_Inc varchar2(5),
PRIMARY KEY (Wildfire_key)
);

CREATE SEQUENCE Wildfire_seq
 START WITH     10010
 INCREMENT BY   1
 NOCACHE
 NOCYCLE;

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--add column county_code and update values

alter table dw_oltp.wildfire add county_code varchar2(5);

select county_code from wildfire;

update wildfire set county_code = 'IMP' where INCIDENT_COUNTY = 'Imperial';
update wildfire set county_code = 'KER' where INCIDENT_COUNTY = 'Kern';
update wildfire set county_code = 'LA' where INCIDENT_COUNTY = 'Los Angeles' ;
update wildfire set county_code = 'ORA' where INCIDENT_COUNTY = 'Orange' ;
update wildfire set county_code = 'RIV' where INCIDENT_COUNTY = 'Riverside' ;
update wildfire set county_code = 'SBD' where INCIDENT_COUNTY = 'San Bernardino';
update wildfire set county_code = 'SD' where INCIDENT_COUNTY = 'San Diego';
update wildfire set county_code = 'SLO' where INCIDENT_COUNTY = 'San Luis Obispo';
update wildfire set county_code = 'SB' where INCIDENT_COUNTY = 'Santa Barbara';
update wildfire set county_code = 'VEN' where INCIDENT_COUNTY = 'Ventura';

commit;

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--select data from dw_oltp.wildfire and all dimension tables

--insert into dw_olap.wildfire_fact
(select --wildfire_seq.nextval as wildfire_key, 
c.county_key,
(select time_key from dw_olap.time_dim where full_date = to_date(trunc(sysdate), 'DD-MON-YY')) as time_key,
--e.emission_key,
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
--left outer join dw_olap.CarbonEmissions_DIM ce on (ce.county_code = w.County_code and to_char(ce.emission_date, 'MMYYYY') = to_char(w.INCIDENT_DATEONLY_CREATED, 'MMYYYY'))
left outer join dw_olap.weather_dim wt on (wt.county_code = w.county_code and to_char(wt.weather_date, 'MMYYYY')=to_char(w.INCIDENT_DATEONLY_CREATED, 'MMYYYY'))
left outer join dw_olap.ResPop_dim r on (r.county_code = wt.county_code and to_char(r.ResPop_date, 'MMYYYY') = to_char(w.INCIDENT_DATEONLY_CREATED, 'MMYYYY'))
left outer join dw_olap.Income_dim i on (i.county_code = wt.county_code and to_char(i.Income_date, 'MMYYYY') = to_char(w.INCIDENT_DATEONLY_CREATED, 'MMYYYY'))
left outer join dw_olap.WUI_dim wui on (wui.county_code = wt.county_code and to_char(wui.WUI_date, 'MMYYYY') = to_char(w.INCIDENT_DATEONLY_CREATED, 'MMYYYY'))
);

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
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