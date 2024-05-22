#! bin/bash 
# IN PROCESS TO AUTOMATIZE THE INSERT DATA

if [[ $1 == "test" ]]
then 
  PSQL="psql --username=postgres dbname=carstest -t --no-align -c"
else 
  PSQL="psql --username=postgres dbname=cars -t --no-align -c"
fi 

echo $($PSQL "TRUNCATE TABLE cars, costumers")