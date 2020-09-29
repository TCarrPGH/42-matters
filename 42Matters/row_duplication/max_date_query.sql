---- Write an SQL query which for each app returns one row, i.e. the row with the most recent last_update_date.
SELECT t1.*
FROM myschema.apps t1 LEFT JOIN myschema.apps t2
ON (t1.id = t2.id AND t1.last_updated_date < t2.last_updated_date)
WHERE t2.last_updated_date IS NULL;


--The time complexity for this is not the best as the  O(M log M + N log N).
--because neither of the tables are using indexing, therefore the tables need to be
-- sorted before completing the left JOIN on itself.
--  this table could have used indexing to complete more efficiant joins
-- instead of using a string as the ID.
