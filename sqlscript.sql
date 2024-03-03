REM   Script: Final Project
REM   Final Project current

create table Customer( 
    CustomerID char(7) Primary Key, 
    Name char(15), 
    Email char(15), 
    Phone char(15) 
);

create table Salesperson( 
    SalespersonID char(7) Primary Key, 
    Name char(15), 
    Email char(15), 
    Phone char(15) 
);

create table Invoice( 
    InvoiceNumber char(7), 
    ProductID char(7), 
    Primary Key(InvoiceNumber, ProductID), 
    InvoiceDate char(10), 
    DueDate char(10), 
    CustomerID char(7), 
    SalespersonID char(7) 
);

create table InvoiceLineItem( 
    InvoiceLineItemID char(7) Primary Key, 
    InvoiceNumber char(7), 
    ProductID char(7), 
    Quantity INT, 
    UnitPrice DECIMAL(10,2), 
    LineTotal DECIMAL(10,2) 
);

CREATE TABLE Inventory ( 
    ProductID CHAR(7) PRIMARY KEY, 
    QuantityAvailable INT, 
    Prices DECIMAL(10, 2) 
);

create table PurchaseOrder( 
    PurchaseOrderID char(7) Primary Key, 
    VendorID char(7), 
    OrderDate char(10), 
    DeliveryDate char(10) 
);

create table PurchaseOrderLineItem( 
    PurchaseOrderLineItemID char(7) Primary Key, 
    PurchaseOrderID char(7), 
    ProductID char(7), 
    Quantity INT, 
    UnitPrice DECIMAL (10,2), 
    TotalPrice DECIMAL(10,2) 
);

create table Vendor( 
    VendorID char(7) Primary Key, 
    ContactName char(15), 
    Email char(15), 
    Phone char(15) 
);

CREATE TABLE BusinessMetrics ( 
    MetricID char(7) PRIMARY KEY, 
    TotalSalesYTD DECIMAL(10, 2), 
    TotalPurchasesYTD DECIMAL(10, 2) 
);

ALTER TABLE Invoice 
ADD CONSTRAINT FK_Invoice_Customer 
FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID);

ALTER TABLE Invoice 
ADD CONSTRAINT FK_Invoice_Salesperson 
FOREIGN KEY (SalespersonID) REFERENCES Salesperson(SalespersonID);

ALTER TABLE Invoice 
ADD CONSTRAINT FK_Inventory_Invoice 
FOREIGN KEY (ProductID) REFERENCES Inventory(ProductID);

ALTER TABLE InvoiceLineItem 
ADD CONSTRAINT FK_InvoiceLineItem_Invoice 
FOREIGN KEY (InvoiceNumber, ProductID) 
REFERENCES Invoice (InvoiceNumber, ProductID);

ALTER TABLE PurchaseOrder 
ADD CONSTRAINT FK_PurchaseOrder_Vendor 
FOREIGN KEY (VendorID) REFERENCES Vendor(VendorID);

ALTER TABLE PurchaseOrderLineItem 
ADD CONSTRAINT FK_PurchaseOrderLineItem_PurchaseOrder 
FOREIGN KEY (PurchaseOrderID) REFERENCES PurchaseOrder(PurchaseOrderID);

ALTER TABLE PurchaseOrderLineItem 
ADD CONSTRAINT FK_PurchaseOrderLineItem_ProductID 
FOREIGN KEY (ProductID) REFERENCES Inventory(ProductID);

CREATE OR REPLACE TRIGGER sale_trigger 
AFTER INSERT ON InvoiceLineItem 
FOR EACH ROW 
BEGIN 
    UPDATE Inventory 
    SET QuantityAvailable = QuantityAvailable - :NEW.Quantity 
    WHERE ProductID = :NEW.ProductID; 
END; 
/

