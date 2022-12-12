set serveroutput on 
declare
 cursor c is
select distinct to_char(incident_dateonly_created, 'MMYYYY') as Obs_Date,
        incident_county, 
        count(ID) as wf_freq 
from dw_oltp.wildfire w
group by to_char(incident_dateonly_created, 'MMYYYY'), incident_county;

    c1 c%rowtype;
    cnt number := 0;
begin
for c1 in c
 loop
    update dw_olap.wildfire_fact
    set wildfire_frequency = c1.wf_freq
    where county_key in 
    (
        select COUNTY_KEY from dw_olap.counties_dim 
        where COUNTY_NAME = c1.incident_county
    )
    and  to_char(incident_creation_date, 'MMYYYY') = c1.Obs_Date
    and incident_type = 'WF';
    
    cnt := cnt + sql%rowcount;   
 end loop;
 dbms_output.put_line('wildfire_frequency updated'|| cnt);
end;
/

