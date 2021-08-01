/*
For this challenge you need to create a SELECT statement that will contain data about departments that had a sale with a price over 98.00 dollars. This SELECT statement will have to use an EXISTS to achieve the task.

departments table schema
id
name
sales table schema
id
department_id (department foreign key)
name
price
card_name
card_number
transaction_date
resultant table schema
id
name

https://www.codewars.com/kata/58113a64e10b53ec36000293

*/
SELECT DISTINCT d.id, d.name
FROM departments d
  JOIN sales s ON d.id=s.department_id
WHERE EXISTS
  (SELECT department_id
   FROM sales s2
   WHERE s.department_id=s2.department_id
   AND price>98.00)
ORDER BY d.id
