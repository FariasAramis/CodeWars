/*
For this challenge you need to create a simple SELECT statement. Your task is to calculate the MIN, MEDIAN and MAX scores of the students from the results table.

Tables and relationship below:

Resultant table:
min
median
max

https://www.codewars.com/kata/58167fa1f544130dcf000317


*/
SELECT MIN(score),
       percentile_cont(0.5) WITHIN GROUP (ORDER BY score) as median,
       MAX(score)
FROM result
