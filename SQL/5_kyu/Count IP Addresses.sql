/*
Given a database of first and last IPv4 addresses, calculate the number of addresses between them (including the first one, excluding the last one).

Input
---------------------------------
|     Table    | Column | Type  |
|--------------+--------+-------|
| ip_addresses | id     | int   |
|              | first  | text  |
|              | last   | text  |
---------------------------------
Output
----------------------
|   Column    | Type |
|-------------+------|
| id          | int  |
| ips_between | int  |
----------------------
All inputs will be valid IPv4 addresses in the form of strings. The last address will always be greater than the first one.

https://www.codewars.com/kata/526989a41034285187000de4
*/
SELECT id,
(CAST(split_part(last,'.', 1) as bigint)-CAST(split_part(first,'.', 1) as bigint))*256*256*256+
(CAST(split_part(last,'.', 2) as bigint)-CAST(split_part(first,'.', 2) as bigint))*256*256+
(CAST(split_part(last,'.', 3) as bigint)-CAST(split_part(first,'.', 3) as bigint))*256+
(CAST(split_part(last,'.', 4) as bigint)-CAST(split_part(first,'.', 4) as bigint)) as ips_between
FROM ip_addresses