CREATE OR REPLACE TRIGGER purchase_trigger 
AFTER INSERT ON PurchaseOrderLineItem 
FOR EACH ROW 
BEGIN 
    UPDATE Inventory 
    SET QuantityAvailable = QuantityAvailable + :NEW.Quantity 
    WHERE ProductID = :NEW.ProductID; 
END; 
/

ALTER TABLE BusinessMetrics 
DROP COLUMN MetricID;

ALTER TABLE BusinessMetrics 
ADD CONSTRAINT ADD_Purchases_Sales PRIMARY KEY (TotalPurchasesYTD, TotalSalesYTD);

ALTER TABLE InvoiceLineItem  
ADD TotalSalesYTD DECIMAL(10, 2);

ALTER TABLE InvoiceLineItem 
ADD SalesYTD DECIMAL(10, 2);

ALTER TABLE InvoiceLineItem  
ADD TotalPurchasesYTD DECIMAL(10, 2);

ALTER TABLE InvoiceLineItem 
ADD CONSTRAINT FK_InvoiceLineItem_BusinessMetrics 
FOREIGN KEY (TotalSalesYTD, TotalPurchasesYTD) 
REFERENCES BusinessMetrics(TotalSalesYTD, TotalPurchasesYTD);

describe InvoiceLineItem


describe BusinessMetrics


describe BusinessMetrics


describe InvoiceLineItem


ALTER TABLE InvoiceLineItem 
DROP COLUMN SalesYTD;

CREATE OR REPLACE TRIGGER sales_ytd_trigger 
AFTER INSERT ON InvoiceLineItem 
FOR EACH ROW 
BEGIN 
    UPDATE BusinessMetrics 
    SET TotalSalesYTD = TotalSalesYTD + ( 
        SELECT SUM(Quantity * UnitPrice) 
        FROM InvoiceLineItem 
        WHERE InvoiceNumber = :NEW.InvoiceNumber 
    ) 
    WHERE TotalSalesYTD = :NEW.TotalSalesYTD; 
END; 
/

CREATE OR REPLACE TRIGGER purchases_ytd_trigger 
AFTER INSERT ON InvoiceLineItem 
FOR EACH ROW 
BEGIN 
    UPDATE BusinessMetrics  
    SET TotalPurchasesYTD = TotalPurchasesYTD + ( 
        SELECT SUM(Quantity * UnitPrice) 
        FROM InvoiceLineItem 
        WHERE InvoiceNumber = :NEW.InvoiceNumber 
    ); 
END; 
/

describe Customer 


insert into Customer values('0012345', 'Jack Daniels','JD@ACME.com','123-456-7890')  
  
  
;

describe Customer 


select * from Customer 
 
 
;

select * from Customer 
 
 
;

select * from Customer;

insert into Customer values('0023456','John Deere', 'JDR@ACME.com','234-567-8901');

insert into Customer values('0034567','Will Roberts', 'WR@gmail.com','345-678-9012');

insert into Customer values('0045678','Mike Holt', 'MH@gmail.com','456-789-0123');

insert into Customer values('0056789','Jim Beam', 'JB@gmail.com','567-890-1234');

select * from Customer 
 
 
 
;

select * from Customer  
  
  
  
;

select * from Customer  
  
  
  
;

DELETE FROM Customer 
WHERE Name = 'JackDaniels' AND Email = 'JD@ACME.com';

select * from Customer 
  
  
;

select * from Customer 
 
  
  
;

UPDATE Customer 
SET Email = 'WR@gmail.com' 
WHERE Name = 'Will Roberts';

UPDATE Customer 
SET Email = 'MH@gmail.com' 
WHERE Name = 'Mike Holt';

UPDATE Customer 
SET Email = 'JB@gmail.com' 
WHERE Name = 'Jim Beam';

UPDATE Customer 
SET Email = 'JDR@gmail.com' 
WHERE Name = 'John Deere';

select * from Customer;

select * from Salesperson;

select * from Salesperson;

describe Vendor


