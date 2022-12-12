--OLTP tables creation:
--create table populations as
select * from dw_olap.populations;
--ALTER TABLE populations ADD CONSTRAINT populations_pk PRIMARY KEY (observation_date, FIPS, county_code);
--commit;
select * from populations;

--create table uscensus_poverty as
select * from dw_olap.uscensus_poverty;
--ALTER TABLE uscensus_poverty ADD CONSTRAINT USCensus_Poverty_pk PRIMARY KEY (observation_date, geo_id, county_code);
--commit;
select * from uscensus_poverty;

select * from WUI;
ALTER TABLE WUI ADD CONSTRAINT WUI_pk PRIMARY KEY (observation_date, FIPS, county_code, WUI_category);
commit;


------------------------------------------------------------------------------------------------------------------
--sequence creation
CREATE SEQUENCE Populations_seq
 START WITH     1000
 INCREMENT BY   1
 NOCACHE
 NOCYCLE;
 
 CREATE SEQUENCE Income_seq
 START WITH     1100
 INCREMENT BY   1
 NOCACHE
 NOCYCLE;
 
 CREATE SEQUENCE WUI_seq
 START WITH     11100
 INCREMENT BY   1
 NOCACHE
 NOCYCLE;
 
 CREATE SEQUENCE Weather_seq
 START WITH     10000
 INCREMENT BY   1
 NOCACHE
 NOCYCLE;
 
 CREATE SEQUENCE CarbonEmission_seq
 START WITH     10100
 INCREMENT BY   1
 NOCACHE
 NOCYCLE;
 
CREATE SEQUENCE Wildfire_seq
 START WITH     10010
 INCREMENT BY   1
 NOCACHE
 NOCYCLE;
 
 
 
 commit;