-- The data has been loaded into these tables using 'import data' feature of sql developer using the data provided by professor into .csv files.

CREATE TABLE users 
(     	userID 		NUMBER 
		CONSTRAINT pk_users PRIMARY KEY, -- uses user_id sequence number
       	email 		VARCHAR2(50),
        	lname 		VARCHAR2(20),
       	fname 		VARCHAR2(25),
       	street 		VARCHAR2(50),
        	city  		VARCHAR2(25),
       	state 		VARCHAR2(2),
        	zip 		VARCHAR2(10),
     	status 		CHAR(1)		-- 'G' or 'B'
);

CREATE TABLE sellers 
(	userID		NUMBER CONSTRAINT fk_sellers  
                        	REFERENCES users(userID) ON DELETE CASCADE,
	creditCardType 	VARCHAR2(10),
	creditCardNumber VARCHAR2(16),
	expiration 	VARCHAR2(6),
	bank 		VARCHAR2(20),
	accountNo 	VARCHAR2(25),
		CONSTRAINT pk_sellers PRIMARY KEY (userID) 
);

create table buyers 
(   	userID 		NUMBER CONSTRAINT fk_buyers  
	                       REFERENCES users(userID) ON DELETE CASCADE,
	maxBidAmount 	NUMBER, 
		CONSTRAINT pk_buyers PRIMARY KEY (userID)
);

CREATE TABLE items 
(	itemID 		NUMBER
		CONSTRAINT pk_items PRIMARY KEY, -- uses item_id sequence number
        name 		VARCHAR2(50),
        description 	VARCHAR2(64),
        openingPrice 	NUMBER(9,2),
        increase 	NUMBER(9,2),
        startingTime 	DATE,
        endingTime 	DATE,
        featured 	CHAR(1),	-- 'Y' or 'N'
        userID 		NUMBER CONSTRAINT fk_items
				REFERENCES sellers(userID) ON DELETE CASCADE 
);


CREATE TABLE categories 
(	cID 		NUMBER 
		CONSTRAINT pk_categories PRIMARY KEY, -- uses category_id number
	name    	VARCHAR2(20),
	description 	VARCHAR2(128)
);

CREATE TABLE itemCategory 
(	
	cID 		NUMBER CONSTRAINT fk_itemcategory_cID 
				REFERENCES categories(cID) ON DELETE CASCADE,
	itemID 		NUMBER CONSTRAINT fk_itemcategory_itemID 
				REFERENCES items(itemID) ON DELETE CASCADE, 
          	CONSTRAINT pk_itemcategory PRIMARY KEY (cID, itemID)
);

CREATE TABLE promotions 
(	
	itemID 		NUMBER 
	   CONSTRAINT fk_promotions REFERENCES items(itemID) ON DELETE CASCADE,
	startingTime 	DATE,
	endingTime 	DATE,
	salePrice	NUMBER(9,2),
		CONSTRAINT pk_promotions PRIMARY KEY (itemID,startingTime)
);

CREATE TABLE bids 
(	
	userID 		NUMBER CONSTRAINT  fk_bids_userID 
		      		REFERENCES buyers(userID) ON DELETE CASCADE,
	itemID 		NUMBER CONSTRAINT fk_bids_itemID 
                            	REFERENCES items(itemID) ON DELETE CASCADE,
       	price 		NUMBER(9,2),
	timestamp 	DATE,
		CONSTRAINT pk_bids PRIMARY KEY (userID, itemID, price)
); 

CREATE TABLE retractions 
( 	
	retractionTimestamp  DATE,
	userID 		NUMBER CONSTRAINT fk_retractions_userID 
				REFERENCES users(userID) ON DELETE CASCADE,
  	itemID 		NUMBER CONSTRAINT fk_retractions_itemID 
				REFERENCES items(itemID) ON DELETE CASCADE,
	reason 		VARCHAR2(128),
		CONSTRAINT pk_retractions PRIMARY KEY (retractionTimestamp, userId, itemID)
);

CREATE TABLE sales 
( 	
	itemID 		NUMBER CONSTRAINT fk_sales_itemID 
				REFERENCES items(itemID) ON DELETE CASCADE,
	sellerUserID 	NUMBER CONSTRAINT fk_sales_sellerUserID
				REFERENCES sellers(userID) ON DELETE CASCADE,
   	buyerUserID 	NUMBER CONSTRAINT fk_sales_buyerUserID
				REFERENCES buyers(userID) ON DELETE CASCADE,
   	price 		NUMBER(9,2),
  	settlementdate 	DATE,
	  	CONSTRAINT pk_sales PRIMARY KEY (itemID)
        );