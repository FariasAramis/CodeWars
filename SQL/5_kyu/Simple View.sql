/*
For this challenge you need to create a VIEW. This VIEW is used by a sales store to give out vouches to members who have spent over $1000 in departments that have brought in more than $10000 total ordered by the members id. The VIEW must be called members_approved_for_voucher then you must create a SELECT query using the view.

Tables and relationship below:

resultant table schema
id
name
email
total_spending

https://www.codewars.com/kata/5811527d9d278b242f000006

*/

CREATE VIEW members_approved_for_voucher AS
SELECT m.id, m.name, email, SUM(p.price) as total_spending
FROM members m
  JOIN sales s ON (s.member_id=m.id)
  JOIN products p ON (s.product_id=p.id)
WHERE department_id IN (
                        SELECT department_id
                        FROM sales s
                          JOIN products p ON (s.product_id=p.id)
                        GROUP BY department_id
                        HAVING SUM(p.price)>10000
                       )
GROUP BY m.id, m.name, email
HAVING SUM(p.price)>1000
ORDER BY  m.id;

SELECT * FROM members_approved_for_voucher
