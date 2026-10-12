INSERT INTO dbp_data.l_nachhaltigkeitslogo_1 (
    nachhaltigkeitslogo_id, nachhaltigkeitslogo_bez, td_update,
    td_insert
)
(SELECT
    -1,
    CONCAT(LOWER(nachhaltigkeitslogo_bez), '_fg') AS nachhaltigkeitslogo_bez_,
    CURRENT_TIMESTAMP(),
    CURRENT_TIMESTAMP()
FROM (((((((
    SELECT SUBSTR(nachhaltigkeitslogo_bez, 1, 3) AS nachhaltigkeitslogo_bez
    FROM dbp_etl.l_nachhaltigkeitslogo_1
    UNION DISTINCT
    SELECT SUBSTR(nachhaltigkeitslogo_bez, 4, 3) AS nachhaltigkeitslogo_bez
    FROM dbp_etl.l_nachhaltigkeitslogo_1
    WHERE LENGTH(nachhaltigkeitslogo_bez) > 3
)
UNION DISTINCT
SELECT SUBSTR(nachhaltigkeitslogo_bez, 7, 3) AS nachhaltigkeitslogo_bez
FROM dbp_etl.l_nachhaltigkeitslogo_1
WHERE LENGTH(nachhaltigkeitslogo_bez) > 6)
UNION DISTINCT
SELECT SUBSTR(nachhaltigkeitslogo_bez, 10, 3) AS nachhaltigkeitslogo_bez
FROM dbp_etl.l_nachhaltigkeitslogo_1
WHERE LENGTH(nachhaltigkeitslogo_bez) > 9)
UNION DISTINCT
SELECT SUBSTR(nachhaltigkeitslogo_bez, 13, 3) AS nachhaltigkeitslogo_bez
FROM dbp_etl.l_nachhaltigkeitslogo_1
WHERE LENGTH(nachhaltigkeitslogo_bez) > 12)
UNION DISTINCT
SELECT SUBSTR(nachhaltigkeitslogo_bez, 16, 3) AS nachhaltigkeitslogo_bez
FROM dbp_etl.l_nachhaltigkeitslogo_1
WHERE LENGTH(nachhaltigkeitslogo_bez) > 15)
UNION DISTINCT
SELECT SUBSTR(nachhaltigkeitslogo_bez, 19, 3) AS nachhaltigkeitslogo_bez
FROM dbp_etl.l_nachhaltigkeitslogo_1
WHERE LENGTH(nachhaltigkeitslogo_bez) > 18)
UNION DISTINCT
SELECT SUBSTR(nachhaltigkeitslogo_bez, 122, 3) AS nachhaltigkeitslogo_bez
FROM dbp_etl.l_nachhaltigkeitslogo_1
WHERE LENGTH(nachhaltigkeitslogo_bez) > 21
GROUP BY nachhaltigkeitslogo_bez) AS t15
WHERE CONCAT(
    LOWER(nachhaltigkeitslogo_bez), '_fg') NOT IN (
    SELECT nachhaltigkeitslogo_bez
    FROM dbp_data.l_nachhaltigkeitslogo_1
));
