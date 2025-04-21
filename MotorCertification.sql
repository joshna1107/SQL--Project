
-- TASK 1
CREATE DATABASE MotorsCertification;
USE MotorsCertification;


-- Creating orders table

CREATE TABLE orders (
    orderNumber INT PRIMARY KEY,
    orderDate DATE,
    requiredDate DATE,
    shippedDate DATE,
    status VARCHAR(50),
    comments TEXT,
    customerNumber INT,
    FOREIGN KEY (customerNumber) REFERENCES customers(customerNumber)
);

--    index for 'orders' table
CREATE UNIQUE INDEX idx_orders_orderNumber ON orders(orderNumber);
CREATE INDEX idx_orders_customerNumber ON orders(customerNumber);



-- Creating products table
CREATE TABLE products (
    productCode VARCHAR(50) PRIMARY KEY,
    productName VARCHAR(100),
    productLine VARCHAR(50),
    productScale VARCHAR(50),
    productVendor VARCHAR(50),
    productDescription TEXT,
    quantityInStock SMALLINT,
    buyPrice FLOAT,
    MSRP FLOAT,
    FOREIGN KEY (productLine) REFERENCES productlines(productLine)
);

--    index for 'products' table
CREATE UNIQUE INDEX idx_products_productCode ON products(productCode);
CREATE INDEX idx_products_productLine ON products(productLine);


-- Creating orderdetails table
CREATE TABLE orderdetails (
    orderNumber INT PRIMARY KEY,
    productCode VARCHAR(50),
    quantityOrdered INT,
    priceEach FLOAT,
    orderLineNumber SMALLINT,
    FOREIGN KEY (orderNumber) REFERENCES orders(orderNumber),
    FOREIGN KEY (productCode) REFERENCES products(productCode)
);

--      index for orderdetails table
CREATE UNIQUE INDEX idx_orderdetails_orderNumber ON orderdetails(orderNumber);
CREATE INDEX idx_orderdetails_productCode ON orderdetails(productCode);


-- Creating employees table
CREATE TABLE employees (
    employeeNumber INT PRIMARY KEY,
    lastName VARCHAR(50),
    firstName VARCHAR(50),
    extension VARCHAR(10),
    email VARCHAR(100),
    officeCode VARCHAR(10),
    reportsTo INT,
    jobTitle VARCHAR(50),
    FOREIGN KEY (reportsTo) REFERENCES employees(employeeNumber),
    FOREIGN KEY (officeCode) REFERENCES offices(officeCode)
);

--  index for employees table
CREATE UNIQUE INDEX idx_employees_employeeNumber ON employees(employeeNumber);
CREATE INDEX idx_employees_reportsTo ON employees(reportsTo);
CREATE INDEX idx_employees_officeCode ON employees(officeCode);


-- Creating customers table
CREATE TABLE customers (
    customerNumber INT PRIMARY KEY,
    customerName VARCHAR(50),
    contactLastName VARCHAR(50),
    contactFirstName VARCHAR(50),
    phone VARCHAR(50),
    addressLine1 VARCHAR(50),
    addressLine2 VARCHAR(50),
    city VARCHAR(50),
    state VARCHAR(50),
    postalCode VARCHAR(15),
    country VARCHAR(50),
    salesRepEmployeeNumber INT,
    creditLimit FLOAT,
    FOREIGN KEY (salesRepEmployeeNumber) REFERENCES employees(employeeNumber)
);

--  index for customers table
CREATE UNIQUE INDEX idx_customers_customerNumber ON customers(customerNumber);


-- Creating offices table
CREATE TABLE offices (
    officeCode VARCHAR(10) PRIMARY KEY,
    city VARCHAR(50),
    phone VARCHAR(50),
    addressLine1 VARCHAR(100),
    addressLine2 VARCHAR(100),
    state VARCHAR(50),
    country VARCHAR(50),
    postalCode VARCHAR(15),
    territory VARCHAR(50)
);
--   index for offices table
CREATE UNIQUE INDEX idx_offices_officeCode ON offices(officeCode);





-- Creating payments table
CREATE TABLE payments (
    customerNumber INT,
    checkNumber VARCHAR(50),
    paymentDate DATE,
    amount FLOAT,
    PRIMARY KEY (customerNumber, checkNumber),
    FOREIGN KEY (customerNumber) REFERENCES customers(customerNumber)
);

--     index for payments table
CREATE UNIQUE INDEX idx_payments_customerNumber_checkNumber ON payments(customerNumber, checkNumber);





-- Creating productlines table
CREATE TABLE productlines (
    productLine VARCHAR(50) PRIMARY KEY,
    textDescription VARCHAR(4000),
    htmlDescription TEXT NULL,
    image VARBINARY(MAX) NULL
);


EXEC sp_help productlines


-- TASK 2
-- Inserting values into the tables

