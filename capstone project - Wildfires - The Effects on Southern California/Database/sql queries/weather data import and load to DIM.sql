--create weather_dim 
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

--create sequence for to generate weather_key
 CREATE SEQUENCE Weather_seq
 START WITH     10000
 INCREMENT BY   1
 NOCACHE
 NOCYCLE;
 
--load data from excel/csv file and create "weather" table 

--prepare data from weather to load into weather_dim
--select distinct area_code, county_name from dw_oltp.weather where county_name not like 'CA:%';
select * from weather;

select 
case length(month)
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
from weather
where county_name not like 'CA:%');

commit;
