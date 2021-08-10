/*
Description:
Your company has an internal policy to determine your customers' credit limit, but this procedure has been questioned recently by the board as being too conservative.

Your CEO wants to increase the current customer base credit limits in order to upsell a new line of products. In order to do that, the company hired several external consultancies to produce new credit limit estimates.

The problem is that each agency has produced the report in its own format. Some use the format "First-name Last-name" to identify a person, others use the format "Last-name, First-name". There is also no consensus on how to capitalize each word, so some used all uppercase, others used all lowercase, and some used mixed-case.

Internally, the data is structured as follows:

Table: customers
================

id: INT
first_name: TEXT
last_name: TEXT
credit_limit: FLOAT
The data you've received from all agencies was consolidated in the following table:

Table: prospects
================
full_name: TEXT
credit_limit: FLOAT
Keep in mind that the agencies had access only to a partial customer base. There is also the possibility of more than one agency prospecting the same customer, so it's highly likely that there will be duplicates. Finally, they've prospected customers that were not in your customer base as well.

For this task you are interested in the prospected customers that are already in your customer base and the prospected credit limit is higher than your internal estimate. When more than one agency prospected the same customer, chose the highest estimate.

You have to produce a report with the following fields:

first_name
last_name
old_limit [the current credit_limit]
new_limit [the highest credit_limit found]



*/
SELECT c.first_name, c.last_name, credit_limit as old_limit, new_limit
FROM

  (SELECT DISTINCT --Here we separate the full_name in first and last names, as well as select the highest new limit
         CASE WHEN full_name ~ '.+, .+' THEN TRIM(SUBSTRING(full_name,'(.+), .+'))
              ELSE TRIM(SUBSTRING(full_name,'.+ (.+)')) END as last_name,
         CASE WHEN full_name ~ '.+, .+' THEN TRIM(SUBSTRING(full_name,'.+, (.+)'))
              ELSE TRIM(SUBSTRING(full_name,'(.+) .+')) END as first_name,
         MAX(new_limit)  as new_limit
   FROM
        (SELECT --Here we remove the excess names from the list as well as apply a common rule for capitalization
                INITCAP(TRIM(regexp_replace(full_name,'(?i)dr\. |miss |mr\. |ms\. |mrs\. |SR\.|JR\.| MD$| PHD| DDS| DVM| I$| II$| III$| IV$| V$|', '','g'))) as full_name,
                credit_limit as new_limit
         FROM prospects) prospects_step1

   GROUP BY last_name, first_name

  ) clean_prospects

JOIN customers c on INITCAP(c.first_name)=INITCAP(clean_prospects.first_name) AND INITCAP(c.last_name)=INITCAP(clean_prospects.last_name)
WHERE new_limit > credit_limit
ORDER BY first_name, last_name
