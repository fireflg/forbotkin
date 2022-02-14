#!/bin/bash

PGPASSWORD=root psql -h 172.17.0.1 -p 5410 -U root -d botkin << MYPOSTGRESQ2L_SCRIPT
COPY (select * from COSTS) To '/var/lib/postgresql/costs.csv' With CSV;
COPY (select * from PRODUCTS) To '/var/lib/postgresql/products.csv' With CSV;
MYPOSTGRESQ2L_SCRIPT

docker cp db-postgres:/var/lib/postgresql/costs.csv /home/costs.csv
docker cp db-postgres:/var/lib/postgresql/products.csv /home/products.csv
docker cp /home/products.csv db-mysql:/var/lib/mysql-files/products.csv
docker cp /home/costs.csv db-mysql:/var/lib/mysql-files/costs.csv

mysql -uroot -proot -h 127.0.0.1 -P 3307 --protocol=tcp <<MYSQL2_SCRIPT
USE botkin
LOAD DATA INFILE 
'/var/lib/mysql-files/costs.csv'
INTO TABLE COSTS 
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
(id,name,price);

LOAD DATA INFILE 
'/var/lib/mysql-files/products.csv'
INTO TABLE PRODUCTS
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
(id,name,quantity,priceid,status);
MYSQL2_SCRIPT
