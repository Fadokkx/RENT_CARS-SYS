#!/bin/bash
PSQL="psql -X --username=postgres --dbname=cars --tuples-only -c"
DUMP="pg_dump -h localhost -U postgres -d cars -F p -b -v -f dump-cars.sql"
echo $($DUMP)
echo $($PSQL "TRUNCATE table customers, cars")




# cat cars_data_test.csv 