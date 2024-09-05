
import sqlite3

conn = sqlite3.connect('first_db.db') # connection to the db
conn.row_factory = sqlite3.Row # in order to use column name
cursor = conn.cursor() # component to send queries

# SELECT
cursor.execute('SELECT * FROM students') # send query
result = cursor.fetchall() # gets a list of generators
list_results = [tuple(row) for row in result] # generate result
for row in list_results:
    print(row)

# convert tuple to list
list_data = [list(tup) for tup in list_results]
print(list_data)

# UPDATE
cursor.execute('''update students
set birth = birth + 1
where id >= 1;''')
cursor.connection.commit() # saves the data into the file -- write changes

conn.close()

