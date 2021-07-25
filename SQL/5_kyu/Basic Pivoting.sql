/*
For this challenge you need to PIVOT data. You have two tables, products and details. Your task is to pivot the rows in products to produce a table of products which have rows of their detail. Group and Order by the name of the Product.

Tables and relationship below:

You must use the CROSSTAB statement to create a table that has the schema as below:

CROSSTAB table.
name
good
ok
bad
Compare your table to the expected table to view the expected results.

https://www.codewars.com/kata/58126aa90ea99769e7000119/train/sql
*/
CREATE EXTENSION tablefunc;

-- Create your CROSSTAB statement here

SELECT *
FROM crosstab(
  'select name, detail, count(name)
   from details
    JOIN products ON products.id=details.product_id
   group by name, detail
   order by 1,2')
AS final_output(name text, bad bigint, good bigint, ok bigint)
