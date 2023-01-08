 CREATE USER MIZBA
 IDENTIFIED BY MIZBA123;

CREATE TABLE CUSTOMERS(
    CUS_ID VARCHAR2(11) NOT NULL PRIMARY KEY,
    CUS_NAME VARCHAR2(50),
    PREF VARCHAR2(50)
);

CREATE TABLE FRANCHISE(
    RES_ID VARCHAR2(11) NOT NULL PRIMARY KEY,
    NAME VARCHAR2(50),
    BRANCH VARCHAR2(50),
    COUNTRY VARCHAR2(50),
    CUS_ID VARCHAR2(11),
    FOREIGN KEY (CUS_ID) REFERENCES CUSTOMERS(CUS_ID)
);

CREATE TABLE MENU(
    MENU_ID VARCHAR2(11) NOT NULL PRIMARY KEY,
    NAME VARCHAR2(50),
    CHEF_ID VARCHAR2(11),
    RES_ID VARCHAR2(11),
    FOREIGN KEY (CHEF_ID) REFERENCES CHEF(CHEF_ID),
    FOREIGN KEY (RES_ID) REFERENCES FRANCHISE(RES_ID)
);

CREATE TABLE ORDERS(
    ORDER_ID VARCHAR2(11) NOT NULL PRIMARY KEY,
    MENU_ID VARCHAR2(11),
    CUS_ID VARCHAR2(11),
    RATING NUMBER(1),
    FOREIGN KEY (MENU_ID) REFERENCES MENU(MENU_ID),
    FOREIGN KEY (CUS_ID) REFERENCES CUSTOMERS(CUS_ID)
);

CREATE TABLE CHEF(
    CHEF_ID VARCHAR2(11) NOT NULL PRIMARY KEY,
    NAME VARCHAR2(11),
    RES_ID VARCHAR2(11),
    MENU_ID1 VARCHAR2(11),
    MENU_ID2 VARCHAR2(11),
    MENU_ID3 VARCHAR2(11),
    MENU_ID4 VARCHAR2(11),
    MENU_ID5 VARCHAR2(11),
    FOREIGN KEY (RES_ID) REFERENCES FRANCHISE(RES_ID)
);


--1
SELECT NAME, COUNT(CUS_ID)
FROM FRANCHISE
GROUP BY NAME;

--2
SELECT M.MENU_ID, AVG(O.RATING)
FROM MENU M, ORDERS O
WHERE M.MENU_ID = O.MENU_ID
GROUP BY M.MENU_ID;

--3
SELECT MENU_ID
FROM ORDERS
WHERE ROWNUM <= 5
ORDER BY RATING DESC;


--4
SELECT C.CUS_ID, COUNT(F.NAME)
FROM CUSTOMERS C, FRANCHISE F
WHERE C.CUS_ID = F.CUS_ID
GROUP BY C.CUS_ID
HAVING COUNT(DISTINCT F.NAME) >= 2;

--5
SELECT CUSTOMERS.CUS_NAME
FROM CUSTOMERS
WHERE CUSTOMERS.CUS_ID NOT IN (SELECT CUS_ID
                              FROM ORDERS
                              );




INSERT INTO customers (cus_id, cus_name, pref) VALUES ('CUS001', 'John Smith', 'Italian');
INSERT INTO customers (cus_id, cus_name, pref) VALUES ('CUS002', 'Jane Doe', 'Chinese');
INSERT INTO customers (cus_id, cus_name, pref) VALUES ('CUS003', 'Bob Johnson', 'Indian');

INSERT INTO franchise (res_id, name, branch, country, cus_id) VALUES ('RES001', 'KFC', 'New York', 'USA', 'CUS001');
INSERT INTO franchise (res_id, name, branch, country, cus_id) VALUES ('RES002', 'Pizza Hut', 'Chicago', 'USA', 'CUS002');
INSERT INTO franchise (res_id, name, branch, country, cus_id) VALUES ('RES003', 'Dominos Pizza', 'Los Angeles', 'USA', 'CUS003');


INSERT INTO menu (menu_id, name, chef_id, res_id) VALUES ('MENU001', 'Margherita Pizza', 'CHEF001', 'RES001');
INSERT INTO menu (menu_id, name, chef_id, res_id) VALUES ('MENU002', 'Kung Pao Chicken', 'CHEF002', 'RES002');
INSERT INTO menu (menu_id, name, chef_id, res_id) VALUES ('MENU003', 'Butter Chicken', 'CHEF003', 'RES003');

INSERT INTO chef (chef_id, name, res_id, menu_id1, menu_id2, menu_id3, menu_id4, menu_id5) VALUES ('CHEF001', 'Alice', 'RES001', 'MENU001', 'MENU002', 'MENU003', 'MENU004', 'MENU005');
INSERT INTO chef (chef_id, name, res_id, menu_id1, menu_id2, menu_id3, menu_id4, menu_id5) VALUES ('CHEF002', 'Bob', 'RES002', 'MENU001', 'MENU002', 'MENU003', 'MENU004', 'MENU005');
INSERT INTO chef (chef_id, name, res_id, menu_id1, menu_id2, menu_id3, menu_id4, menu_id5) VALUES ('CHEF003', 'Charlie', 'RES003', 'MENU001', 'MENU002', 'MENU003', 'MENU004', 'MENU005');

INSERT INTO orders (order_id, menu_id, cus_id, rating) VALUES ('ORDER001', 'MENU001', 'CUS001', 4);
INSERT INTO orders (order_id, menu_id, cus_id, rating) VALUES ('ORDER002', 'MENU002', 'CUS002', 3);
INSERT INTO orders (order_id, menu_id, cus_id, rating) VALUES ('ORDER003', 'MENU003', 'CUS003', 5);