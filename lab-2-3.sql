-- What was the last team (and year) to play at U.S. Cellular Field?

-- Expected result:
--
-- +------+-------------------+
-- | 2017 | Chicago White Sox |
-- +------+-------------------+

SELECT name, year
FROM teams
WHERE park = 'U.S. Cellular Field'
ORDER BY year DESC
LIMIT 1;