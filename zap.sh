#!/bin/bash
PGPASSWORD=root psql -h 172.17.0.1 -p 5410 -U root -d botkin <<MYPOSTGRESQ1L_SCRIPT
INSERT INTO costs ( 
  price,
  name) 
SELECT 
  round(random()*70),
  (ARRAY['a','z'])[round(random())+1]
FROM generate_series(1,20);

INSERT INTO products ( 
  name,
  status,
  quantity) 
SELECT 
  (ARRAY['a','z'])[round(random())+1],
  (ARRAY[false,true])[round(random())+1], 
  round(random()*70)
FROM generate_series(1,20);