insert into productlines values
('Classic Cars','Attention car enthusiasts: Make your wildest car ownership dreams come true. Whether you are looking for classic muscle cars, dream sports cars or movie-inspired miniatures, you will find great choices in this category. These replicas feature superb attention to detail and craftsmanship and offer features such as working steering system, opening forward compartment, opening rear trunk with removable spare wheel, 4-wheel independent spring suspension, and so on. The models range in size from 1:10 to 1:24 scale and include numerous limited edition and several out-of-production vehicles. All models include a certificate of authenticity from their manufacturers and come fully assembled and ready for display in the home or office.',NULL,NULL),

('Motorcycles','Our motorcycles are state of the art replicas of classic as well as contemporary motorcycle legends such as Harley Davidson, Ducati and Vespa. Models contain stunning details such as official logos, rotating wheels, working kickstand, front suspension, gear-shift lever, footbrake lever, and drive chain. Materials used include diecast and plastic. The models range in size from 1:10 to 1:50 scale and include numerous limited edition and several out-of-production vehicles. All models come fully assembled and ready for display in the home or office. Most include a certificate of authenticity.',NULL,NULL),

('Planes','Unique, diecast airplane and helicopter replicas suitable for collections, as well as home, office or classroom decorations. Models contain stunning details such as official logos and insignias, rotating jet engines and propellers, retractable wheels, and so on. Most come fully assembled and with a certificate of authenticity from their manufacturers.',NULL,NULL),

('Ships','The perfect holiday or anniversary gift for executives, clients, friends, and family. These handcrafted model ships are unique, stunning works of art that will be treasured for generations! They come fully assembled and ready for display in the home or office. We guarantee the highest quality, and best value.',NULL,NULL),

('Trains','Model trains are a rewarding hobby for enthusiasts of all ages. Whether you are looking for collectible wooden trains, electric streetcars or locomotives, you will find a number of great choices for any budget within this category. The interactive aspect of trains makes toy trains perfect for young children. The wooden train sets are ideal for children under the age of 5.',NULL,NULL),

('Trucks and Buses','The Truck and Bus models are realistic replicas of buses and specialized trucks produced from the early 1920s to present. The models range in size from 1:12 to 1:50 scale and include numerous limited edition and several out-of-production vehicles. Materials used include tin, diecast and plastic. All models include a certificate of authenticity from their manufacturers and are a perfect ornament for the home and office.',NULL,NULL),

('Vintage Cars','Our Vintage Car models realistically portray automobiles produced from the early 1900s through the 1940s. Materials used include Bakelite, diecast, plastic and wood. Most of the replicas are in the 1:18 and 1:24 scale sizes, which provide the optimum in detail and accuracy. Prices range from $30.00 up to $180.00 for some special limited edition replicas. All models include a certificate of authenticity from their manufacturers and come fully assembled and ready for display in the home or office.',NULL,NULL);

-- verifying results
SELECT * FROM productlines;


insert into offices values

('1','San Francisco','+1 650 219 4782','100 Market Street','Suite 300','CA','USA','94080','NA'),

('2','Boston','+1 215 837 0825','1550 Court Place','Suite 102','MA','USA','02107','NA'),

('3','NYC','+1 212 555 3000','523 East 53rd Street','apt. 5A','NY','USA','10022','NA'),

('4','Paris','+33 14 723 4404','43 Rue Jouffroy Dabbans',NULL,NULL,'France','75017','EMEA'),

('5','Tokyo','+81 33 224 5000','4-1 Kioicho',NULL,'Chiyoda-Ku','Japan','102-8578','Japan'),

('6','Sydney','+61 2 9264 2451','5-11 Wentworth Avenue','Floor #2',NULL,'Australia','NSW 2010','APAC'),

('7','London','+44 20 7877 2041','25 Old Broad Street','Level 7',NULL,'UK','EC2N 1HN','EMEA');

SELECT * FROM offices;


