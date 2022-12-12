/*Oct 30, 2022 */
create table ResPop_DIM
(
Population_Key number,
County_code varchar2(10),
county varchar2(50),
ResPop_Date date,
Total_Population number,
Young_Pop_Cnt number,
Adult_Pop_Cnt number,
Old_Pop_Cnt number,
Male_Pop_Cnt number,
Female_Pop_Cnt number,
PRIMARY KEY (Population_Key)
);

create table Income_DIM
(
Income_Key number,
County_code varchar2(10),
county varchar2(50),
Income_Date date,
Income number,
TotPop_BelowPov number,
Pct_TotPop_BelowPov number,
PRIMARY KEY (Income_Key)
);

create table WUI_DIM
(
WUI_Key number,
County_code varchar2(10),
county varchar2(50),
WUI_Date date,
WUI_Category varchar2(20),
Total_Area number,
Housing number,
Population number,
PRIMARY KEY (WUI_Key)
);

create table Time_DIM
(
Time_Key number,
Full_Date Date,
Day_Of_week varchar2(15),
Day_Num_in_Month number,
Day_Name varchar2(15),
Weekday_flag varchar2(10),
Week_Num_in_Year number,
Month_Num number,
Month_Name varchar2(15),
Quarter number,
Year_Value number,
PRIMARY KEY (Time_Key)
);

Create table Counties_DIM
(
County_Key number,
County_Code varchar2(5),
County_Name varchar2(50),
State varchar2(5),
Region varchar2(25),
PRIMARY KEY (county_key)
);

--created on 11/3/2022
create table Weather_DIM
(
Weather_key number,
County_code varchar2(10),
county varchar2(50),
Weather_date date,
Temp_Max number,
Temp_Min Number,
Precipitation number,
PRIMARY KEY (Weather_Key)
);

---------------------------------------------------------------------------
--created on Nov 03 2022 at 10:44pm(PST)
Create table Wildfire_Fact
(
Wildfire_Key Number,
County_Key Number,
Time_Key Number,
Emission_Key Number,
Weather_Key Number,
Population_Key Number,
Income_Key Number,
WUI_Key Number,
Incident_Creation_Date Date,
Incident_Extinguished_Date Date,
Incident_Acres_Burned Number,
Dailyacres	Number,
Discoveryacres	Number,
Incident_Name	Varchar2(50),
Incident_Type	Varchar2(26),
Incident_Id	Varchar2(50),
Active_Ind Varchar2(5),
Calfire_Inc Varchar2(5),
Primary Key (Wildfire_Key)
);

CREATE SEQUENCE Wildfire_seq
 START WITH     10010
 INCREMENT BY   1
 NOCACHE
 NOCYCLE;
 
 
--------------------------------------------------------------------------------
-- created  on 11/4/2022 10:00pm (PST)
create table dw_olap.CarbonEmissions_DIM
(
Emissions_Key number,
County_Code	VARCHAR2(5),
County_Name	VARCHAR2(26),
Observation_Date date,
PLANT_CODE	NUMBER(3),
PLANT_NAME	VARCHAR2(128),
SECTOR_GROUP	VARCHAR2(26),
SECTOR_CODE	NUMBER(38),
FUEL_CODE	VARCHAR2(26),
GENERATION	NUMBER(38),
TOTAL_FUEL_CONSUMPTION	NUMBER(38),
FUEL_CONSUMPTION_FOR_ELECTRIC_GENERATION	NUMBER(38),
CO2_EMISSIONS_TONS	NUMBER(38),
CO2_EMISSIONS_METRICTONNES	NUMBER(38),
PRIMARY KEY (Emissions_Key)
);

CREATE SEQUENCE CarbonEmission_seq
 START WITH     10100
 INCREMENT BY   1
 NOCACHE
 NOCYCLE;

alter table dw_olap.CarbonEmissions_dim modify CO2_EMISSIONS_TONS NUMBER(38,8);
alter table dw_olap.CarbonEmissions_dim modify CO2_EMISSIONS_METRICTONNES NUMBER(38,8);
alter table dw_olap.CarbonEmissions_dim modify Emissions_Key number(10);
alter table dw_olap.CarbonEmissions_dim modify PLANT_CODE NUMBER(38,0);
commit;

truncate table dw_olap.wildfire_fact;
commit;