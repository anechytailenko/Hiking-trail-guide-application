import mysql.connector

mydb = mysql.connector.connect(
    host='localhost',
    user='root',
    password='11213ANNA',
    port='3306',
    database='PythonApp'
)

mycursor = mydb.cursor()

# CREATE principle create table tempature and add column description to table weather
# mycursor.execute('CREATE TABLE temperature(date_id INT, temperature DOUBLE,CONSTRAINT FK_date_id FOREIGN KEY(date_id) REFERENCES weather(id))')
# mycursor.execute('SHOW TABLES')
# tables = mycursor.fetchall()
# print(tables)
# statement1 = 'ALTER TABLE weather ADD COLUMN description VARCHAR(255)'
# mycursor.execute((statement1))
# mydb.commit()


# populate data
# myformula = 'INSERT INTO temperature (date_id, temperature) VALUES(%s,%s)'
# temperature_data = [(1, 25.5),(2, 26.0),(3, 24.8),(4, 23.9),(5, 24.2),(6, 23.7),(7, 25.1),(8, 25.6),(9, 26.8),(10, 27.3),(11, 26.9),(12, 25.7),(13, 24.3),(14, 23.8),(15, 23.5),(16, 24.6),(17, 25.2),(18, 25.9),(19, 26.4),(20, 27.0),(21, 26.5),(22, 25.8),(23, 24.5),(24, 23.4),(25, 22.9),(26, 23.1),(27, 23.6),(28, 24.4),(29, 25.3),(30, 26.1),(31, 26.7)]
# mycursor.executemany(myformula,temperature_data)
# mydb.commit()


# READ principle SELECT info about date WHERE tempreture is the highest
# mycursor.execute('SELECT * FROM weather INNER JOIN temperature on id= date_id WHERE temperature = (SELECT MAX(temperature) FROM temperature)')
# myresult = mycursor.fetchall()
# for row in myresult:
#     print(row)


# UPDATE principle
# statement2 = 'UPDATE weather SET description = "Bad weather" WHERE type_of_weather IN ("Cloudy","Windy","Stormy","Rainy")'
# mycursor.execute(statement2)
# mydb.commit()
# statement3 = 'UPDATE weather SET description = "Good weather" WHERE type_of_weather = "Sunny"'
# mycursor.execute(statement3)
# mydb.commit()



# DELETE principle 25th row was deleted as a result
# statement4 = 'DELETE FROM weather WHERE id = ANY (SELECT date_id FROM temperature WHERE temperature = (SELECT MIN(temperature) FROM temperature))'
# mycursor.execute(statement4)
# mydb.commit()















