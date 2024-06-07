import psycopg2

# CONNECT TO POSTGRESQL 
try:
    conn = psycopg2.connect(
        host="localhost",
        database="rentcarssys",
        user="postgres",
        password="123",
        options="-c client_encoding=UTF8"
    )    
    # CREATE A CURSOR
    cursor = conn.cursor()
except Exception as e:
    print(f"Unable to connect to the database: {e}")
    exit()
#---------------------------------------MAIN MENU ------------------------------------------------------------------------#
def main_menu():
    print("\n~~~~~ TopDrive Rent-a-Car Services LTDA. ~~~~~\n")
    print("How may I help you?")
    print("\n1. Rent a car\n2. Return a car\n3. Exit")
    
    main_menu_selection = input("\nEnter your choice: ")
    
    if main_menu_selection == "1":
        rent_menu()
    elif main_menu_selection == "2":
        return_menu()
    elif main_menu_selection == "3":
        exit_program()
    else:
        print("\nPlease enter a valid option.\n")
        main_menu()

#--------------------------------------- RENT MENU ------------------------------------------------------------------------#
def rent_menu():
    print("Rent a car menu")
    cursor.execute("SELECT CAR_ID, YEAR_MODEL, MAKE, MODEL, CATEGORY FROM CARS WHERE available = true;")
    car_data = cursor.fetchall()
    # If database empty
    if len(car_data) == 0:  
        print("We don't have cars today, sorry")
        exit_program()
    else:
        print("\nToday, we have these cars:\nCAR_ID| YEAR| MAKE| MODEL| SIZE")
    # Return all cars in database
        for row in car_data:
            print(f"{row[0]}| {row[1]}| {row[2]}| {row[3]}| {row[4]}")
    
    # Ask what car the customer wants
    print("\nChoose the best car for you: ")
    CAR_ID_TO_RENT = input()
    # Check if Car_id is valid
    if not CAR_ID_TO_RENT.isdigit():
        # Send back
        print("\nPlease, insert a valid option\n")
        rent_menu()
    else:
        #get car Available
        cursor.execute("SELECT available FROM cars WHERE car_id = %s AND available = true", (CAR_ID_TO_RENT,))
        car_available = cursor.fetchall()
        # IF car is'nt available
        if len(car_available) == 0:
            print ("This car is not available at the moment.")
            exit_program()
        else:
            #Send to "SIGN UP" screen
            print ("\nOne more thing to complete the rent service\n")
            phone = input("\nInput your phone number: ") 
            #check if phone is in database 
            cursor.execute("SELECT * FROM customers WHERE phone = %s", (phone,))
            phone_check = cursor.fetchall()
            #if phone isn't in database
            if len(phone_check) == 0:
                print("\nYour phone isn't in our system")
                name = input("\nEnter your name to register: ") # Required to register
                email = input("\nNow, your email: ") # Required to register
                country = input("\nAnd finally, your country of birth: ") # Required to register
                # Insert the variables into database
                cursor.execute("INSERT INTO customers (name, phone, country, email) VALUES (%s, %s, %s, %s)", (name, phone, country, email))
                conn.commit()
                print("You have been successfully registered.")
                # Set car as rented in database
                cursor.execute("UPDATE cars SET available = false WHERE car_id = %s", (CAR_ID_TO_RENT,))
                conn.commit()
                print("Your car will be delivered to you, please wait a moment.")
            #Car now is rented
            
            #if phone is in database
            else:
                #Check if the data is right
                for row in phone_check:
                    print(f"Are you {row[1]} from {row[3]} and email = {row[4]} ")
                    while True:    
                        check_identify=input("\nRight (y/n) ?\n")
                    if check_identify=="y":
                        print (f"Ok, {row[1]}. Your car will be delivery for you, wait a moment.")
                        break

                    elif check_identify=="n":
                        print ("Lets do it all again...")
                        rent_menu()

#---------------------------------------RETURN MENU ------------------------------------------------------------------------#
def return_menu():
    print("Return a car menu")
#---------------------------------------EXIT------------------------------------------------------------------------#
def exit_program():
    print("Exiting the program, thank you")
    exit()


if __name__ == "__main__":
    main_menu()

# Close the cursor and connection
cursor.close()
conn.close()