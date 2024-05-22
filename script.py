import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
import psycopg2

try:
    # CONECT INTO POSTGRESQL 
    conn = psycopg2.connect(
        host="localhost",
        database="cars",
        user="postgres",
        password="123",
        options="-c client_encoding=UTF8"
    )
    
    # CREATE A CURSOR
    cursor = conn.cursor()

    # COUNT THE CARS BY YEAR INTO THE DATABASE 
    cursor.execute("SELECT year_model, COUNT(*) FROM cars GROUP BY year_model ORDER BY year_model")
    year_data = cursor.fetchall()

    # COUNT THE CARS BY MAKES INTO THE DATABASE 
    cursor.execute("SELECT make, COUNT(*) FROM cars GROUP BY make ORDER BY make")
    make_data = cursor.fetchall()

    # QUIT CURSOR AND CONNECTION
    cursor.close()
    conn.close()

    # EXTRACT YEAR AND COUNT IN CARS
    years = [row[0] for row in year_data]
    year_counts = [row[1] for row in year_data]

    # EXTRACT MAKES AND COUNT IN CARS
    makes = [row[0] for row in make_data]
    make_counts = [row[1] for row in make_data]

    # CREATE PIE CHART FOR CARS PER YEAR
    plt.figure(figsize=(8, 6))
    plt.pie(year_counts, labels=years, autopct='%1.1f%%', startangle=140)
    plt.title('Cars per Year')
    plt.axis('equal')
    plt.show()  # Show the figure
    # Save the figure
    # plt.savefig('cars_per_year.png')  

    # CREATE BAR CHART FOR CARS BY MAKE
    plt.figure(figsize=(12, 6))
    plt.bar(makes, make_counts)
    plt.title('Cars by Make')
    plt.xlabel('Make')
    plt.ylabel('Number of Cars')
    plt.xticks(rotation=45, ha='right')
    plt.show()  # Show the figure
    # Save the figure
    # plt.savefig('cars_by_make.png') 

except psycopg2.Error as e:
    print("Failed to connect PostgreSQL", e)
