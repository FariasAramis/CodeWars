/*
Given the schema presented below write a query, which uses a window function, that returns two most viewed posts for every category.

Order the result set by:

category name alphabetically
number of post views largest to lowest
post id lowest to largest
Note:
Some categories may have less than two or no posts at all.
Two or more posts within the category can be tied by (have the same) the number of views. Use post id as a tie breaker - a post with a lower id gets a higher rank.
Schema
categories
 Column     | Type                        | Modifiers
------------+-----------------------------+----------
id          | integer                     | not null
category    | character varying(255)      | not null
posts
 Column     | Type                        | Modifiers
------------+-----------------------------+----------
id          | integer                     | not null
category_id | integer                     | not null
title       | character varying(255)      | not null
views       | integer                     | not null
Desired Output
The desired output should look like this:

category_id | category | title                             | views | post_id
------------+----------+-----------------------------------+-------+--------
5           | art      | Most viewed post about Art        | 9234  | 234
5           | art      | Second most viewed post about Art | 9234  | 712
2           | business | NULL                              | NULL  | NULL
7           | sport    | Most viewed post about Sport      | 10    | 126
...
category_id - category id
category - category name
title - post title
views - the number of post views
post_id - post id


https://www.codewars.com/kata/582001237a3a630ce8000a41

*/
WITH cte AS (
SELECT p2.*,
       c2.id AS cat_id,
       c2.category,
       RANK() OVER( PARTITION BY category_id ORDER BY views DESC,p2.id) as rank
FROM categories c2
  LEFT JOIN posts p2 ON c2.id=p2.category_id
) --Auxiliary table that will substitute the [posts] table. It contains a rank for posts partitioned by the categories

SELECT
      c.id AS category_id,
      c.category,
      p.title,
      p.views,
      p.id AS post_id
FROM categories c
  LEFT JOIN cte p ON c.id = p.cat_id --LEFT JOIN to include the categories without posts
  WHERE p.rank<3
ORDER BY 2, 4 DESC, 5
