import mysql.connector
from tabulate import tabulate

connection = mysql.connector.connect(
			user='root', 
			password='',
			host='127.0.0.1', 
			database='esport'	
		)


print("Team information")
name = input("name : ")
logo = input("logo : ")
country = input("country : ")

query = "INSERT into teams(name,logo_file,country) values(%s,%s,%s)"
tuple = (name,logo,country)
cursor = connection.cursor()
cursor.execute(query,tuple)
connection.commit()