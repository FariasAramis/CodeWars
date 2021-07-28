/*
Description
Given the schema presented below write a query, which uses a LATERAL join, that returns two most viewed posts for every category.

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

https://www.codewars.com/kata/5820176255c3d23f360000a9/train/sql
*/

SELECT CASE WHEN category_id IS NULL THEN (SELECT id FROM categories WHERE category=c.category) ELSE category_id END,
      category, mv_title as title, mv_views as views, mv_post_id as post_id
FROM categories c
  LEFT JOIN (SELECT *
             FROM posts p
             JOIN LATERAL (SELECT title as mv_title,
                                   views as mv_views,
                                   id as mv_post_id
                            FROM posts
                            WHERE category_id=p.category_id
                            ORDER BY views DESC, id
                            LIMIT 2) Lat on Lat.mv_post_id=p.id) pp on (c.id=pp.category_id)


ORDER BY category, mv_views DESC, mv_post_id

-- Best Practice
SELECT c.id category_id, c.category, p.title, p.views, p.id post_id
FROM categories c
LEFT JOIN LATERAL(
    SELECT title, views, id
    FROM posts
    WHERE category_id = c.id
    ORDER BY views DESC
    LIMIT 2) p ON true
ORDER BY 2, 4 DESC, 5;
