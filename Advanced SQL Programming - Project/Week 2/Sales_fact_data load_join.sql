select * from items_dim;
select * from buyers_dim;
select * from sellers_dim;
select * from date_dim;
select * from dw_oltp.sales;
select * from dw_oltp.bids;

select * from dw_olap.sales_fact;

--including bids table for price
select distinct i.itemid, s.userid as selleruserid, b.userid as buuyeruserid, bd.price, d.settlementdate
from dw_oltp.sales sa left join items_dim i on (i.itemid = sa.itemid)
left join sellers_dim s on (s.userid = sa.selleruserid)
left join buyers_dim b on (b.userid = sa.buyeruserid)
left join date_dim d on (d.settlementdate = sa.settlementdate)
left join dw_oltp.bids bd on (bd.userid = sa.buyeruserid and bd.itemid = sa.itemid);


--minus including bids table
select distinct i.itemid, s.userid as selleruserid, b.userid as buuyeruserid, bd.price, d.settlementdate
from dw_oltp.sales sa left join items_dim i on (i.itemid = sa.itemid)
left join sellers_dim s on (s.userid = sa.selleruserid)
left join buyers_dim b on (b.userid = sa.buyeruserid)
left join date_dim d on (d.settlementdate = sa.settlementdate)
left join dw_oltp.bids bd on (bd.userid = sa.buyeruserid and bd.itemid = sa.itemid)
minus
select * from dw_oltp.sales;


--without bids table and selecting price from sales
insert into sales_fact (ITEMID, SELLERUSERID, BUYERSUSERID, SETTLEMENTDATE, PRICE)
select distinct i.itemid, s.userid as selleruserid, b.userid as buuyeruserid, d.settlementdate, sa.price
from dw_oltp.sales sa left join items_dim i on (i.itemid = sa.itemid)
left join sellers_dim s on (s.userid = sa.selleruserid)
left join buyers_dim b on (b.userid = sa.buyeruserid)
left join date_dim d on (d.settlementdate = sa.settlementdate);


--minus without bids table
select distinct i.itemid, s.userid as selleruserid, b.userid as buuyeruserid, d.settlementdate,  sa.price
from dw_oltp.sales sa left join items_dim i on (i.itemid = sa.itemid)
left join sellers_dim s on (s.userid = sa.selleruserid)
left join buyers_dim b on (b.userid = sa.buyeruserid)
left join date_dim d on (d.settlementdate = sa.settlementdate)
minus
select ITEMID, SELLERUSERID, BUYERUSERID, SETTLEMENTDATE, PRICE from dw_oltp.sales;