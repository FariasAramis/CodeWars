/*
Task
Given the database where all the users' data is stored in one huge XML string, fetch it as separate rows and columns.

Notes
The private field determines whether the user's email address should be publicly visible
If the profile is private, email_address should equal "Hidden"
The users may have multiple email addresses
If no email addresses are provided, email_address should equal "None"
If there're multiple email addresses, the first one should be shown
The date_of_birth is in the yyyy-mm-dd format
The age fields represents the user's age in years
Order the result by the first_name, and last_name columns


https://www.codewars.com/kata/5db039743affec0027375de0

*/
SELECT
       (xpath('/user/first_name/text()',    data2))[1]::text AS first_name, --the convertion (::text) allows ordering
       (xpath('/user/last_name/text()',     data2))[1]::text AS last_name,
       Date_Part('Year',age((xpath('/user/date_of_birth/text()', data2))[1]::text::date))::int AS age,
       CASE WHEN xpath('/user/private/text()', data2)::text LIKE '%true%' THEN 'Hidden'
            WHEN array_length(xpath('/user/email_addresses/address[1]/text()', data2), 1) is null THEN 'None'
            ELSE unnest(xpath('/user/email_addresses/address[1]/text()', data2))::text END as email_address

FROM (select unnest(xpath('/data/user', data)) as data2 from users) t --This preliminar unnesting create a line for each user
ORDER BY 1,2
