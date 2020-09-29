"""
Inserts randomly generated rows in to local db
"""
import psycopg2.extras
import app_name_generator as ang

try:
    connection = psycopg2.connect(user="",
                                  password="",
                                  host="",  # localhost
                                  port="",
                                  database="")

    cursor = connection.cursor()
    x = ang.rand_word_list.split()

    SQL_str = 'INSERT INTO mainschema.apps(pk, id, title, description, published_timestamp, last_updated_timestamp)' \
              'VALUES (%s, %s, %s, %s, %s, %s);'
    count = 5000000
    pk = 0
    while count >= 0:
        generate_rows = []
        for i in range(0, 10000):
            if count == 0:
                break
            generate_rows.append((pk, ang.gen_unique_id(), ang.gen_random_title(x), ang.gen_random_desc(x),
                         ang.gen_upload_datetime(2014, 2018), ang.gen_update_datetime(2019, 2020)))
            count -= 1
            pk = pk + 1
        psycopg2.extras.execute_batch(cursor, SQL_str, generate_rows, page_size=10000)

        print("%d left to produce" % count)
        connection.commit()

    print("Selecting rows from mobile table using cursor.fetchall")

except (Exception, psycopg2.Error) as error:
    print("Error while fetching data from PostgreSQL", error)

finally:
    # closing database connection.
    if connection is not None:
        cursor.close()
        connection.close()
        print("PostgreSQL connection is closed")
