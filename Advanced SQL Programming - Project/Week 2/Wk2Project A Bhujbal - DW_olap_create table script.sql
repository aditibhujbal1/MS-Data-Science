CREATE TABLE BUYERS_DIM 
(
userid number,
email varchar2(50),
lname varchar2(20),
fname varchar2(25),
street varchar2(50),
city varchar2(25),
state varchar2(2),
zip varchar2(10),
PRIMARY KEY (userid)
);

CREATE TABLE SELLERS_DIM 
(
userid number,
email varchar2(50),
lname varchar2(20),
fname varchar2(25),
street varchar2(50),
city varchar2(25),
state varchar2(2),
zip varchar2(10),
PRIMARY KEY (userid)
);

CREATE TABLE ITEMS_DIM 
(
itemid number,
name varchar2(50),
description varchar2(64),
openingprice number(9,2),
increase number(9,2),
startingtime date,
endingtime date,
PRIMARY KEY (itemid)
);

CREATE TABLE DATE_DIM
(
settlementdate date,
year number,
month varchar2(15),
month_num number,
day_num_in_month number,
day_of_week varchar2(10),
quarter number,
PRIMARY KEY (settlementdate)
);

CREATE TABLE SALES_FACT 
(
itemid number NOT NULL,
selleruserid number NOT NULL,
buyersuserid number NOT NULL,
settlementdate date NOT NULL,
price number NOT NULL,
CONSTRAINT itemid_fk FOREIGN KEY (itemid) REFERENCES items_dim (itemid),
CONSTRAINT selleruserid_fk FOREIGN KEY (selleruserid) REFERENCES sellers_dim (userid),
CONSTRAINT buyersuserid_fk FOREIGN KEY (buyersuserid) REFERENCES buyers_dim (userid),
CONSTRAINT settlementdate_fk FOREIGN KEY (settlementdate) REFERENCES date_dim (settlementdate)
);