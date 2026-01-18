-- Who hit the most home runs in 2019, and what team did they play for?

-- Expected result:
--
-- +---------------+------------+-----------+-----------+
-- | New York Mets | Pete       | Alonso    | 53        |
-- +---------------+------------+-----------+-----------+

SELECT first_name, last_name, name as team, home_runs
FROM players
JOIN stats ON players.id = stats.player_id
JOIN teams ON stats.team_id = teams.id
WHERE year = 2019
ORDER BY home_runs DESC
LIMIT 1;
