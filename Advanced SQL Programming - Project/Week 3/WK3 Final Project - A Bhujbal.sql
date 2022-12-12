--1.	Find the seller user id and buy user id such that the buyer has bought at least one item from the seller but the buyer and seller are located in different states.

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

--2.	Find item name along with the seller id and buyer id such that the seller has sold the item to the buyer.

select distinct name ietm_name, selleruserid as "sold by", buyersuserid as "bought by"
from sales_fact 
left join items_dim using (itemid);

--or 

select distinct name item_name, buyersuserid, selleruserid
from sales_fact sf, items_dim i 
where sf.itemid = i.itemid(+);


--3.	For each seller and each item sold by the seller, find the total amount sold.

select sf.selleruserid, sf.itemid, i.name "item_name", sum(sf.price) "total_amount_sold"
from sales_fact sf join items_dim i on (sf.itemid = i.itemid)
group by (sf.selleruserid, sf.itemid, i.name)
;


--4.	Find the top seller.

select * from 
(select sf.selleruserid, s.fname, s.lname, sum(sf.price) "total_amount_sold"
from sales_fact sf left join sellers_dim s on (sf.selleruserid = s.userid)
group by sf.selleruserid,  s.fname, s.lname
order by sum(price) desc)
where rownum = 1;

--5.	Find the top buyer.


select * from 
(select sf.buyersuserid, b.fname, b.lname, sum(sf.price) "total_amount_bought"
from sales_fact sf left outer join buyers_dim b on (sf.buyersuserid = b.userid)
group by sf.buyersuserid,b.fname, b.lname 
order by sum(price) desc)
where rownum = 1;
