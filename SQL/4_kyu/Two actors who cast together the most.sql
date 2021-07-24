/*
Given the the schema presented below find two actors who cast together the most and list titles of only those movies they were casting together. Order the result set alphabetically by the movie title.

Table film_actor
 Column     | Type                        | Modifiers
------------+-----------------------------+----------
actor_id    | smallint                    | not null
film_id     | smallint                    | not null
...
Table actor
 Column     | Type                        | Modifiers
------------+-----------------------------+----------
actor_id    | integer                     | not null
first_name  | character varying(45)       | not null
last_name   | character varying(45)       | not null
...
Table film
 Column     | Type                        | Modifiers
------------+-----------------------------+----------
film_id     | integer                     | not null
title       | character varying(255)      | not null
...
The desired output:
first_actor | second_actor | title
------------+--------------+--------------------
John Doe    | Jane Doe     | The Best Movie Ever
...
first_actor - Full name (First name + Last name separated by a space)
second_actor - Full name (First name + Last name separated by a space)
title - Movie title
Note: actor_id of the first_actor should be lower then actor_id of the second_actor

https://www.codewars.com/kata/5818bde9559ff58bd90004a2/train/sql
*/

--Here we discover the pair of actor who are cast together the most
WITH TopTeam (actor1,actor2,n_film) as (
  SELECT fa.actor_id,fa2.actor_id, COUNT(fa.actor_id)
  FROM film_actor fa, film_actor fa2
  WHERE fa.actor_id < fa2.actor_id
    AND fa.film_id = fa2.film_id
  GROUP BY fa.actor_id,fa2.actor_id
  ORDER BY COUNT(fa.actor_id) DESC
  LIMIT 1)

--Now let's present the films in which they appear together
SELECT a1.first_name||' '||a1.last_name AS "first_actor",
       a2.first_name||' '||a2.last_name AS "second_actor",
       f.title
FROM actor a1, actor a2, film f, TopTeam tt
WHERE tt.actor1=a1.actor_id
  AND tt.actor2=a2.actor_id
  AND f.film_id IN (SELECT faz1.film_id
                    FROM film_actor faz1,film_actor faz2
                    WHERE faz1.actor_id=a1.actor_id
                    AND   faz2.actor_id=a2.actor_id
                    AND   faz1.film_id=faz2.film_id)
