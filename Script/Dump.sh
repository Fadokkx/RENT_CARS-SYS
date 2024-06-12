#!/bin/bash
PSQL="psql -X --username=postgres --dbname=rentcarssys --tuples-only -c"
DUMP="pg_dump -h localhost -U postgres -d rentcarssys -F p -b -v -f dump-rentcarssys.sql"
echo $($PSQL "TRUNCATE table customers, cars, rentals")
echo $($DUMP)
