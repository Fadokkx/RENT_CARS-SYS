#!/bin/bash
PSQL="psql -X --username=postgres --dbname=cars --tuples-only -c"
echo -e "\n~~~~~ TopDrive Rent-a-Car ~~~~~\n"

MAIN_MENU() {
  echo "How may I help you?" 
  echo -e "\n1. Rent a car\n2. Return a car\n3. Exit"
  read -r MAIN_MENU_SELECTION
  case $MAIN_MENU_SELECTION in
  1) RENT_MENU ;;
  2) RETURN_MENU ;;
  3) EXIT ;;
  *) MAIN_MENU "Please enter a valid option.";;
esac
}

RENT_MENU(){
 # get available cars
AVAILABLE_CARS=$($PSQL "SELECT car_id, year_model, make, model, category FROM cars WHERE available = true ORDER BY car_id;")
# if no cars available
if [[ -z $AVAILABLE_CARS ]]
then
 # send to main menu
MAIN_MENU "Sorry, all cars are rented."
else
  # display available cars
echo -e "\nHere are the cars we have today:"
echo "$AVAILABLE_CARS" | while read -r CAR_ID YEAR_MODEL MAKE MODEL CATEGORY
do
  echo "$CAR_ID $YEAR_MODEL $MAKE $MODEL $CATEGORY"
done
  # ask for cars to rent

  # if input is not a number

  # send to main menu

fi
}

RETURN_MENU() {
  echo "Return Menu"
}

EXIT() {
  echo -e "\nThank you for stopping in.\n"
}

MAIN_MENU