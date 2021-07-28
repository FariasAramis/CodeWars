/*
Of so many worthy elves, who to choose for such a lofty position? After much thought you decide to select candidates by name, which are often closely aligned to an elf's skill and temperament.

Choose those with tegil appearing anywhere in their first name, as they are likely to be good calligraphers, OR those with astar anywhere in their last name, who will be faithful to the role.

Elves table:

firstname
lastname
all names are in lowercase

To aid the scribes, return the firstname and lastname column concatenated, separated by a space, into a single shortlist column, and capitalise the first letter of each name.

https://www.codewars.com/kata/5ad90fb688a0b74111000055

*/
SELECT CONCAT(INITCAP(firstname),' ',INITCAP(lastname)) as shortlist
  FROM Elves
  WHERE firstname LIKE '%tegil%'
  OR lastname LIKE '%astar%'
