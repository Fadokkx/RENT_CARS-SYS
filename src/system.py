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
        # Get car availability
        cursor.execute("SELECT available FROM cars WHERE car_id = %s AND available = true", (CAR_ID_TO_RENT,))
        car_available = cursor.fetchall()
        # If car isn't available
        if len(car_available) == 0:
            print ("This car is not available at the moment.")
            exit_program()
        else:
            # Send to "SIGN UP" screen
            print ("\nOne more thing to complete the rent service\n")
            phone = input("\nInput your phone number \n(in the international format = 12025551234 without spaces or any symbol) \n: ") 
            
            # Check if phone is in database 
            cursor.execute("SELECT * FROM customers WHERE phone = %s", (phone,))
            PHONE_CHECK = cursor.fetchall()

            # If phone isn't in database
            if len(PHONE_CHECK) == 0:
                print("\nYour phone isn't in our system")
                name = input("\nEnter your name to register: ") # Required to register
                email = input("\nNow, your email: ") # Required to register
                country = input("\nAnd finally, your country of birth: ") # Required to register
                
                # Insert the variables into database
                cursor.execute("INSERT INTO customers (name, phone, country, email) VALUES (%s, %s, %s, %s)", (name, phone, country, email))
                conn.commit()
                print("\nYou have been successfully registered.")

                # Catch the car's info
                cursor.execute("SELECT year_model, make, model, plate FROM cars WHERE car_id = %s", (CAR_ID_TO_RENT,))
                car_info = cursor.fetchone()
                
                if car_info and len(car_info) == 4:
                    # Set car as rented in database
                    cursor.execute("UPDATE cars SET available = false WHERE car_id = %s", (CAR_ID_TO_RENT,))
                    conn.commit()
                    print(f"Ok, {name}.")
                    print(f"Your {car_info[0]} {car_info[1]} {car_info[2]} with the plate {car_info[3]} will be delivered to you, please wait a moment.") 
                    
                    # Get the new customer_id and link in rental table
                    cursor.execute("SELECT customer_id FROM customers WHERE phone = %s", (phone,))
                    new_customer_id = cursor.fetchone()[0]
                    cursor.execute("INSERT INTO rentals (customer_id, car_id, date_rented) VALUES (%s, %s, current_timestamp)", (new_customer_id, CAR_ID_TO_RENT))
                    conn.commit()
                else:
                    print("Error fetching car information. Please try again.")
            # If phone is in database
            else:
                # Check if the data is right
                for row in PHONE_CHECK:
                    print(f"Are you {row[1]} from {row[3]} and email = {row[4]} ")
                    check_identify = input("\nRight (y/n) ?\n")
                    if check_identify == "y":
                        print(f"Ok, {row[1]}.")
                        
                        # Catch the car's info
                        cursor.execute("SELECT year_model, make, model, plate FROM cars WHERE car_id = %s", (CAR_ID_TO_RENT,))
                        car_info = cursor.fetchone()

                        if car_info and len(car_info) == 4:
                            print(f"Your {car_info[0]} {car_info[1]} {car_info[2]} with the plate {car_info[3]} will be delivered to you, please wait a moment.\n") 

                        # Set car as rented in database
                        cursor.execute("UPDATE cars SET available = false WHERE car_id = %s", (CAR_ID_TO_RENT,))
                        conn.commit()

                        # Get customer_id and link at rental table
                        customer_id = row[0]
                        cursor.execute("INSERT INTO rentals (customer_id, car_id, date_rented) VALUES (%s, %s, current_timestamp)", (customer_id, CAR_ID_TO_RENT))
                        conn.commit()
                        break
                    elif check_identify == "n":
                        print("Let's check your information again")
                        rent_menu()
                    else:
                        print("Type 'y' for yes or 'n' for no")

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
