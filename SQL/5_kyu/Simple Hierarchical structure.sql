/*
For this challenge you need to create a RECURSIVE Hierarchical query. You have a table employees of employees, you must order each employee by level. You must use a WITH statement and name it employee_levels after that has been defined you must select from it.

A Level is in correlation what manager managers the employee. e.g. an employee with a manager_id of NULL is at level 1 and then direct employees with the employee at level 1 will be level 2.

employees table schema
id
first_name
last_name
manager_id (can be NULL)
resultant schema
level
id
first_name
last_name
manager_id (can be NULL)

https://www.codewars.com/kata/5812a2a2492760dfca000450

*/

WITH RECURSIVE employee_levels AS
( SELECT E.*, 1 AS level
  FROM employees E
    WHERE manager_id IS NULL
  UNION ALL
    SELECT EE.*, employee_levels.level+1
    FROM employees EE
      JOIN employee_levels ON EE.manager_id= employee_levels.id
)

SELECT *
  FROM employee_levels
