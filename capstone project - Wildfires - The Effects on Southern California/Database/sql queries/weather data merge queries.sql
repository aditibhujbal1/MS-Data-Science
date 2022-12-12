-- 2019
select * from tmin_2019;
select * from tmax_2019;
select * from prcp_2019;

select t1.*, t2.avg_tmax, p.avg_prcp
from tmin_2019 t1
left outer join tmax_2019 t2 on (t1.area_code = t2.area_code and t1.year=t2.year and t1.month=t2.month)
left outer join prcp_2019 p on (t1.area_code = p.area_code and t1.year=p.year and t1.month=p.month);

------------------------------------------------------------------------------------------------------------------
--2016
select * from tmin_2016;
select * from tmax_2016;
select * from prcp_2016;

/*
4025	Imperial
4029	Kern
4037	Los Angeles
4059	Orange
4065	Riverside
4071	San Bernardino
4073    San Diego
4079	San Luis Obispo
4083	Santa Barbara
4111	Ventura
*/

--update county_name in TMIX_YYYY
update tmax_2016 set county_name = 'Imperial' where area_code = 4025;
update tmax_2016 set county_name = 'Kern' where area_code = 4029;
update tmax_2016 set county_name = 'Los Angeles' where area_code = 4037;
update tmax_2016 set county_name = 'Orange' where area_code = 4059;
update tmax_2016 set county_name = 'Riverside' where area_code = 4065;
update tmax_2016 set county_name = 'San Bernardino' where area_code = 4071;
update tmax_2016 set county_name = 'San Diego' where area_code = 4073;
update tmax_2016 set county_name = 'San Luis Obispo' where area_code = 4079;
update tmax_2016 set county_name = 'Santa Barbara' where area_code = 4083;
update tmax_2016 set county_name = 'Ventura' where area_code = 4111;

--update county_name in TMIN_YYYY
update tmin_2016 set county_name = 'Imperial' where area_code = 4025;
update tmin_2016 set county_name = 'Kern' where area_code = 4029;
update tmin_2016 set county_name = 'Los Angeles' where area_code = 4037;
update tmin_2016 set county_name = 'Orange' where area_code = 4059;
update tmin_2016 set county_name = 'Riverside' where area_code = 4065;
update tmin_2016 set county_name = 'San Bernardino' where area_code = 4071;
update tmin_2016 set county_name = 'San Diego' where area_code = 4073;
update tmin_2016 set county_name = 'San Luis Obispo' where area_code = 4079;
update tmin_2016 set county_name = 'Santa Barbara' where area_code = 4083;
update tmin_2016 set county_name = 'Ventura' where area_code = 4111;

--update county_name in PRCP_YYYY
update PRCP_2016 set county_name = 'Imperial' where area_code = 4025;
update PRCP_2016 set county_name = 'Kern' where area_code = 4029;
update PRCP_2016 set county_name = 'Los Angeles' where area_code = 4037;
update PRCP_2016 set county_name = 'Orange' where area_code = 4059;
update PRCP_2016 set county_name = 'Riverside' where area_code = 4065;
update PRCP_2016 set county_name = 'San Bernardino' where area_code = 4071;
update PRCP_2016 set county_name = 'San Diego' where area_code = 4073;
update PRCP_2016 set county_name = 'San Luis Obispo' where area_code = 4079;
update PRCP_2016 set county_name = 'Santa Barbara' where area_code = 4083;
update PRCP_2016 set county_name = 'Ventura' where area_code = 4111;

update weather set county_name = 'Imperial' where area_code = 4025;
update weather set county_name = 'Kern' where area_code = 4029;
update weather set county_name = 'Los Angeles' where area_code = 4037;
update weather set county_name = 'Orange' where area_code = 4059;
update weather set county_name = 'Riverside' where area_code = 4065;
update weather set county_name = 'San Bernardino' where area_code = 4071;
update weather set county_name = 'San Diego' where area_code = 4073;
update weather set county_name = 'San Luis Obispo' where area_code = 4079;
update weather set county_name = 'Santa Barbara' where area_code = 4083;
update weather set county_name = 'Ventura' where area_code = 4111;

commit;

SELECT * FROM weather;

select t1.*, t2.avg_tmax, p.avg_prcp
from tmin_2016 t1
left outer join tmax_2016 t2 on (t1.area_code = t2.area_code and t1.year=t2.year and t1.month=t2.month)
left outer join prcp_2016 p on (t1.area_code = p.area_code and t1.year=p.year and t1.month=p.month);

-----------------------------------------------------------------------------------------------------------
drop table prcp_2019;
drop table tmax_2016;
drop table tmax_2017;
drop table tmax_2019;
drop table tmin_2016;
drop table tmin_2017;
drop table tmin_2019;