insert into Vendor values('7654321','Hellen Keller','HK@dbn.org','534-342-6746');

insert into Vendor values('8765432','Mike Ross','MR@ACS.org','748-294-2934');

insert into Vendor values('9876543','Harry Potter','HP@stock.com','102-193-2848');

insert into Vendor values('0987654','Susan Wells','SW@yahoo.com','543-980-2032');

insert into Vendor values('1098765','Harvey Gills','HG@gmail.com','002-203-2011');

select * from Vendor;

describe invoice


describe Invoice


select * from Customer;

describe Inventory


describe Invoice


select * from Customer;

describe Invoice


select * from Customer;

select * from Salesperson;

describe Inventory


insert into Inventory values('17310', 226, 59.99);

select * from Inventory;

insert into Inventory values('17410', 134, 59.99);

insert into Inventory values('17510', 40, 299.99);

insert into Inventory values('17610', 300, 19.99);

insert into Inventory values('17710', 267, 29.99);

select * from Inventory;

select * from Inventory;

select * from Invoice;

describe Invoice


select * from Customer;

select * from Salesperson;

describe Invoice


select * from Customer;

select * from Salesperson;

select * from Inventory;

select * from InvoiceLineItem;

describe InvoiceLineItem


select * from invoice;

select * from Invoice;

select * from Invoice;

describe Invoice


describe Invoice


select * from Inventory;

select * from Customer;

select * from Salesperson;

select * from Invoice;

select * from Invoice;

select * from Customer;

select * from Salesperson;

select * from Inventory;

select * from Invoice;

select * from Inventory;

select * from Vendor;

DROP TRIGGER purchases_ytd_trigger;

ALTER TABLE PurchaseOrderLineItem 
ADD TotalSalesYTD DECIMAL(10,2);

ALTER TABLE PurchaseOrderLineItem 
ADD TotalPurchasesYTD DECIMAL(10,2);

CREATE OR REPLACE TRIGGER purchases_ytd_trigger 
AFTER INSERT ON PurchaseOrderLineItem 
FOR EACH ROW 
BEGIN 
    UPDATE BusinessMetrics  
    SET TotalPurchasesYTD = TotalPurchasesYTD + ( 
        SELECT SUM(Quantity * UnitPrice) 
        FROM PurchaseOrderLineItem 
        WHERE PurchaseOrderLineItemID = :NEW.PurchaseOrderLineItemID 
    ); 
END; 
/

describe PurchaseOrder


describe PurchaseOrder


select * from Vendor;

insert into PurchaseOrder values('11234', '7654321','07/01/2023','08/01/2023');

insert into PurchaseOrder values('11235', '8765432','07/03/2023','08/03/2023');

insert into PurchaseOrder values('11236', '9876543','07/21/2023','08/21/2023');

insert into PurchaseOrder values('11237', '0987654','07/22/2023','08/22/2023');

insert into PurchaseOrder values('11238', '1098765','07/29/2023','08/29/2023');

describe PurchaseOrderLineItem


select * from PurchaseOrder;

describe BusinessMetrics


insert into BusinessMetrics values(126311.92, 77426.31);

select * from BusinessMetrics;

select * from BusinessMetrics;

describe PurchaseOrderLineItem


select * from PurchaseOrder;

describe PurchaseOrderLineItem


select * from PurchaseOrder;

select * from Inventory;

describe PurchaseOrderLineItem


select * from Inventory;

select * from PurchaseOrder;

select * from InvoiceLineItem 
;

describe InvoiceLineItem 


select * from InvoiceLineItem 
;

describe InvoiceLineItem 


describe InvoiceLineItem


select * from Invoice;

select * from Inventory;

ALTER TABLE Inventory 
DROP COLUMN Prices;

select * from Inventory;

describe InvoiceLineItem


select * from Inventory;

describe InvoiceLineItem


select * from Inventory;

select * from Invoice;

