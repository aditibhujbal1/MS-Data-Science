select u.userid as userid, email, lname, fname, street, city, state, zip from auction_oltp.buyers b, auction_oltp.users u where b.userid = u.userid;

insert into AUCTION_DW.buyers_dim (u.userid as userid, email, lname, fname, street, city, state, zip)
select u.userid as userid, email, lname, fname, street, city, state, zip from auction_oltp.buyers b, auction_oltp.users u where b.userid = u.userid;

select settlementdate, to_char(settlementdate, "YYYY" ) from sales;

++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

SELECT	settlementdate, 
	to_char(settlementdate, 'YYYY') ,
	to_char(settlementdate, 'Month'), 
	to_char(settlementdate, 'Day') 
FROM auction_oltp.sales
/

https://docs.oracle.com/cd/B19306_01/server.102/b14200/sql_elements004.htm#i34924

