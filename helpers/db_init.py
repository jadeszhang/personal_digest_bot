import sqlite3

# open (or create) the database file
conn = sqlite3.connect("data/digest.db")

# read your schema file
with open("db/init.sql", "r") as f:
    schema = f.read()

# execute all statements
conn.executescript(schema)
conn.commit()
conn.close()

print("database initialized")