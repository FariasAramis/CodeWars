/*
The objective of this Kata is to show that you are proficient at string manipulation (and perhaps that you can use extensively subqueries).

You will use people table but will focus solely on the name column

name
Greyson Tate Lebsack Jr.
Elmore Clementina O'Conner
you will be provided with a full name and you have to return the name in columns as follows.

name	first_lastname	second_lastname
Greyson Tate	Lebsack	Jr.
Elmore	Clementina	O'Conner
Note: Don't forget to remove spaces around names in your result. Note: Due to multicultural context, if full name has more than 3 words, consider first 2 as name
*/
WITH auxiliar AS (
                SELECT ROW_NUMBER() OVER() as row,
                       name as lname,
                       array_length(REGEXP_SPLIT_TO_ARRAY(name,' '),1) as len,
                       REGEXP_SPLIT_TO_ARRAY(name,' ') as array_name
                FROM people
               )
SELECT CASE WHEN len<4 THEN array_name[1]::text ELSE array_to_string(array_name[1:2], ' ') END as name,
       array_name[len-1]::text as first_lastname,
       array_name[len]::text as second_lastname
FROM people
 JOIN auxiliar on lname=name
 ORDER BY row
