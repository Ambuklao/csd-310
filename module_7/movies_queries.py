import mysql.connector
from mysql.connector import errorcode

config = {
    "user": "movies_user",
    "password": "popcorn",
    "host": "127.0.0.1",
    "database": "movies",
    "raise_on_warnings": True
}
try:
    db = mysql.connector.connect(**config)
    cursor = db.cursor()

    cursor.execute("SELECT studio_id, studio_name FROM studio;")
    print("-- DISPLAYING Studio RECORDS --")
    studios = cursor.fetchall()
    for studio in studios:
        print("Studio ID: {}\nStudio Name: {}\n".format(studio[0], studio[1]))

    cursor.execute("SELECT genre_id, genre_name FROM genre;")
    print("-- DISPLAYING Genre RECORDS --")
    genres = cursor.fetchall()
    for genre in genres:
        print("Genre ID: {}\nGenre Name: {}\n".format(genre[0], genre[1]))

    cursor.execute("SELECT film_name, film_runtime FROM film WHERE film_runtime  BETWEEN 104 AND 117;")
    print("-- DISPLAYING Short Film RECORDS --")
    films = cursor.fetchall()
    for film in films:
        print("Film Name: {}\nRuntime: {}\n".format(film[0], film[1]))

    cursor.execute(
        "SELECT film_name, film_director FROM film INNER JOIN studio ON studio.studio_name = '20th Century Fox' ORDER BY film_releaseDate DESC;")
    print("-- DISPLAYING Director RECORDS in ORDER --")
    films = cursor.fetchall()
    for film in films:
        print("Film Name: {}\nRuntime: {}\n".format(film[0], film[1]))

except mysql.connector.Error as err:

    if err.errno == errorcode.ER_ACCESS_DENIED_ERROR:
        print(" The supplied username or password are invalid")

    elif err.errno == errorcode.ER_BAD__DB_ERROR:
        print(" The specified database does not exist")

    else:
        print(err)

finally:
    db.close()