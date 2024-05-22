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

    # SEARCH ALL CONSULTS RESULTS
    rows = cursor.fetchall()

    # QUIT CURSOR AND
    cursor.close()
    conn.close()

    # EXTRACT YEAR AND COUNT IN CARS
    year = [row[0] for row in rows]
    count = [row[1] for row in rows]

    # CREATE GRAPH FIGURE 
    plt.figure(figsize=(8, 6))
    plt.pie(count, labels=year, autopct='%1.1f%%', startangle=140)    
    plt.title('Cars per year')
    plt.axis('equal')  # Equal aspect ratio ensures that pie is drawn as a circle.

    # SHOW THE GRAPH
    plt.show()

except psycopg2.Error as e:
    print("Failed to connect POSTGRESQL :", e)