--Insert records in employees table
insert into employees values

	(1002,'Murphy','Diane','x5800','dmurphy@classicmodelcars.com','1',NULL,'President'),

	(1056,'Patterson','Mary','x4611','mpatterso@classicmodelcars.com','1',1002,'VP Sales'),

	(1076,'Firrelli','Jeff','x9273','jfirrelli@classicmodelcars.com','1',1002,'VP Marketing'),

	(1088,'Patterson','William','x4871','wpatterson@classicmodelcars.com','6',1056,'Sales Manager (APAC)'),

	(1102,'Bondur','Gerard','x5408','gbondur@classicmodelcars.com','4',1056,'Sale Manager (EMEA)'),

	(1143,'Bow','Anthony','x5428','abow@classicmodelcars.com','1',1056,'Sales Manager (NA)'),

	(1165,'Jennings','Leslie','x3291','ljennings@classicmodelcars.com','1',1143,'Sales Rep'),

	(1166,'Thompson','Leslie','x4065','lthompson@classicmodelcars.com','1',1143,'Sales Rep'),

	(1188,'Firrelli','Julie','x2173','jfirrelli@classicmodelcars.com','2',1143,'Sales Rep'),

	(1216,'Patterson','Steve','x4334','spatterson@classicmodelcars.com','2',1143,'Sales Rep'),

	(1286,'Tseng','Foon Yue','x2248','ftseng@classicmodelcars.com','3',1143,'Sales Rep'),

	(1323,'Vanauf','George','x4102','gvanauf@classicmodelcars.com','3',1143,'Sales Rep'),

	(1337,'Bondur','Loui','x6493','lbondur@classicmodelcars.com','4',1102,'Sales Rep'),

	(1370,'Hernandez','Gerard','x2028','ghernande@classicmodelcars.com','4',1102,'Sales Rep'),

	(1401,'Castillo','Pamela','x2759','pcastillo@classicmodelcars.com','4',1102,'Sales Rep'),

	(1501,'Bott','Larry','x2311','lbott@classicmodelcars.com','7',1102,'Sales Rep'),

	(1504,'Jones','Barry','x102','bjones@classicmodelcars.com','7',1102,'Sales Rep'),

	(1611,'Fixter','Andy','x101','afixter@classicmodelcars.com','6',1088,'Sales Rep'),

	(1612,'Marsh','Peter','x102','pmarsh@classicmodelcars.com','6',1088,'Sales Rep'),

	(1619,'King','Tom','x103','tking@classicmodelcars.com','6',1088,'Sales Rep');

-- verifying employees records
SELECT * FROM employees;


--Insert records in customers table
INSERT INTO customers VALUES
	(103,'Atelier graphique','Schmitt','Carine ','40.32.2555','54, rue Royale',NULL,'Nantes',NULL,'44000','France',1370,'21000.00'),

	(112,'Signal Gift Stores','King','Jean','7025551838','8489 Strong St.',NULL,'Las Vegas','NV','83030','USA',1166,'71800.00'),

	(114,'Australian Collectors, Co.','Ferguson','Peter','03 9520 4555','636 St Kilda Road','Level 3','Melbourne','Victoria','3004','Australia',1611,'117300.00'),

	(119,'La Rochelle Gifts','Labrune','Janine ','40.67.8555','67, rue des Cinquante Otages',NULL,'Nantes',NULL,'44000','France',1370,'118200.00'),

	(121,'Baane Mini Imports','Bergulfsen','Jonas ','07-98 9555','Erling Skakkes gate 78',NULL,'Stavern',NULL,'4110','Norway',1504,'81700.00'),

	(124,'Mini Gifts Distributors Ltd.','Nelson','Susan','4155551450','5677 Strong St.',NULL,'San Rafael','CA','97562','USA',1165,'210500.00'),

	(125,'Havel & Zbyszek Co','Piestrzeniewicz','Zbyszek ','(26) 642-7555','ul. Filtrowa 68',NULL,'Warszawa',NULL,'01-012','Poland',NULL,'0.00'),

	(128,'Blauer See Auto, Co.','Keitel','Roland','+49 69 66 90 2555','Lyonerstr. 34',NULL,'Frankfurt',NULL,'60528','Germany',1504,'59700.00'),

	(129,'Mini Wheels Co.','Murphy','Julie','6505555787','5557 North Pendale Street',NULL,'San Francisco','CA','94217','USA',1165,'64600.00'),

	(131,'Land of Toys Inc.','Lee','Kwai','2125557818','897 Long Airport Avenue',NULL,'NYC','NY','10022','USA',1323,'114900.00'),

	(141,'Euro+ Shopping Channel','Freyre','Diego ','(91) 555 94 44','C/ Moralzarzal, 86',NULL,'Madrid',NULL,'28034','Spain',1370,'227600.00'),

	(144,'Volvo Model Replicas, Co','Berglund','Christina ','0921-12 3555','Berguvsvägen  8',NULL,'Luleå',NULL,'S-958 22','Sweden',1504,'53100.00'),

	(145,'Danish Wholesale Imports','Petersen','Jytte ','31 12 3555','Vinbæltet 34',NULL,'Kobenhavn',NULL,'1734','Denmark',1401,'83400.00'),

	(146,'Saveley & Henriot, Co.','Saveley','Mary ','78.32.5555','2, rue du Commerce',NULL,'Lyon',NULL,'69004','France',1337,'123900.00'),

	(148,'Dragon Souveniers, Ltd.','Natividad','Eric','+65 221 7555','Bronz Sok.','Bronz Apt. 3/6 Tesvikiye','Singapore',NULL,'079903','Singapore',1612,'103800.00'),

	(151,'Muscle Machine Inc','Young','Jeff','2125557413','4092 Furth Circle','Suite 400','NYC','NY','10022','USA',1286,'138500.00'),

	(157,'Diecast Classics Inc.','Leong','Kelvin','2155551555','7586 Pompton St.',NULL,'Allentown','PA','70267','USA',1216,'100600.00'),

	(161,'Technics Stores Inc.','Hashimoto','Juri','6505556809','9408 Furth Circle',NULL,'Burlingame','CA','94217','USA',1165,'84600.00'),

	(166,'Handji Gifts& Co','Victorino','Wendy','+65 224 1555','106 Linden Road Sandown','2nd Floor','Singapore',NULL,'069045','Singapore',1612,'97900.00'),

	(167,'Herkku Gifts','Oeztan','Veysel','+47 2267 3215','Brehmen St. 121','PR 334 Sentrum','Bergen',NULL,'N 5804','Norway  ',1504,'96800.00');



