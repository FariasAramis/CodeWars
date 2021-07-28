/*
Yes it's Fibonacci yet again ! But this time it's SQL.

You need to create a select statement which will produce first 90 Fibonnacci numbers. The column name is - number

Fibbonaccii sequence is:

 0, 1, 1, 2, 3, 5, 8, 13, ..., 89, 144, 233, 377, ...
where

f(0) = 0
f(1) = 1
...
f(n) = f(n-1) + f(n-2)
*/
WITH RECURSIVE FIBO  AS
(
  SELECT 0::bigint as fn1,
         1::bigint as fn2,
         1::bigint as fn_sum
  UNION ALL

  SELECT FIBO.fn2, FIBO.fn_sum, FIBO.fn2+FIBO.fn_sum
  FROM FIBO
)

SELECT fn1 as number
FROM FIBO
LIMIT 90
