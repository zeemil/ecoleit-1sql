import mysql.connector
from tabulate import tabulate

connection = mysql.connector.connect(
			user='root', 
			password='',
			host='127.0.0.1', 
			database='esport'	
		)


query = "SELECT * from teams limit 100"
cursor = connection.cursor(dictionary=True)
cursor.execute(query)
records = cursor.fetchall()
print("Nbr rows: ", cursor.rowcount, "\n")

print(tabulate(records,headers="keys", tablefmt="outline"))