describe InvoiceLineItem


select * from Inventory;

select * from Invoice;

describe InvoiceLineItem


CREATE OR REPLACE TRIGGER sales_ytd_trigger 
AFTER INSERT ON InvoiceLineItem 
FOR EACH ROW 
BEGIN 
    UPDATE BusinessMetrics 
    SET TotalSalesYTD = TotalSalesYTD + (:NEW.Quantity * :NEW.UnitPrice); 
END; 
/

CREATE OR REPLACE TRIGGER purchases_ytd_trigger 
AFTER INSERT ON PurchaseOrderLineItem 
FOR EACH ROW 
BEGIN 
    UPDATE BusinessMetrics 
    SET TotalPurchasesYTD = TotalPurchasesYTD + (:NEW.Quantity * :NEW.UnitPrice); 
END; 
/

describe InvoiceLineItem


select * from Inventory;

select * from Invoice;

describe InvoiceLineItem


select * from Inventory;

select * from Invoice;

select * from Invoice;

describe Invoice 


describe Invoice


select * from Inventory;

select * from Customer;

select * from Salesperson;

describe Invoice


select * from Customer;

select * from Salesperson;

select * from Inventory;

select * from Customer;

select * from Salesperson;

select * from Inventory;

describe Salesperson


select * from Salesperson;

describe Salesperson


insert into Salesperson values('09100', 'Jim Peters','JP@ACME.com','222-333-4444');

insert into Salesperson values('09101', 'Angel Jolly','AJ@ACME.com','333-444-5555');

insert into Salesperson values('09102', 'Aaron Romero','AR@ACME.com','444-555-6666');

insert into Salesperson values('09103', 'Louis Vuitton','LV@ACME.com','555-666-7777');

insert into Salesperson values('09104', 'Shannon Sharpe','SS@ACME.com','666-777-8888');

select * from Salesperson;

describe Invoice


select * from Salesperson;

select * from Customer;

select * from Inventory;

insert into Invoice values('55650','17310','01/01/2023','02/01/2023','0012345','09100');

insert into Invoice values('55660','17410','01/04/2023','02/04/2023','0012345','09100');

insert into Invoice values('55670','17510','01/08/2023','02/08/2023','0012345','09100');

insert into Invoice values('55680','17610','01/12/2023','02/12/2023','0012345','09100');

insert into Invoice values('55690','17710','01/20/2023','02/20/2023','0012345','09100');

select * from Invoice;

select * from InvoiceLineItem;

select * from PurchaseOrder;

select * from PurchaseOrderLineItem;

describe InvoiceLineItem


describe InvoiceLineItem


select * from Inventory;

select * from Invoice;

ALTER TABLE InvoiceLineItem 
DROP CONSTRAINT FK_InvoiceLineItem_BusinessMetrics;

describe InvoiceLineItem


ALTER TABLE InvoiceLineItem 
DROP COLUMN TotalSalesYTD;

ALTER TABLE InvoiceLineItem 
DROP COLUMN TotalPurchasesYTD;

describe InvoiceLineItem 


ALTER TABLE PurchaseOrderLineItem 
DROP COLUMN TotalSalesYTD;

ALTER TABLE PurchaseOrderLineItem 
DROP COLUMN TotalPurchasesYTD;

describe PurchaseOrderLineItem 


DROP TABLE BusinessMetrics 
;

CREATE TABLE BusinessMetrics ( 
    BusinessMetricsID NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY, 
    TotalSalesYTD DECIMAL(10, 2) DEFAULT 0, 
    TotalPurchasesYTD DECIMAL(10, 2) DEFAULT 0 
);

SELECT CONSTRAINT_NAME 
FROM USER_CONSTRAINTS 
WHERE TABLE_NAME = 'InvoiceLineItem' AND CONSTRAINT_TYPE = 'R';

describe InvoiceLineItem


