use purchase;

DROP TABLE PurchasedItem;
DROP TABLE Purchase;
DROP TABLE Purchase1;

CREATE TABLE Purchase(
purchaseID int unsigned not null auto_increment,
custName VARCHAR (30) not null,
orderedDate DATE not null,
shipDate DATE,
PRIMARY KEY (purchaseID));

CREATE TABLE PurchasedItem(
purchaseID int unsigned not null,
itemNo int unsigned not null,
productName VARCHAR(30) not null,
orderedQty TINYINT unsigned not null,
quotedPrice DECIMAL(5, 2) not null,
PRIMARY KEY (purchaseID, itemNo),
FOREIGN KEY (purchaseID) REFERENCES Purchase(purchaseID));


SET AUTOCOMMIT = false;

INSERT INTO Purchase (purchaseID, custName, orderedDate)
VALUES ('111', 'Scorlib Lexrin', '2020-09-16');
INSERT INTO PurchasedItem (purchaseID, itemNo, productName, orderedQty,
quotedPrice)
VALUES ('111', 1, 'Lawn mower', 3, 105.30);
COMMIT;

INSERT into Purchase (custName, shipDate, orderedDate) VALUES ('Sarah
Smith', '2016-05-12', '2016-05-10');

INSERT INTO PurchasedItem (purchaseID, itemNo, productName, orderedqty,
quotedPrice) VALUES (LAST_INSERT_ID(), 1, 'Cricket bat', 2, 80.50);
SELECT LAST_INSERT_ID();
COMMIT;

INSERT INTO Purchase (custName, shipDate, orderedDate)
VALUES ('Max Wang', '2016-05-12', '2016-05-11');
COMMIT;

ALTER TABLE PurchasedItem
ADD CONSTRAINT fk_purchase
FOREIGN KEY(purchaseID) REFERENCES Purchase(purchaseID)
ON DELETE CASCADE;

DELETE FROM Purchase
WHERE purchaseID = 111;
COMMIT;

UPDATE Purchase 
SET orderedDate ='2016-05-15', shipDate = '2016-05-17'
WHERE  purchaseID = 113;
COMMIT;

CREATE TABLE Purchase1(
purchaseID int unsigned not null auto_increment,
custName VARCHAR (30) not null,
orderedDate DATE not null,
shipDate DATE,
PRIMARY KEY (purchaseID)); 

INSERT INTO Purchase1 (purchaseID, custName, orderedDate, shipDate)
SELECT purchaseID, custName, orderedDate, shipDate 
FROM Purchase WHERE purchaseID = 113;

SELECT * FROM Purchase;
SELECT * FROM Purchase1;
SELECT * FROM PurchasedItem;







