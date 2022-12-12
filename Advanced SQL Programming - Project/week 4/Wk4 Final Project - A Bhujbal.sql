---	What indexes should you create to improve the performance of the queries you wrote for deliverable #2? Why?
--To improve performance of queries I wrote in deliverable #2, I created following indexes -

--indexes on SALES_FACT table :
select distinct selleruserid from sales_fact;
select distinct buyersuserid from sales_fact;
select distinct itemid from sales_fact;

create index salesfact_seller_i
on sales_fact(SELLERUSERID);

create index salesfact_buyer_i
on sales_fact(BUYERSUSERID);

create index salesfact_item_i
on sales_fact(ITEMID);

-- indexes on sellers_dim
select count(*) from sellers_dim;
select distinct state from sellers_dim;
select distinct fname from sellers_dim;
select distinct lname from sellers_dim;

--bitmap index on column state as it has low selectivity or very few distinct values.
create bitmap index sellers_state_i
on sellers_dim(state);

--composite index on fname and lname as they are used together in where or group by clause. 
create index sellers_fname_lname_i
on sellers_dim(fname, lname);


-- indexes on buyers_dim
select count(*) from buyers_dim;
select distinct state from buyers_dim;
select distinct fname from buyers_dim;
select distinct lname from buyers_dim;

--bitmap index on column state as it has low selectivity or very few distinct values.
create bitmap index buyers_state_i
on buyers_dim(state);

--composite index on fname and lname as they are used together in where or group by clause. 
create index buyers_fname_lname_i
on buyers_dim(fname, lname);


--indexes on items_dim
--as only itemid is used in where or group clause of queries in deliverable #2,
--and column itemid already has an index created on it as it is a primary key of column.
-- Hence, I did not have to create any new index on this table.


--•	Can you rewrite the queries you wrote for deliverable #3 to improve their performance? Why or why not?
--Queries from Deliverable 2
--1.	Find the seller user id and buy user id such that the buyer has bought at least one item from the seller but the buyer and seller are located in different states.
--using join
select distinct a.selleruserid, b.state seller_state, a.buyersuserid, c.state buyer_state
from sales_Fact a, sellers_dim b, buyers_dim c
where a.selleruserid = b.userid
and a.buyersuserid = c.userid
and b.state != c.state;

--Alternate way with join
select distinct sf.buyersuserid, b.state buyer_location,
sf.selleruserid, s.state seller_location
from sales_fact sf 
join sellers_dim s on (sf.selleruserid = s.userid)
join buyers_dim b on (sf.buyersuserid = b.userid)
where b.state != s.state;

--using correlated subquery 
select distinct selleruserid, buyersuserid
from sales_fact a
where not exists 
(select 'X'
from sellers_dim s, buyers_dim b 
where b.state = s.state
and s.userid = a.selleruserid 
and b.userid = a.buyersuserid);
------------------------------------------------------------------------------

--new query written as part of deliverable #3
--using non-correlated subquery -
select distinct selleruserid, buyersuserid
from sales_fact
where (selleruserid, buyersuserid) in 
(select s.userid, b.userid
from sellers_dim s, buyers_dim b 
where b.state != s.state);
--=====================================================================================================================

--2.	Find item name along with the seller id and buyer id such that the seller has sold the item to the buyer.
--using join
select distinct name ietm_name, selleruserid as "sold by", buyersuserid as "bought by"
from sales_fact 
left join items_dim using (itemid);

--or
select distinct name item_name, buyersuserid, selleruserid
from sales_fact sf, items_dim i 
where sf.itemid = i.itemid(+);
------------------------------------------------------------------------------
--new query written as part of deliverable #3
--using non-correlated subquery:
select (select name from items_dim where itemid = sf.itemid) as "item name", 
selleruserid, buyersuserid
from sales_fact sf;
--=====================================================================================================================

--3.	For each seller and each item sold by the seller, find the total amount sold.
select sf.selleruserid, sf.itemid, i.name "item_name", sum(sf.price) "total_amount_sold"
from sales_fact sf join items_dim i on (sf.itemid = i.itemid)
group by (sf.selleruserid, sf.itemid, i.name)
;
------------------------------------------------------------------------------
--new querywithout join.
select selleruserid, itemid, sum(price)
from sales_fact
group by selleruserid, itemid;
--=====================================================================================================================

--4.	Find the top seller.
select * from 
(select sf.selleruserid, s.fname, s.lname, sum(sf.price) "total_amount_sold"
from sales_fact sf left join sellers_dim s on (sf.selleruserid = s.userid)
group by sf.selleruserid, s.fname, s.lname
order by sum(price) desc)
where rownum = 1;
-------------------------------------------------------------------------------------
--new query using max() function and having clause:
select sf.selleruserid, s.fname, s.lname, sum(sf.price) "total_amount_sold"
from sales_fact sf left join sellers_dim s on (sf.selleruserid = s.userid)
group by sf.selleruserid, s.fname, s.lname
having sum(sf.price) = (select max(sum(price)) from sales_fact group by selleruserid)
;
--=====================================================================================================================

--5.	Find the top buyer.
select * from 
(select sf.buyersuserid, b.fname, b.lname, sum(sf.price) "total_amount_bought"
from sales_fact sf left outer join buyers_dim b on (sf.buyersuserid = b.userid)
group by sf.buyersuserid,b.fname, b.lname 
order by sum(price) desc)
where rownum = 1;
------------------------------------------------------------------------------------------
select sf.buyersuserid, b.fname, b.lname, sum(sf.price) "total_amount_bought"
from sales_fact sf left join buyers_dim b on (sf.buyersuserid = b.userid)
group by sf.buyersuserid, b.fname, b.lname
having sum(sf.price) = (select max(sum(price)) from sales_fact group by buyersuserid)
;
--=====================================================================================================================








