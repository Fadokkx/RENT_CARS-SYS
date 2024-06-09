#! /bin/bash
# Navigate to the script directory (optional, in case you need relative paths)
cd "$(dirname "$0")" || { echo "Failed to change directory"; exit 1; }

# Define the path to the data file
DATA_FILE="../data/customers_data.csv"

if [[ $1 == "test" ]]
then
  PSQL="psql --username=postgres --dbname=rentcarssystest -t --no-align -c"
else
  PSQL="psql --username=postgres --dbname=rentcarssys -t --no-align -c"
fi

echo $'($PSQL "TRUNCATE TABLE cars, rentals, customers;")'

# Read the data file and process it
while IFS="," read -r CUSTOMER_ID NAME PHONE EMAIL COUNTRY 
do
  # Skip the header line
  if [[ $CUSTOMER_ID == "customer_id" ]]
  then
    continue
  fi

  #------------------------------------------------------------------------------#
  # INSERT DATA
  INSERT_ALL_IN=$($PSQL "INSERT INTO customers(customer_id, name,  phone, email, country) VALUES($CUSTOMER_ID, '$NAME', '$PHONE', '$EMAIL', '$COUNTRY')")

  # RENAME OUTPUT
  if [[ $INSERT_ALL_IN == "INSERT 0 1" ]]
  then 
    echo "Inserted into customers, $CUSTOMER_ID, $NAME, $PHONE, $EMAIL, $COUNTRY"
  fi
done < "$DATA_FILE"