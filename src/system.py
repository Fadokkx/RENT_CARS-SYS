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
        pass

def return_menu():
    print("Return a car menu")

def exit_program():
    print("Exiting the program, thank you")
    exit()


if __name__ == "__main__":
    main_menu()

# Close the cursor and connection
cursor.close()
conn.close()