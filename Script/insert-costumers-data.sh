#! /bin/bash
# Navigate to the script directory (optional, in case you need relative paths)
cd "$(dirname "$0")" || { echo "Failed to change directory"; exit 1; }

# Define the path to the data file
DATA_FILE="../data/cars_data.csv"

if [[ $1 == "test" ]]
then
  PSQL="psql --username=postgres --dbname=rentcarssystest -t --no-align -c"
else
  PSQL="psql --username=postgres --dbname=rentcarssys -t --no-align -c"
fi

echo $'($PSQL "TRUNCATE TABLE cars, rentals, customers")'

# Read the data file and process it
while IFS="," read -r CUSTOMER_ID NAME PHONE COUNTRY EMAIL
do
  # Skip the header line
  if [[ $CUSTOMER_ID == "customer_id" ]]
  then
    continue
  fi

  #------------------------------------------------------------------------------#
  # INSERT DATA
  INSERT_ALL_IN=$($PSQL "INSERT INTO customers(customer_id,name,phone,country,email) VALUES($CUSTOMER_ID, $NAME, '$PHONE', '$COUNTRY', '$EMAIL')")

  # RENAME OUTPUT
  if [[ $INSERT_ALL_IN == "INSERT 0 1" ]]
  then 
    echo "Inserted into cars, $CUSTOMER_ID, $NAME, $PHONE, $COUNTRY, $EMAIL"
  fi
done < "$DATA_FILE"
