-- ==========================================
-- IPL END TO END ANALYTICS PROJECT
-- Mamidala Bhanu Prasad
-- ==========================================

-- 1. BASIC ANALYSIS

-- 1 Total Matches

SELECT COUNT(*) AS Total_Matches
FROM ipl_matches_data;

-- 2 Total Seasons

SELECT COUNT(DISTINCT season)
FROM ipl_matches_data;

-- 3 Total Teams

SELECT COUNT(*)
FROM teams_data;

-- 4 Total Players

SELECT COUNT(*)
FROM players_data_updated;

-- 5 Matches Per Season

SELECT season,
COUNT(*)
FROM ipl_matches_data
GROUP BY season
ORDER BY season;

-- 6 Most Successful Team

SELECT match_winner,
COUNT(*) wins
FROM ipl_matches_data
GROUP BY match_winner
ORDER BY wins DESC;

-- 7 Toss Winner Advantage

SELECT
ROUND(
COUNT(*)*100/
(SELECT COUNT(*) FROM ipl_matches_data),
2
)
FROM ipl_matches_data
WHERE toss_winner=match_winner;

-- 8 Most Popular Venue

SELECT venue,
COUNT(*)
FROM ipl_matches_data
GROUP BY venue
ORDER BY COUNT(*) DESC;

-- 9 Most Popular City

SELECT city,
COUNT(*)
FROM ipl_matches_data
GROUP BY city
ORDER BY COUNT(*) DESC;

-- 10 Toss Decisions

SELECT toss_decision,
COUNT(*)
FROM ipl_matches_data
GROUP BY toss_decision;

-- 2. BATTING & BOWLING

-- Orange Cap

SELECT batter,
SUM(batter_runs) runs
FROM ball_by_ball_data
GROUP BY batter
ORDER BY runs DESC
LIMIT 10;

-- Purple Cap

SELECT bowler,
COUNT(*) wickets
FROM ball_by_ball_data
WHERE is_wicket='TRUE'
GROUP BY bowler
ORDER BY wickets DESC
LIMIT 10;

-- Most Sixes

SELECT batter,
COUNT(*) sixes
FROM ball_by_ball_data
WHERE batter_runs=6
GROUP BY batter
ORDER BY sixes DESC
LIMIT 10;

-- Most Fours

SELECT batter,
COUNT(*) fours
FROM ball_by_ball_data
WHERE batter_runs=4
GROUP BY batter
ORDER BY fours DESC
LIMIT 10;

-- Balls Faced

SELECT batter,
COUNT(*)
FROM ball_by_ball_data
GROUP BY batter
ORDER BY COUNT(*) DESC;

-- Strike Rate

SELECT batter,
ROUND(
SUM(batter_runs)*100/COUNT(*),
2
)
FROM ball_by_ball_data
GROUP BY batter
HAVING COUNT(*)>500
ORDER BY 2 DESC;

-- Economy Rate

SELECT bowler,
ROUND(
SUM(total_runs)/(COUNT(*)/6),
2
)
FROM ball_by_ball_data
GROUP BY bowler
HAVING COUNT(*)>300
ORDER BY 2;

-- Most Dot Balls

SELECT bowler,
COUNT(*)
FROM ball_by_ball_data
WHERE total_runs=0
GROUP BY bowler
ORDER BY COUNT(*) DESC;

-- Most Wides

SELECT bowler,
SUM(wide_ball_runs)
FROM ball_by_ball_data
GROUP BY bowler
ORDER BY 2 DESC;

-- Most No Balls

SELECT bowler,
SUM(no_ball_runs)
FROM ball_by_ball_data
GROUP BY bowler
ORDER BY 2 DESC;

-- 3. TEAM & MATCH

-- Team Appearances

SELECT team,
COUNT(*)
FROM
(
SELECT team1 team
FROM ipl_matches_data

UNION ALL

SELECT team2
FROM ipl_matches_data
)x
GROUP BY team
ORDER BY COUNT(*) DESC;

-- Team Wins

SELECT match_winner,
COUNT(*)
FROM ipl_matches_data
GROUP BY match_winner
ORDER BY COUNT(*) DESC;

-- Toss Wins

SELECT toss_winner,
COUNT(*)
FROM ipl_matches_data
GROUP BY toss_winner
ORDER BY COUNT(*) DESC;

-- Player of Match

SELECT player_of_match,
COUNT(*)
FROM ipl_matches_data
GROUP BY player_of_match
ORDER BY COUNT(*) DESC;

-- Match Stages

SELECT stage,
COUNT(*)
FROM ipl_matches_data
GROUP BY stage;

-- Match Results

SELECT result,
COUNT(*)
FROM ipl_matches_data
GROUP BY result;

-- Highest Team Score

SELECT match_id,
team_batting,
SUM(total_runs)
FROM ball_by_ball_data
GROUP BY match_id,team_batting
ORDER BY 3 DESC
LIMIT 10;

-- Lowest Team Score

SELECT match_id,
team_batting,
SUM(total_runs)
FROM ball_by_ball_data
GROUP BY match_id,team_batting
ORDER BY 3
LIMIT 10;

-- Total Sixes By Team

SELECT team_batting,
COUNT(*)
FROM ball_by_ball_data
WHERE batter_runs=6
GROUP BY team_batting
ORDER BY COUNT(*) DESC;

-- Total Fours By Team

SELECT team_batting,
COUNT(*)
FROM ball_by_ball_data
WHERE batter_runs=4
GROUP BY team_batting
ORDER BY COUNT(*) DESC;

-- 4. ADVANCED INSIGHTS

-- Left Handed Batters Balls Faced

SELECT batsman_type,
COUNT(*)
FROM ball_by_ball_data
GROUP BY batsman_type;

-- Bowler Types

SELECT bowler_type,
COUNT(*)
FROM ball_by_ball_data
GROUP BY bowler_type;

-- Dismissal Types

SELECT wicket_kind,
COUNT(*)
FROM ball_by_ball_data
GROUP BY wicket_kind
ORDER BY COUNT(*) DESC;

-- Most Fielding Involvements

SELECT fielders_involved,
COUNT(*)
FROM ball_by_ball_data
WHERE fielders_involved<>''
GROUP BY fielders_involved
ORDER BY COUNT(*) DESC
LIMIT 10;

-- Player of Match with Names

SELECT
p.player_name,
COUNT(*) awards
FROM players_data_updated p
JOIN ipl_matches_data m
ON p.player_id=m.player_of_match
GROUP BY p.player_name
ORDER BY awards DESC;
















