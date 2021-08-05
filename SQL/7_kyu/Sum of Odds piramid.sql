/*
Given the triangle of consecutive odd numbers:

             1
          3     5
       7     9    11
   13    15    17    19
21    23    25    27    29
...
Calculate the sum of the numbers in the nth row of this triangle (starting at index 1) e.g.:

rowSumOddNumbers(1); // 1
rowSumOddNumbers(2); // 3 + 5 = 8

the table "nums" contains an integer "n", the number
return your result in a column "res"

*/
CREATE FUNCTION rowSumOddNumbers(INTEGER) RETURNS INTEGER AS
$$
  DECLARE res INTEGER;

  BEGIN
    WITH RECURSIVE odd_piramid AS (
      SELECT 1 as row,
             1 as number,
             1 as row_sum
      UNION ALL
      SELECT row+1 as row,
             number+(row+1)*2 as number,
             (number+(row+1)*2+number+2)/2*(row+1) as row_sum
      FROM odd_piramid
    )

    SELECT row_sum into res
    FROM odd_piramid
    WHERE row=$1;
    RETURN @ res;
  END;
$$ LANGUAGE plpgsql;

SELECT rowSumOddNumbers(n) as res
FROM nums
--ALTERNATIVE
WITH RECURSIVE odd_piramid AS (
  SELECT 1 as row,
         1 as number,
         1 as row_sum
  UNION ALL
  SELECT row+1 as row,
         number+(row+1)*2 as number,
        (number+(row+1)*2+number+2)/2*(row+1) as row_sum
  FROM odd_piramid
)

SELECT row_sum as res
FROM(
      SELECT row, row_sum
      FROM odd_piramid
      LIMIT 1000) odd_sum_table
  JOIN nums on row=n