-- customers verification
SELECT * FROM customers;



insert  into products values 

('S10_1678','1969 Harley Davidson Ultimate Chopper','Motorcycles','1:10','Min Lin Diecast','This replica features working kickstand, front suspension, gear-shift lever, footbrake lever, drive chain, wheels and steering. All parts are particularly delicate due to their precise scale and require special care and attention.',7933,'48.81','95.70'),

('S10_1949','1952 Alpine Renault 1300','Classic Cars','1:10','Classic Metal Creations','Turnable front wheels; steering function; detailed interior; detailed engine; opening hood; opening trunk; opening doors; and detailed chassis.',7305,'98.58','214.30'),

('S10_2016','1996 Moto Guzzi 1100i','Motorcycles','1:10','Highway 66 Mini Classics','Official Moto Guzzi logos and insignias, saddle bags located on side of motorcycle, detailed engine, working steering, working suspension, two leather seats, luggage rack, dual exhaust pipes, small saddle bag located on handle bars, two-tone paint with chrome accents, superior die-cast detail , rotating wheels , working kick stand, diecast metal with plastic parts and baked enamel finish.',6625,'68.99','118.94'),

('S10_4698','2003 Harley-Davidson Eagle Drag Bike','Motorcycles','1:10','Red Start Diecast','Model features, official Harley Davidson logos and insignias, detachable rear wheelie bar, heavy diecast metal with resin parts, authentic multi-color tampo-printed graphics, separate engine drive belts, free-turning front fork, rotating tires and rear racing slick, certificate of authenticity, detailed engine, display stand\r\n, precision diecast replica, baked enamel finish, 1:10 scale model, removable fender, seat and tank cover piece for displaying the superior detail of the v-twin engine',5582,'91.02','193.66'),

('S10_4757','1972 Alfa Romeo GTA','Classic Cars','1:10','Motor City Art Classics','Features include: Turnable front wheels; steering function; detailed interior; detailed engine; opening hood; opening trunk; opening doors; and detailed chassis.',3252,'85.68','136.00'),

('S10_4962','1962 LanciaA Delta 16V','Classic Cars','1:10','Second Gear Diecast','Features include: Turnable front wheels; steering function; detailed interior; detailed engine; opening hood; opening trunk; opening doors; and detailed chassis.',6791,'103.42','147.74'),

('S12_1099','1968 Ford Mustang','Classic Cars','1:12','Autoart Studio Design','Hood, doors and trunk all open to reveal highly detailed interior features. Steering wheel actually turns the front wheels. Color dark green.',68,'95.34','194.57'),

('S12_1108','2001 Ferrari Enzo','Classic Cars','1:12','Second Gear Diecast','Turnable front wheels; steering function; detailed interior; detailed engine; opening hood; opening trunk; opening doors; and detailed chassis.',3619,'95.59','207.80'),

('S12_1666','1958 Setra Bus','Trucks and Buses','1:12','Welly Diecast Productions','Model features 30 windows, skylights & glare resistant glass, working steering system, original logos',1579,'77.90','136.67'),

('S12_2823','2002 Suzuki XREO','Motorcycles','1:12','Unimax Art Galleries','Official logos and insignias, saddle bags located on side of motorcycle, detailed engine, working steering, working suspension, two leather seats, luggage rack, dual exhaust pipes, small saddle bag located on handle bars, two-tone paint with chrome accents, superior die-cast detail , rotating wheels , working kick stand, diecast metal with plastic parts and baked enamel finish.',9997,'66.27','150.62'),

('S12_3148','1969 Corvair Monza','Classic Cars','1:18','Welly Diecast Productions','1:18 scale die-cast about 10\" long doors open, hood opens, trunk opens and wheels roll',6906,'89.14','151.08'),

('S12_3380','1968 Dodge Charger','Classic Cars','1:12','Welly Diecast Productions','1:12 scale model of a 1968 Dodge Charger. Hood, doors and trunk all open to reveal highly detailed interior features. Steering wheel actually turns the front wheels. Color black',9123,'75.16','117.44'),

