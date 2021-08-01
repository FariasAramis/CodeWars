/*
Given a table of random numbers as follows:

** numbers table schema **

id
number1
number2
number3
number4
number5
Your job is to return a table in the following format, where each value is the number of bytes in the string representation of the number.

** output table schema **

octnum1
octnum2
octnum3
octnum4
octnum5

https://www.codewars.com/kata/59491429952ac97ad9000106
*/
SELECT  octet_length(CAST(number1 as text)) as octnum1,
        octet_length(CAST(number2 as text)) as octnum2,
        octet_length(CAST(number3 as text)) as octnum3,
        octet_length(CAST(number4 as text)) as octnum4,
        octet_length(CAST(number5 as text)) as octnum5
FROM numbers
