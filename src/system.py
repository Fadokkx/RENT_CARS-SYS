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
    print("\n1. Sign up\n2. Return a car\n3. Rent a car\n4. Update info\n5. Exit")
    
    main_menu_selection = input("\nEnter your choice: ")
    
    if main_menu_selection == "1":
        signup_menu()
    elif main_menu_selection == "2":
        rent_menu()
    elif main_menu_selection == "3":
        return_menu()
    elif main_menu_selection == "4":
        update_menu
    elif main_menu_selection == "5":
        exit_program()
    else:
        print("\nPlease enter a valid option.\n")
        main_menu()

#---------------------------------------SIGN UP MENU  ------------------------------------------------------------------------#
def signup_menu():
    print("\n~~~~~ Sign up menu ~~~~~")
    
    #Explanation the new menu
    print("\nThanks for using our service, using the sign up menu will be more easier to rent your car ")
    print("We'll need your complete information, so be sure to digit your complete name and data as required")

    #Getting variables values
    new_name = input("Insert you complete name (Name Midname Lastname) *no accentuation* please: ")
    if not new_name.isalpha():
        print("Please, tell us your complete name (Name Midname LastName) no accentuation please")
        signup_menu()
    else:
        new_phone = input("Input your phone number \n(in the international format example: +55(11)912345678 without spaces or any symbol): ")
        if not new_phone.isnumeric():
            print("Please, insert your phone number without signals. Your cellphone will be the most important data in the registration")
            signup_menu()
        else:
            new_country = input("Digit your country in english please (The Default value will be set as Brazilian): ")
            if not new_country.isalpha():
                print("Please, insert your country name in english please")
                signup_menu()
            else:
                new_email = input("Tell us your prefereed email (example: JohnDoe@myemaildomain.com): ")
    #Check if the customers is already registered
    cursor.execute("SELECT * FROM customers WHERE name = %s OR phone = %s OR email = %s")
    check_customers_exist = cursor.fethcall()
    if len(check_customers_exist) > 0:
        for row in check_customers_exist:
            print ("It appears that you are already registered or that one of the fields was taken by someone else")
            print(f"{row[0]} Name: {row[1]} phone: {row[2]} and email: {row[4]}")

pass

#--------------------------------------- RENT MENU ------------------------------------------------------------------------#
def rent_menu():
    print("\n~~~~~ Rent a car menu ~~~~~")
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
            phone = input("\nInput your phone number \n(in the international format example: +55(11)912345678 without spaces or any symbol): ") 
            
            # Check if phone is in database 
            cursor.execute("SELECT * FROM customers WHERE phone = %s", (phone,))
            PHONE_CHECK = cursor.fetchall()

            # If phone isn't in database
            if len(PHONE_CHECK) == 0:
                print("\nYour phone isn't in our system")
                name = input("\nEnter your name to register: ") # Required to register
                if name.isdigit():
                    print("Please, insert a valid name")
                    rent_menu()
                email = input("\nNow, your email: ") # Required to register
                country = input("\nAnd finally, your country of birth: ") # Required to register
                if country.isdigit():
                    print("Please, insert a valid country")
                    rent_menu()
                
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
    print("\n~~~~~ Return a car menu ~~~~~")
    #Catch the data to confirm registration
    phone_return = input("\nInput your phone number as in registration \n(in the international format example: +55(11)912345678 without spaces or any symbol): ")
    name_return = input("\nInput your name as in registration: ")
    #check in database what's the registration
    cursor.execute("SELECT name, phone FROM customers WHERE name = %s AND phone = %s", (name_return, phone_return))
    check_customers_rental = cursor.fetchall()
    #if returns 0 tuples send to main menu
    if len(check_customers_rental) == 0:
        print("Your information seems to be incorrect. Please try again or Sign up in Sign up menu or in Rent Menu.")
        main_menu()
    else:
        # catch the results
        customer = check_customers_rental[0] if check_customers_rental else None
        if customer:
            print(f"I found results with these parameters, are you {customer[0]} with phone {customer[1]}?")
            check_identify = input("\nIs this correct (y/n)? ")
            pass

#--------------------------------------- UPDATE INFO MENU ------------------------------------------------------------------------#
def update_menu():
    print("\n~~~~~ Update Customer data menu ~~~~~")
    pass

#---------------------------------------EXIT------------------------------------------------------------------------#
def exit_program():
    print("Exiting the program, thank you")
    exit()

if __name__ == "__main__":
    main_menu()

# Close the cursor and connection
cursor.close()
conn.close()
