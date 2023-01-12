import mysql.connector
from tabulate import tabulate

connection = mysql.connector.connect(
			user='root', 
			password='',
			host='127.0.0.1', 
			database='esport'	
		)


print("Create player")
print("Pour quelle équipe ?")
query = "SELECT id, name from teams" 
cursor = connection.cursor(dictionary=True)

cursor.execute(query)

teams = cursor.fetchall()

for team in teams:
    print(team['id'], " " , team['name'])

team_id = input("select a team id: ")

query = "SELECT * from teams WHERE id = %s"
data = (team_id,)
cursor.execute(query, data)
team = cursor.fetchone()
print("The player will be added to this team")
print(team)

print("Player information")

last_name = input("last name (min 2 char, max 15): ")
while len(last_name) < 2:
    print("Minimum input 2 char")
    last_name = input("name (min 2 char, max 15): ")
    
while len(last_name) > 15:
    print("Max input 15 char")
    last_name = input("name (min 2 char, max 15): ")
    
first_name =  input("first name (min 2 char, max 15): ")
    
bib_number = input("bib_number : ")

query = "INSERT into players(first_name,last_name,bib_number, team_id) values(%s,%s,%s,%s)"
tuple = (first_name,last_name,bib_number, team_id)
cursor = connection.cursor()
cursor.execute(query,tuple)
connection.commit()

query = "SELECT players.*, teams.name from players inner join teams on players.team_id = teams.id WHERE players.id = %s"
tuple = (cursor.lastrowid,)
cursor.execute(query, tuple)
new_player = cursor.fetchone()
print(new_player)
