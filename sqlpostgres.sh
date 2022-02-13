#!/bin/bash
mysql -uroot -proot -h127.0.0.1 -P3307 --protocol=tcp <<MYSQL_SCRIPT
CREATE DATABASE botkin;
USE botkin; 
CREATE TABLE COSTS(
  id INT PRIMARY KEY AUTO_INCREMENT UNIQUE,
  name VARCHAR(50) NOT NULL,
  price INT NOT NULL );
 
CREATE TABLE PRODUCTS(
  id INT  PRIMARY KEY AUTO_INCREMENT UNIQUE,
  name VARCHAR(50) NOT NULL,
  quantity INT,
  priceid INT NOT NULL,
  status VARCHAR(50) NOT NULL,
  FOREIGN KEY (priceid)  REFERENCES COSTS (id));
exit
MYSQL_SCRIPT
sleep 2
PGPASSWORD=root psql -h 172.17.0.1 -p 5410 -U root -d root postgres -c 'CREATE DATABASE botkin' 
PGPASSWORD=root psql -h 172.17.0.1 -p 5410 -U root -d botkin <<MYPOSTGRESSQL_SCRIPT
CREATE TABLE COSTS(
  id SERIAL PRIMARY KEY unique,
  name VARCHAR(50) NOT NULL,
  price INT NOT NULL);
 
CREATE TABLE PRODUCTS(
  id SERIAL PRIMARY KEY unique,
  name VARCHAR(50) NOT NULL,
  quantity INT NOT NULL,
  priceid SERIAL,
  status VARCHAR(50) NOT NULL,
  FOREIGN KEY (priceid)  REFERENCES COSTS (id));