ALTER TABLE InvoiceLineItem 
ADD BusinessMetricsID char(7);

DROP TABLE BusinessMetrics;

CREATE TABLE BusinessMetrics (  
    MetricsID CHAR(7) PRIMARY KEY,  
    TotalSalesYTD DECIMAL(10, 2) DEFAULT 0,  
    TotalPurchasesYTD DECIMAL(10, 2) DEFAULT 0  
);

ALTER TABLE InvoiceLineItem 
DROP COLUMN BusinessMetricsID;

describe InvoiceLineItem


ALTER TABLE InvoiceLineItem  
ADD MetricsID CHAR(7);

describe InvoiceLineItem 


ALTER TABLE InvoiceLineItem 
ADD CONSTRAINT FK_InvoiceLineItem_BusinessMetrics  
FOREIGN KEY (MetricsID) REFERENCES BusinessMetrics(MetricsID) 
;

ALTER TABLE PurchaseOrderLineItem 
ADD MetricsID char(7);

ALTER TABLE PurchaseOrderLineItem 
ADD CONSTRAINT FK_PurchaseOrderLineItem_BusinessMetrics 
FOREIGN KEY (MetricsID) REFERENCES BusinessMetrics(MetricsID);

CREATE OR REPLACE TRIGGER sales_ytd_trigger 
AFTER INSERT ON InvoiceLineItem 
FOR EACH ROW 
BEGIN 
    UPDATE BusinessMetrics 
    SET TotalSalesYTD = TotalSalesYTD + (:NEW.Quantity * :NEW.UnitPrice) 
    WHERE MetricsID = :NEW.MetricsID; 
END; 
/

CREATE OR REPLACE TRIGGER purchases_ytd_trigger 
AFTER INSERT ON PurchaseOrderLineItem 
FOR EACH ROW 
BEGIN 
    UPDATE BusinessMetrics 
    SET TotalPurchasesYTD = TotalPurchasesYTD + (:NEW.Quantity * :NEW.UnitPrice) 
    WHERE MetricsID = :NEW.MetricsID; 
END; 
/

describe InvoiceLineItem


describe InvoiceLineItem


select * from Inventory;

select * from Invoice;

INSERT INTO BusinessMetrics (MetricsID, TotalSalesYTD, TotalPurchasesYTD) 
VALUES (1, 143912.64, 88214.18);

select * from BusinessMetrics 
;

describe InvoiceLineItem


select * from Invoice;

select * from Inventory;

select * from BusinessMetrics;

insert into InvoiceLineItem values('23900','55650','17310',26, 59.99, 1559.74,'1');

describe InvoiceLineItem


select * from Invoice;

select * from BusinessMetrics;

select * from Inventory;

insert into InvoiceLineItem values('23910','55660','17410',26, 59.99, 1559.74,'1');

insert into InvoiceLineItem values('23920','55670','17510',34, 69.99, 2379.66,'1');

insert into InvoiceLineItem values('23930','55680','17610',5, 59.99, 299.95,'1');

insert into InvoiceLineItem values('23940','55690','17710',37, 29.99, 1109.63,'1');

select * from InvoiceLineItem;

select * from BusinessMetrics;

select * from Inventory;

describe PurchaseOrderLineItem


describe PurchaseOrderLineItem


select * from Inventory;

select * from PurchaseOrder;

insert into PurchaseOrderLineItem values('330201','11234','17310',30,15.99,479.70,'1');

insert into PurchaseOrderLineItem values('330202','11235','17410',42,15.99,671.58,'1');

insert into PurchaseOrderLineItem values('330203','11236','17510',34,19.99,679.66,'1');

insert into PurchaseOrderLineItem values('330204','11237','17610',10,24.99,249.90,'1');

insert into PurchaseOrderLineItem values('330205','11238','17710',35,9.99,349.65,'1');

select * from PurchaseOrderLineItem;

select * from Inventory;

select * from BusinessMetrics;

