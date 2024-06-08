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
while IFS="," read -r CAR_ID YEARMODEL MAKE MODEL CATEGORY PLATE AVAILABLE
do
  # Skip the header line
  if [[ $CAR_ID == "car_id" ]]
  then
    continue
  fi

  #------------------------------------------------------------------------------#
  # INSERT DATA
  INSERT_ALL_IN=$($PSQL "INSERT INTO cars(car_id, year_model, make, model, category, plate, available) VALUES($CAR_ID, $YEARMODEL, '$MAKE', '$MODEL', '$CATEGORY', '$PLATE', $AVAILABLE)")

  # RENAME OUTPUT
  if [[ $INSERT_ALL_IN == "INSERT 0 1" ]]
  then 
    echo "Inserted into cars, $CAR_ID, $YEARMODEL, $MAKE, $MODEL, $CATEGORY, $PLATE, $AVAILABLE"
  fi
done < "$DATA_FILE"
