--delete from populations where FIPS is null;
select to_char(observation_date, 'yyyy') from populations;
select * from populations;

--ALTER TABLE populations drop CONSTRAINT populations_pk;
--ALTER TABLE populations ADD CONSTRAINT populations_pk PRIMARY KEY (observation_date, FIPS, county_code);
--commit;

select * from uscensus_poverty ;
--update uscensus_poverty set county_code = 'CAL_State' where geo_id = '0400000US06';
--commit;

--ALTER TABLE uscensus_poverty drop CONSTRAINT USCensus_Poverty_pk;
--ALTER TABLE uscensus_poverty ADD CONSTRAINT USCensus_Poverty_pk PRIMARY KEY (observation_date, geo_id, county_code);
--commit;


select * from WUI;

--alter table WUI Rename column OBERVATION_DATE to observation_date;
--commit;

--ALTER TABLE WUI ADD CONSTRAINT WUI_pk PRIMARY KEY (observation_date, FIPS, county_code);
--commit;

select distinct FIPS, county from wui;

/*
6025	Imperial
6029	Kern
6037	Los Ange
6059	Orange
6065	Riversid
6071	San Bern
6073	San Dieg
6111	Ventura
6079	San Luis
6083	Santa Ba
*/
select distinct area_code, county_name from weather where county_name not like 'CA%:%';
/*
4025	Imperial
4029	Kern
4037	Los Angeles
4059	Orange
4065	Riverside
4071	San Bernardino
4073	San Diego
4079	San Luis Obispo
4083	Santa Barbara
4111	Ventura
*/

update weather set area_code = 6025 where area_code = 4025;
update weather set area_code = 6029 where area_code = 4029;
update weather set area_code = 6037 where area_code = 4037;
update weather set area_code = 6059 where area_code = 4059;
update weather set area_code = 6065 where area_code = 4065;
update weather set area_code = 6071 where area_code = 4071;
update weather set area_code = 6073 where area_code = 4073;
update weather set area_code = 6079 where area_code = 4079;
update weather set area_code = 6083 where area_code = 4083;
update weather set area_code = 6111 where area_code = 4111;
commit;
select * from weather where area_code > 6000;

--alter table dw_oltp.weather add county_code varchar2(5) null;

update weather set county_code = 'IMP' where COUNTY_NAME = 'Imperial';
update weather set county_code = 'KER' where COUNTY_NAME = 'Kern';
update weather set county_code = 'LA' where COUNTY_NAME = 'Los Angeles' ;
update weather set county_code = 'ORA' where COUNTY_NAME = 'Orange' ;
update weather set county_code = 'RIV' where COUNTY_NAME = 'Riverside' ;
update weather set county_code = 'SBD' where COUNTY_NAME = 'San Bernardino';
update weather set county_code = 'SD' where COUNTY_NAME = 'San Diego';
update weather set county_code = 'SLO' where COUNTY_NAME = 'San Luis Obispo';
update weather set county_code = 'SB' where COUNTY_NAME = 'Santa Barbara';
update weather set county_code = 'VEN' where COUNTY_NAME = 'Ventura';
commit;

select * from dw_oltp.weather where area_code > 6000 and county_code is null;
--------------------------------------------------------------------------------------------------

select count(*) from wildfire;
alter table wildfire modify incident_id varchar(50);
commit;

/*
Wildfire_Key number,
County_Key number,
Time_Key number,
Emission_Key number,
Weather_Key number,
Population_Key number,
Income_Key number,
WUI_Key number,
Wildfire_frequency number,
Acres_Burned number,
Active_ind varchar2(5),
CalFire_Inc varchar2(5),
PRIMARY KEY (Wildfire_key)
*/


select w.*, 
    case 
     when w.INCIDENT_DATEONLY_EXTINGUISHED is null then 'YES'
     when w.INCIDENT_DATEONLY_EXTINGUISHED is not null then 'No'
    end as Active_ind,
    case
     when w.INCIDENT_ID is null then 'No'
     when w.INCIDENT_ID is not null then 'Yes'
    end as CalFire_Inc
from wildfire w;

--alter table dw_oltp.wildfire add county_code varchar2(5);
--commit;
select county_code from wildfire;

/*
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
*/
--commit;

alter table dw_oltp.carbon_emission add county_code varchar2(5) null;
commit;


update dw_oltp.carbon_emission set county_code ='IMP' where county = 'Imperial';
update dw_oltp.carbon_emission set county_code = 'KER' where county='Kern';
update dw_oltp.carbon_emission set county_code = 'LA' where county='Los Angeles';
update dw_oltp.carbon_emission set county_code = 'ORA' where county='Orange';
update dw_oltp.carbon_emission set county_code = 'SBD' where county='San Bernardino';
update dw_oltp.carbon_emission set county_code = 'SD' where county='San Diego';
update dw_oltp.carbon_emission set county_code = 'RIV' where county='Riverside';
update dw_oltp.carbon_emission set county_code = 'SLO' where county='San Luis Obispo';
update dw_oltp.carbon_emission set county_code = 'SB' where county='Santa Barbara';
update dw_oltp.carbon_emission set county_code = 'VEN' where county='Ventura';


select distinct ce.county, c.county_name, c.county_code
from dw_oltp.carbon_emission ce
left outer join dw_olap.counties_dim c on (c.County_Name = ce.county);

commit;

select --CarbonEmission_seq.nextval, 
to_date('01/01/'||YEAR, 'MM/DD/YYYY'), COUNTY_CODE, COUNTY, PLANT_CODE, PLANT_NAME, SECTOR_GROUP, SECTOR_CODE, FUEL_CODE, GENERATION, 
TOTAL_FUEL_CONSUMPTION, FUEL_CONSUMPTION_FOR_ELECTRIC_GENERATION, CO2_EMISSIONS_TONS, CO2_EMISSIONS_METRICTONNES
from carbon_emission;