('S12_3891','1969 Ford Falcon','Classic Cars','1:12','Second Gear Diecast','Turnable front wheels; steering function; detailed interior; detailed engine; opening hood; opening trunk; opening doors; and detailed chassis.',1049,'83.05','173.02'),

('S12_3990','1970 Plymouth Hemi Cuda','Classic Cars','1:12','Studio M Art Models','Very detailed 1970 Plymouth Cuda model in 1:12 scale. The Cuda is generally accepted as one of the fastest original muscle cars from the 1970s. This model is a reproduction of one of the orginal 652 cars built in 1970. Red color.',5663,'31.92','79.80'),

('S12_4473','1957 Chevy Pickup','Trucks and Buses','1:12','Exoto Designs','1:12 scale die-cast about 20\" long Hood opens, Rubber wheels',6125,'55.70','118.50'),

('S12_4675','1969 Dodge Charger','Classic Cars','1:12','Welly Diecast Productions','Detailed model of the 1969 Dodge Charger. This model includes finely detailed interior and exterior features. Painted in red and white.',7323,'58.73','115.16'),

('S18_1097','1940 Ford Pickup Truck','Trucks and Buses','1:18','Studio M Art Models','This model features soft rubber tires, working steering, rubber mud guards, authentic Ford logos, detailed undercarriage, opening doors and hood,  removable split rear gate, full size spare mounted in bed, detailed interior with opening glove box',2613,'58.33','116.67'),

('S18_1129','1993 Mazda RX-7','Classic Cars','1:18','Highway 66 Mini Classics','This model features, opening hood, opening doors, detailed engine, rear spoiler, opening trunk, working steering, tinted windows, baked enamel finish. Color red.',3975,'83.51','141.54'),

('S18_1342','1937 Lincoln Berline','Vintage Cars','1:18','Motor City Art Classics','Features opening engine cover, doors, trunk, and fuel filler cap. Color black',8693,'60.62','102.74'),

('S18_1367','1936 Mercedes-Benz 500K Special Roadster','Vintage Cars','1:18','Studio M Art Models','This 1:18 scale replica is constructed of heavy die-cast metal and has all the features of the original: working doors and rumble seat, independent spring suspension, detailed interior, working steering system, and a bifold hood that reveals an engine so accurate that it even includes the wiring. All this is topped off with a baked enamel finish. Color white.',8635,'24.26','53.91');



-- products verification
SELECT * FROM products;

insert into orderdetails values

	(10100,'S18_1749',30,'136.00',3),


	(10101,'S18_2248',50,'55.09',2),

	(10102,'S18_4409',22,'75.46',4),

	(10103,'S24_3969',49,'35.29',1),

	(10104,'S18_2325',25,'108.06',4),

	(10105,'S18_2795',26,'167.06',1),

	(10106,'S24_1937',45,'32.53',3),

	(10107,'S24_2022',46,'44.35',2),

	(10108,'S18_1342',39,'95.55',2),

	(10109,'S18_1367',41,'43.13',1),

	(10110,'S10_1949',26,'214.30',11),

	(10111,'S10_4962',42,'119.67',4),

	(10112,'S12_1666',27,'121.64',8),

	(10113,'S18_1097',35,'94.50',10),

	(10114,'S18_2432',22,'58.34',2),

	(10115,'S18_2949',27,'92.19',12),

	(10116,'S18_2957',35,'61.84',14),

	(10117,'S18_3136',25,'86.92',13),

	(10118,'S18_3320',46,'86.31',16),

	(10119,'S18_4600',36,'98.07',5);


select * from orderdetails

insert into orders values
(10100,'2003-01-06','2003-01-13','2003-01-10','Shipped',NULL,363), -- 363 not in customers table

(10101,'2003-01-09','2003-01-18','2003-01-11','Shipped','Check on availability.',128),

(10102,'2003-01-10','2003-01-18','2003-01-14','Shipped',NULL,181),-- 181 is not there

(10103,'2003-01-29','2003-02-07','2003-02-02','Shipped',NULL,121),

(10104,'2003-01-31','2003-02-09','2003-02-01','Shipped',NULL,141),

(10105,'2003-02-11','2003-02-21','2003-02-12','Shipped',NULL,145),

(10106,'2003-02-17','2003-02-24','2003-02-21','Shipped',NULL,278),

(10107,'2003-02-24','2003-03-03','2003-02-26','Shipped','Difficult to negotiate with customer. We need more marketing materials',131),

(10108,'2003-03-03','2003-03-12','2003-03-08','Shipped',NULL,385),

(10109,'2003-03-10','2003-03-19','2003-03-11','Shipped','Customer requested that FedEx Ground is used for this shipping',486),

(10110,'2003-03-18','2003-03-24','2003-03-20','Shipped',NULL,187),

(10111,'2003-03-25','2003-03-31','2003-03-30','Shipped',NULL,129),

