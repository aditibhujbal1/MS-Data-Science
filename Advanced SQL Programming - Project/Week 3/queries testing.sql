--Q1
select distinct selleruserid, buyersuserid
from sales_fact a
where --(selleruserid, buyersuserid)
not exists 
(select 'X'
from sellers_dim s, buyers_dim b 
where b.state = s.state
and s.userid = a.selleruserid 
and b.userid = a.buyersuserid)
minus
select distinct sf.selleruserid, sf.buyersuserid
from sales_fact sf 
join sellers_dim s on (sf.selleruserid = s.userid)
join buyers_dim b on (sf.buyersuserid = b.userid)
where b.state != s.state;


--Q2