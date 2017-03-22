/* USER TABLE */

CREATE TABLE USERS (
	id INTEGER(9) NOT NULL AUTO_INCREMENT,
	username VARCHAR(50) NOT NULL,
	password VARCHAR(100) NOT NULL,
	email VARCHAR(100) NOT NULL,
	PRIMARY KEY (id)
);

/* USER DATA TABLE */

/* We can create a table to specifiy user pemissions for 
	various activities allowed/not allowed on our platform here. 
	Current levels:
	001: Admin
	002: Seller
	003: Buyer
	
	More columns refereing to different permission types can be added later.
*/

/* Setup all the depending tables */

CREATE TABLE USERLVL (
	levelid INTEGER(3) NOT NULL,
	PRIMARY KEY (levelid)
);

INSERT INTO USERLVL VALUE ("001");
INSERT INTO USERLVL VALUE ("002");
INSERT INTO USERLVL VALUE ("003");

CREATE TABLE ADDRESS (
	addrid INTEGER(9),
	sNum INTEGER(9),
	sName VARCHAR(100),
	sType VARCHAR(10),
	unit VARCHAR(5),
	pcode VARCHAR(6),
	city VARCHAR(25),
	province VARCHAR(10),
	country VARCHAR(3), /* ISO 3166-1 alpha-3 Country Code*/
	PRIMARY KEY (addrid)
);

/* Setup the main table */

CREATE TABLE USERINFO (
	id INTEGER(9),
	fname VARCHAR(50) NOT NULL,
	lname VARCHAR(50) NOT NULL,
	lvl INTEGER(3),
	address INTEGER(9),
	emailCode VARCHAR(150)
	FOREIGN KEY (id) REFERENCES USERS(id)
			ON DELETE SET NULL
			ON UPDATE CASCADE,
	FOREIGN KEY (lvl) REFERENCES USERLVL(levelid)
			ON DELETE SET NULL
			ON UPDATE CASCADE,
	FOREIGN KEY (address) REFERENCES ADDRESS(addrid)
			ON DELETE SET NULL
			ON UPDATE CASCADE
);

/* Orders table */

CREATE TABLE ORDERS (
	oid INTEGER(9) NOT NULL AUTO_INCREMENT,
	uid INTEGER(9),
	orderData DATETIME,
	shipAddr INTEGER(9),
	status VARCHAR(100),
	PRIMARY KEY (oid),
	FOREIGN KEY (uid) REFERENCES USERS(id)
			ON DELETE SET NULL
			ON UPDATE CASCADE
	FOREIGN KEY (shipAddr) REFERENCES ADDRESS(addrid)
);

/* Department to Product */

CREATE TABLE DEPARTMENT (
	deptid INTEGER(9) NOT NULL AUTO_INCREMENT,
	name VARCHAR(150)
	PRIMARY KEY (deptid)
);

CREATE TABLE PRODUCT (
	pid INTEGER(9) NOT NULL AUTO_INCREMENT,
	name VARCHAR(150),
	department INTEGER(9),
	PRIMARY KEY (pid),
	FOREIGN KEY (department) REFERENCES DEPARTMENT(deptid)
			ON DELETE SET NULL
			ON UPDATE CASCADE
);

/* Seller products advertizing */

CREATE TABLE LISTS (
	adId INTEGER(9) NOT NULL AUTO_INCREMENT,
	listedBy INTEGER(9),
	listedProd INTEGER(9),
	price INTEGER(8) NOT NULL,
	description TEXT NOT NULL,
	units INTEGER(9) DEFAULT 1,
	PRIMARY KEY (adId),
	FOREIGN KEY (listedBy) REFERENCES USERS(id)
			ON DELETE SET NULL
			ON UPDATE CASCADE,
	FOREIGN KEY (listedProd) REFERENCES PRODUCT(pid)
			ON DELETE SET NULL
			ON UPDATE CASCADE
);

/* 1 Shopping cart for 1 customer */

CREATE TABLE SHOPPINGCART (
	scid INTEGER(9) NOT NULL AUTO_INCREMENT,
	belongsto INTEGER(9),
	PRIMARY KEY (scid),
	FOREIGN KEY (belongsto) REFERENCES USERS(id)
			ON DELETE SET NULL
			ON UPDATE CASCADE
);

/* 1 Shopping cart can contain many products */

CREATE TABLE USERCART (
	scid INTEGER(9),
	pid INTEGER(9),
	FOREIGN KEY (scid) REFERENCES SHOPPINGCART(scid)
			ON DELETE SET NULL
			ON UPDATE CASCADE,
	FOREIGN KEY (pid) REFERENCES PRODUCT(pid)
			ON DELETE SET NULL
			ON UPDATE CASCADE
);


