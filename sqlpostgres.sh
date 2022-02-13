#!/bin/bash
mysql -uroot -proot -h127.0.0.1 -P3307 --protocol=tcp <<MYSQL_SCRIPT
CREATE DATABASE  botkin;
USE botkin; 

CREATE TABLE COSTS(
  id INT NOT NULL,
  name VARCHAR(50) NOT NULL,
  price INT NOT NULL PRIMARY KEY);
 
CREATE TABLE PRODUCTS(
  id INT NOT NULL,
  name VARCHAR(50) NOT NULL,
  quantity INT,
  priceid INT,
  status VARCHAR(50) NOT NULL,
  FOREIGN KEY (priceid)  REFERENCES COSTS (price));
exit
MYSQL_SCRIPT
sleep 1
PGPASSWORD=root psql -h 172.17.0.1 -p 5410 -U root -d root postgres -c 'CREATE DATABASE botkin' 
PGPASSWORD=root psql -h 172.17.0.1 -p 5410 -U root -d botkin <<MYPOSTGRESSQL_SCRIPT
CREATE TABLE COSTS(
  id INT NOT NULL,
  name VARCHAR(50) NOT NULL,
  price INT NOT NULL PRIMARY KEY);
 
CREATE TABLE PRODUCTS(
  id INT NOT NULL,
  name VARCHAR(50) NOT NULL,
  quantity INT,
  priceid INT,
  status VARCHAR(50) NOT NULL,
  FOREIGN KEY (priceid)  REFERENCES COSTS (price));
MYPOSTGRESSQL_SCRIPT



