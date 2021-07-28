/*
You need to create a function that calculates the number of weekdays (Monday through Friday) between two dates inclusively.

The function should be named weekdays accept two arguments of type DATE and return an INTEGER value.

weekdays(DATE, DATE) INTEGER
The order of arguments shouldn't matter. To illustrate both of the following queries

SELECT weekdays('2016-01-01', '2016-01-10');
SELECT weekdays('2016-01-10', '2016-01-01');
should produce the same result

 weekdays
----------
        6
(1 row)


https://www.codewars.com/kata/58241d05e7a162c5b100010f/train/sql
*/
CREATE FUNCTION weekdays(DATE, DATE)
  RETURNS INTEGER AS
  $$
  DECLARE wdays INTEGER;

  BEGIN

      SELECT COUNT(d::date) as d INTO wdays
      FROM generate_series(LEAST($1, $2),GREATEST($1, $2), '1 day'::interval) d
      WHERE EXTRACT('dow' from d) not in (0, 6);

      RETURN @ wdays;
  END;
  $$ LANGUAGE plpgsql;
