# 42-matters
# 42matters: Python Script for moving data from Postgresql to Redshift
## Creating the Local Database

In a local postgres database a table "apps" was created with the following columns: 
  
 tablename: | apps
--- | --- 
pk | primary key Int
id  | UNIQUE  VARCHAR(256)
title | VARCHAR(200)
description | VARCHAR(2000)
published_timestamp | TIMESTAMP
last_update_timestamp | TIMESTAMP

The table was populated using the script: `app_name_generator.py`.  This script uses the infamous `Lorum Ipsum` text to assist in randomly generate 5 million rows of application data. This text was used because the requirements did not mention using actual application names or descriptions within the table. The randomly generated created by different methods:

### id
Since the id must be unique, I used the `UUID` library, which creates unique 16 byte id

### title and description
The Random library was used to pick a one word title, and a five word description from the Lorum Ipsum text

### published_timestamp and last_update_timestamp
The timestamps were generated using the Datetime library. Since the upload timestamp must always be prior to the update timestamp, I set the parameters of the upload dates from (2014-2018), and the update timestamps from (2019 -2020). This could be done using boolean logic `published_timestamp  < updated_timestamp`, however, I was getting bogged down by  datatype issues, and wanted to focus on the rest of the project.

## Adding data to Localdb
After the logic to generate random rows is up and running, it's time to dump the data into a local postgres db. This is done using the The python script, `insert_apps.py`. Generating and creating 5 million rows is time-consuming, and can lead to issues with insertion if an error occurs in the middle or end of this process. Therefore, the data was inserted in batches of 10,000 rows using a method from the `psycopg1` library called `execute_batch`.

## Pushing data to S3
A compressed gzip file containing all of the information from the `apps` table was created using following scripts. The first script creates a flat .sql file of the table.

```
pg_dump dbname, username -f postgresdump.sql

```
And then it's compressed into gzip format: 
```
Psql  -c "COPY mainschema.apps TO stdout DELIMITER ',' CSV HEADER" | gzip > app_table.csv.gz

```
The csv file has the following format:
```
pk,id,title,description,published_timestamp,last_updated_timestamp
0,168f5e64-68d3-47ae-8587-ebb48500f19c,esse," exercise, the cupidatat fault dolor ",2014-07-08 12:43:49.205844,2020-12-15 20:48:55.374907
1,07ee12e5-96d1-4903-89a1-2d409d88136a,"truth,"," Ipsum aliquam itself, Nemo will ",2014-10-02 01:02:39.794103,2019-12-23 13:21:25.801287
2,7477ddee-4065-42d5-9adf-43c28248dd55,beatae, ut tempora physical the modi ,2014-08-27 16:50:22.042912,2019-05-07 01:51:59.020794
3,0b55444f-814a-4e9a-af8d-728f935d8470,illo, inventore labore aliquip No natus ,2016-11-30 17:06:36.822303,2020-03-30 21:40:32.312339
4,8ac0367d-f549-4545-b484-f1063b7412e4,and, you the velit actual architecto ,2018-06-16 09:30:16.873688,2020-07-22 09:22:22.229325
5,e4420c9f-8301-44dd-aa9e-f398d77016b9,magni, sunt pleasure nulla voluptas know ,2018-04-16 18:46:19.432332,2020-03-12 13:12:06.951015
```

## Uploading the CSV to Redshift
This is where I went astray. I got as far as creating an `apps` table on redshift, and then using a script to populate the table via the csv. However, I was either getting errors about datatypes, or errors about my Authentification, depending on what I was trying. I believe that I was very close, but I must have set something up wrong along the way that I did not have time to troubleshoot. 

# Row Duplication 
The time complexity for this is not great, I estimate it to be `O(M log M + N log N)` because neither of the tables are using indexing, therefore the tables need to be sorted before completing the `LEFT JOIN` on itself. If this table would have used indexing than the time complexity of the joins would be more efficient. 
This solution is good because it is completing the left join on a specific id, which narrows down the rows of data that that need to be sorted through in the query. Another way to do this query is to use `PARTITION BY`, but I usually find those to be slower, so I believe this is a more efficient solution. 


# Everything Else
I'm afraid I didn't have the time to complete everything else. I am willing to finish the rest if I am a potential candidate. Thanks!