(10112,'2003-03-24','2003-04-03','2003-03-29','Shipped','Customer requested that ad materials (such as posters, pamphlets) be included in the shippment',144),

(10113,'2003-03-26','2003-04-02','2003-03-27','Shipped',NULL,124),

(10114,'2003-04-01','2003-04-07','2003-04-02','Shipped',NULL,172),

(10115,'2003-04-04','2003-04-12','2003-04-07','Shipped',NULL,424),

(10116,'2003-04-11','2003-04-19','2003-04-13','Shipped',NULL,381),-- same to this one

(10117,'2003-04-16','2003-04-24','2003-04-17','Shipped',NULL,148), -- it is there

(10118,'2003-04-21','2003-04-29','2003-04-26','Shipped','Customer has worked with some of our vendors in the past and is aware of their MSRP',216),--same to this

(10119,'2003-04-28','2003-05-05','2003-05-02','Shipped',NULL,382); -- 382 is not in the customers table (customerNumber)


SELECT * FROM customers;

insert into payments values
(101,'HQ336336','2004-10-19','6066.78'),

(102,'JM555205','2003-06-05','14571.44'),

(103,'OM314933','2004-12-18','1676.14'),

(104,'BO864823','2004-12-17','14191.12'),

(105,'HQ55022','2003-06-06','32641.98'),

(106,'ND748579','2004-08-20','33347.88'),

(107,'GG31455','2003-05-20','45864.03'),

(108,'MA765515','2004-12-15','82261.22'),

(109,'NP603840','2003-05-31','7565.08'),

(110,'NR27552','2004-03-10','44894.74'),

(111,'DB933704','2004-11-14','19501.82'),

(112,'LN373447','2004-08-08','47924.19'),

(113,'NG94694','2005-02-22','49523.67'),

(114,'DB889831','2003-02-16','50218.95'),

(115,'FD317790','2003-10-28','1491.38'),

(116,'KI831359','2004-11-04','17876.32'),

(117,'MA302151','2004-11-28','34638.14'),

(118,'AE215433','2005-03-05','101244.59'),

(119,'BG255406','2004-08-28','85410.87'),

(120,'CQ287967','2003-04-11','11044.30');





--  TASK 4. Delete the columns in productlines which are useless that do not infer anything

SELECT * FROM productlines; -- viewing the productlines table first

-- In my case, columns 'htmlDescription' and 'image' are not important since they have no values/items.

-- Deleting 'htmlDescription' and 'image'
ALTER TABLE productlines
DROP COLUMN htmlDescription, image;

-- verifying if the dropped columns are removed
SELECT * FROM productlines;



-- TASK 7. Give the unique count of customerName from customers.

SELECT COUNT(DISTINCT customerName) AS Unique_Customer_Count FROM customers; -- Gets the unique count of customers name from the customers table






-- TASK 9. Creating a Stored Procedure for products
-- Create a stored procedure to display productLine for Classic Cars
CREATE PROCEDURE GetClassicCars
AS
BEGIN
    SELECT productLine
    FROM products
    WHERE productLine = 'Classic Cars';
END;

-- Executing the stored procedure
EXEC GetClassicCars;


-- TASK 10. Create a Function to Get Credit Limits
-- Creating a function to get creditLimit of customers less than 96800
CREATE FUNCTION FindCreditLimitsBelow96800()
RETURNS TABLE
AS
RETURN
(
    SELECT customerNumber, customerName, creditLimit
    FROM customers
    WHERE creditLimit < 96800
);

-- Using the function
SELECT * FROM FindCreditLimitsBelow96800();


-- TASK 11. Create Trigger to store transaction record for employee table which displays employeeNumber, lastName, FirstName
-- and office code upon insertion
-- Creating a trigger for insertion on the employees table
CREATE TRIGGER trig_InsertEmployee
AFTER INSERT
ON employees
FOR EACH Row
BEGIN
    -- Assuming there is a table named 'employeeTransactions' to store employee transaction records
    INSERT INTO employeeTransactions (employeeNumber, lastName, firstName, officeCode)
    VALUES (NEW.employeeNumber, NEW.lastName, NEW.firstName, NEW.officeCode)
END;
-- Checking transaction
SELECT * FROM employeeTransactions;


-- TASK 12. Create a Trigger to display customer number if the amount is greater than 10,000

CREATE TRIGGER log_high_transaction
AFTER INSERT ON trsansactions
FOR EACH ROW 
-- Assuming there is a table 'high_vallu_transactions' that stores customer transaction greater than 10000
BEGIN
	IF NEW.amount > 10000 THEN
	INSERT INTO high_value_transactions (customerNumber, amount, transactionDate)
	VALUES (NEW.customerNumber, NEW.amount, NOW())
	END IF;
END;


