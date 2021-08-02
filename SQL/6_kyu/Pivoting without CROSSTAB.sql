/*
You need to build a pivot table WITHOUT using CROSSTAB function. Having two tables products and details you need to select a pivot table of products with counts of details occurrences (possible details values are ['good', 'ok', 'bad'].

Results should be ordered by product's name.

Model schema for the kata is:

schema

your query should return table with next columns

name
good
ok
bad

https://www.codewars.com/kata/5982020284a83baf2f00001c
*/

SELECT DISTINCT name,
       (SELECT count(id) from details d2 WHERE p.id=d2.product_id AND detail='good') as good,
       (SELECT count(id) from details d2 WHERE p.id=d2.product_id AND detail='ok') as ok,
       (SELECT count(id) from details d2 WHERE p.id=d2.product_id AND detail='bad') as bad
FROM products p
 JOIN details d ON d.product_id=p.id
ORDER BY name

--ALTERNATIVE
select p.name,
count(d.id) filter (where d.detail ='good') as good,
count(d.id) filter (where d.detail ='ok') as ok,
count(d.id) filter (where d.detail ='bad') as bad
from products as p join details d on p.id = d.product_id
group by p.name
order by p.name
