/*
Given the following table 'decimals':

decimals table schema
id
number1
number2
Return a table with two columns (abs, log) where the values in abs are the absolute values of number1 and the values in log are values from number2 in logarithm to base 64.

https://www.codewars.com/kata/594a8f2f7ca3c692a4000041
*/
SELECT abs(number1),log(64,number2)::decimal
FROM decimals
