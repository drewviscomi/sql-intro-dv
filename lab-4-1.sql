-- How many lifetime hits does Barry Bonds have?

-- Expected result:
-- 2935
SELECT first_name, last_name, SUM(hits) as lifetime_hits
FROM players
JOIN stats ON players.id = stats.player_id
WHERE first_name = 'Barry' AND last_name = 'Bonds'
GROUP BY players.id;

