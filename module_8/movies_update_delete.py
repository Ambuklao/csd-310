import mysql.connector

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


    def show_films(cursor, title):

        cursor.execute(
            "SELECT film_name AS Name, film_director AS Director, genre_name as Genre, studio_name as Studio FROM film INNER JOIN genre ON film.genre_id=genre.genre_id INNER JOIN studio ON film.studio_id=studio.studio_id order by film_id ASC")
        films = cursor.fetchall()
        print("\n -- {} --".format(title))
        for film in films:
            print("Film Name: {}\nDirector: {}\nGenre Name ID: {}\nStudio Name: {}\n".format(film[0], film[1], film[2], film[3]))

          # call the function
    show_films(cursor, "DISPLAYING FILMS")

    sql = "INSERT INTO film(film_name, film_releaseDate, film_runtime, film_director, studio_id, genre_id)VALUES('Star Wars', '1977','121', 'George Lucas', '2', '1')"
    cursor.execute(sql)
    #db.commit()

    # call the function
    show_films(cursor, "DISPLAYING FILMS AFTER INSERT")

    sqlUpdate = "UPDATE film SET genre_id = '1' WHERE film_name = 'Alien'"
    cursor.execute(sqlUpdate)
    #db.commit()

    #call the function
    show_films(cursor, "DISPLAYING FILMS AFTER UPDATE - Changes Alien to Horror")

    sqlDelete = "DELETE FROM film WHERE film_name = 'Gladiator'"
    cursor.execute(sqlDelete)
    #db.commit()

    # call the function
    show_films(cursor, "DISPLAYING FILMS AFTER DELETE")

except mysql.connector.Error as err:

    if err.errno == err.ER_ACCESS_DENIED_ERROR:
        print(" The supplied username or password are invalid")

    elif err.errno == err.ER_BAD__DB_ERROR:
        print(" The specified database does not exist")

    else:
        print(err)

finally:
    db.close()