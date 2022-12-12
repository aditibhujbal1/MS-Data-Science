--load data to DATE_DIM
insert into dw_olap.date_dim (SETTLEMENTDATE, YEAR, MONTH, MONTH_NUM, DAY_NUM_IN_MONTH, DAY_OF_WEEK, QUARTER)
select distinct settlementdate, 
to_char(settlementdate, 'yyyy') as "YEAR", 
to_char(settlementdate, 'MON') as "MONTH",
to_char(settlementdate, 'MM') as "MONTH_NUM", 
to_char(settlementdate, 'DD') as "DAY_NUM_IN_MONTH",
to_char(settlementdate, 'DAY') as "DAY_OF_WEEK",
to_char(settlementdate, 'Q') as "QUARTER"
from dw_oltp.sales
order by 1;


--load data to BUYERS_DIM
insert into dw_olap.buyers_dim (USERID, EMAIL, LNAME, FNAME, STREET, CITY, STATE, ZIP)
select USERID, EMAIL, LNAME, FNAME, STREET, CITY, STATE, ZIP
from dw_oltp.users
inner join dw_oltp.buyers using (userid);

--load data to SELLERS_DIM
insert into dw_olap.sellers_dim (USERID, EMAIL, LNAME, FNAME, STREET, CITY, STATE, ZIP)
select USERID, EMAIL, LNAME, FNAME, STREET, CITY, STATE, ZIP
from dw_oltp.users
inner join dw_oltp.sellers using (userid);


--load data to ITEMS_DIM
insert into dw_olap.items_dim (ITEMID, NAME, DESCRIPTION, OPENINGPRICE, INCREASE, STARTINGTIME, ENDINGTIME)
select ITEMID, NAME, DESCRIPTION, OPENINGPRICE, INCREASE, STARTINGTIME, ENDINGTIME
from dw_oltp.items;

--load data to SALES_FACT
insert into sales_fact (ITEMID, SELLERUSERID, BUYERSUSERID, SETTLEMENTDATE, PRICE)
select ITEMID, SELLERUSERID, BUYERUSERID, SETTLEMENTDATE, PRICE
from dw_oltp.sales;

