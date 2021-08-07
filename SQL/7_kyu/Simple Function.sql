/*
For this challenge you need to create a basic Increment function which Increments on the age field of the peoples table.

The function should be called increment, it needs to take 1 integer and increment that number by 1.

https://www.codewars.com/kata/580fe518cefeff16d00000c0

*/
CREATE FUNCTION increment(integer) RETURNS INTEGER AS
$$
DECLARE number integer;

BEGIN

SELECT $1+1 into number;

RETURN number;
END;
$$ LANGUAGE plpgsql

--ALTERNATIVE

CREATE FUNCTION increment(i integer) RETURNS integer
AS 'select $1 + 1;'
LANGUAGE sql;