-- TASK 13.Create Users, Roles and Logins according to 3 Roles: Admin, HR, and 
--Employee. Admin can view full database and has full access, HR can view 
--and access only employee and offices table. Employee can view all tables only.

-- Creating Roles
CREATE ROLE admin_role;
CREATE ROLE hr_role;
CREATE ROLE employee_role;

-- Granting privileges to roles
-- admin privileges
GRANT SELECT, INSERT, UPDATE, DELETE ON DATABASE::MotorCertification TO admin_role;
-- hr privileges
GRANT SELECT, INSERT, UPDATE, DELETE ON employees TO hr_role;
GRANT SELECT, INSERT, UPDATE, DELETE ON offices TO hr_role;
-- employee privileges
GRANT SELECT ON customers TO employee_role;
GRANT SELECT ON employees TO employee_role;
GRANT SELECT ON offices TO employee_role;
GRANT SELECT ON productlines TO employee_role;
GRANT SELECT ON products TO employee_role;
GRANT SELECT ON orders TO employee_role;
GRANT SELECT ON payments TO employee_role;


--creating logins

CREATE LOGIN admin_role WITH PASSWORD = 'AdminStrong@123';
CREATE LOGIN hr_role WITH PASSWORD = 'hR@123';
CREATE LOGIN employee_role WITH PASSWORD = 'emPloyee@123';

-- creating users for each login in the database
CREATE USER admin_user FOR LOGIN admin_login;
CREATE USER hr_user FOR LOGIN hr_login;
CREATE USER employee_user FOR LOGIN employee_login;

-- assigning roles to users
ALTER  ROLE admin_role ADD MEMBER admin_user;
ALTER ROLE hr_role ADD MEMBER hr_user;
ALTER ROLE employee_role ADD MEMBER employee_user;



--Resolving errors with inserting values into the payment, orders and orderdetails tables
-- create a temporary table for payment
CREATE TABLE temp_payment (
    customerNumber INT,
    checkNumber VARCHAR(50),
    paymentDate DATE,
    amount FLOAT
);

--Insert payments data to the above temporary payments table
insert into temp_payment values
(101,'HQ336336','2004-10-19','6066.78'),

(102,'JM555205','2003-06-05','14571.44'),

(103,'OM314933','2004-12-18','1676.14'),

(104,'BO864823','2004-12-17','14191.12'),

(105,'HQ55022','2003-06-06','32641.98'),

(106,'ND748579','2004-08-20','33347.88'),

(107,'GG31455','2003-05-20','45864.03'),

(108,'MA765515','2004-12-15','82261.22'),

(109,'NP603840','2003-05-31','7565.08'),

(110,'NR27552','2004-03-10','44894.74'),

(111,'DB933704','2004-11-14','19501.82'),

(112,'LN373447','2004-08-08','47924.19'),

(113,'NG94694','2005-02-22','49523.67'),

(114,'DB889831','2003-02-16','50218.95'),

(115,'FD317790','2003-10-28','1491.38'),

(116,'KI831359','2004-11-04','17876.32'),

(117,'MA302151','2004-11-28','34638.14'),

(118,'AE215433','2005-03-05','101244.59'),

(119,'BG255406','2004-08-28','85410.87'),

(120,'CQ287967','2003-04-11','11044.30');

-- verifying insertion
SELECT * FROM temp_payment;

--identifying missing customerNumber values not in customers table
SELECT DISTINCT customerNumber
FROM temp_payment
WHERE customerNumber NOT IN (SELECT customerNumber FROM customers);

-- adding missing customers
INSERT INTO customers (customerNumber, customerName, contactLastName, contactFirstName, phone, addressLine1, city, state, postalCode, country, salesRepEmployeeNumber, creditLimit)
SELECT DISTINCT customerNumber, 'Unknown', 'Unknown', 'Unknown', '000-000-0000', 'Unknown Address', 'Unknown City', 'Unkwown State', 'Unkwown Address', 'Unkwon coutry', NULL, NULL
FROM temp_payment
WHERE customerNumber NOT IN (SELECT customerNumber FROM customers);

EXEC sp_help customers

--creating a temporary table for orders table
CREATE TABLE temp_orders (
    orderNumber INT PRIMARY KEY,
    orderDate DATE,
    requiredDate DATE,
    shippedDate DATE,
    status VARCHAR(50),
    comments TEXT,
    customerNumber INT
);

-- insert values into temp_orders

insert into temp_orders values
(10100,'2003-01-06','2003-01-13','2003-01-10','Shipped',NULL,363), -- 363 not in customers table

(10101,'2003-01-09','2003-01-18','2003-01-11','Shipped','Check on availability.',128),

(10102,'2003-01-10','2003-01-18','2003-01-14','Shipped',NULL,181),-- 181 is not there

(10103,'2003-01-29','2003-02-07','2003-02-02','Shipped',NULL,121),

(10104,'2003-01-31','2003-02-09','2003-02-01','Shipped',NULL,141),

(10105,'2003-02-11','2003-02-21','2003-02-12','Shipped',NULL,145),

(10106,'2003-02-17','2003-02-24','2003-02-21','Shipped',NULL,278),

(10107,'2003-02-24','2003-03-03','2003-02-26','Shipped','Difficult to negotiate with customer. We need more marketing materials',131),

(10108,'2003-03-03','2003-03-12','2003-03-08','Shipped',NULL,385),

(10109,'2003-03-10','2003-03-19','2003-03-11','Shipped','Customer requested that FedEx Ground is used for this shipping',486),

(10110,'2003-03-18','2003-03-24','2003-03-20','Shipped',NULL,187),

(10111,'2003-03-25','2003-03-31','2003-03-30','Shipped',NULL,129),

(10112,'2003-03-24','2003-04-03','2003-03-29','Shipped','Customer requested that ad materials (such as posters, pamphlets) be included in the shippment',144),

(10113,'2003-03-26','2003-04-02','2003-03-27','Shipped',NULL,124),

(10114,'2003-04-01','2003-04-07','2003-04-02','Shipped',NULL,172),

(10115,'2003-04-04','2003-04-12','2003-04-07','Shipped',NULL,424),

(10116,'2003-04-11','2003-04-19','2003-04-13','Shipped',NULL,381),-- same to this one

(10117,'2003-04-16','2003-04-24','2003-04-17','Shipped',NULL,148), -- it is there

(10118,'2003-04-21','2003-04-29','2003-04-26','Shipped','Customer has worked with some of our vendors in the past and is aware of their MSRP',216),--same to this

(10119,'2003-04-28','2003-05-05','2003-05-02','Shipped',NULL,382); -- 382 is not in the customers table (customerNumber)


-- checking for missing valus not in customers table

SELECT DISTINCT customerNumber
FROM temp_orders
WHERE customerNumber NOT IN (SELECT customerNumber FROM customers);

-- add missing values
INSERT INTO customers (customerNumber, customerName, contactLastName, contactFirstName, phone, addressLine1, city)
SELECT DISTINCT customerNumber, 'Unknown', 'Unknown', 'Unknown', '000-000-0000', 'Unknown Address', 'Unknown City'
FROM temp_orders
WHERE customerNumber NOT IN (SELECT customerNumber FROM customers);

--creating a temperory table for order detail
CREATE TABLE temp_oderdetails (
    orderNumber INT PRIMARY KEY,
    productCode VARCHAR(50),
    quantityOrdered INT,
    priceEach FLOAT,
    orderLineNumber SMALLINT
);
EXEC sp_help temp_oderdetails
-- inserting values into temp_orderdetails
insert into temp_oderdetails(orderNumber, productCode, quantityOrdered, priceEach, orderLineNumber)

	VALUES (10100,'S18_1749',30,'136.00',3),
			(10101,'S18_2248',50,'55.09',2),

			(10102,'S18_4409',22,'75.46',4),

			(10103,'S24_3969',49,'35.29',1),

			(10104,'S18_2325',25,'108.06',4),

			(10105,'S18_2795',26,'167.06',1),

			(10106,'S24_1937',45,'32.53',3),

			(10107,'S24_2022',46,'44.35',2),

			(10108,'S18_1342',39,'95.55',2),

			(10109,'S18_1367',41,'43.13',1),

			(10110,'S10_1949',26,'214.30',11),

			(10111,'S10_4962',42,'119.67',4),

			(10112,'S12_1666',27,'121.64',8),

			(10113,'S18_1097',35,'94.50',10),

			(10114,'S18_2432',22,'58.34',2),

			(10115,'S18_2949',27,'92.19',12),

			(10116,'S18_2957',35,'61.84',14),

			(10117,'S18_3136',25,'86.92',13),

			(10118,'S18_3320',46,'86.31',16),

			(10119,'S18_4600',36,'98.07',5);

-- checking for missing values in products table

SELECT DISTINCT productCode
FROM temp_oderdetails
WHERE productCode NOT IN (SELECT productCode FROM products);

SELECT * FROM products

--adding missing values to products table

INSERT INTO products (productCode, productName, productLine, productScale, productVendor, productDescription, quantityInStock, buyPrice, MSRP)
SELECT DISTINCT productCode, 'Placeholder Product', 'Motorcycles', '1:10', 'Min Lin Diecast', 'Description for placeholder', 100, 50.00, 100.00
FROM temp_oderdetails
WHERE productCode NOT IN (SELECT productCode FROM products);


INSERT INTO orderdetails (orderNumber, productCode, quantityOrdered, priceEach, orderLineNumber)
SELECT orderNumber, productCode, quantityOrdered, priceEach, orderLineNumber
FROM temp_oderdetails;



EXEC sp_help orderdetails

SELECT * FROM products





EXEC sp_help products