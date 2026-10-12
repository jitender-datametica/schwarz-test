CREATE OR REPLACE TABLE dbp_etl.logo_kurz AS
SELECT *
FROM dbp_etl.logo;


TRUNCATE TABLE dbp_etl.logo_kurz;


INSERT INTO dbp_etl.logo_kurz (kzstg, td_update, td_insert)
(SELECT
    kzstg,
    CURRENT_TIMESTAMP(),
    CURRENT_TIMESTAMP()
FROM (((((((
    SELECT SUBSTR(kzstg, 1, 3) AS kzstg
    FROM dbp_etl.logo
    UNION DISTINCT
    SELECT SUBSTR(kzstg, 4, 3) AS kzstg
    FROM dbp_etl.logo
    WHERE LENGTH(kzstg) > 3
)
UNION DISTINCT
SELECT SUBSTR(kzstg, 7, 3) AS kzstg
FROM dbp_etl.logo
WHERE LENGTH(kzstg) > 6)
UNION DISTINCT
SELECT SUBSTR(kzstg, 10, 3) AS kzstg
FROM dbp_etl.logo
WHERE LENGTH(kzstg) > 9)
UNION DISTINCT
SELECT SUBSTR(kzstg, 13, 3) AS kzstg
FROM dbp_etl.logo
WHERE LENGTH(kzstg) > 12)
UNION DISTINCT
SELECT SUBSTR(kzstg, 16, 3) AS kzstg
FROM dbp_etl.logo
WHERE LENGTH(kzstg) > 15)
UNION DISTINCT
SELECT SUBSTR(kzstg, 19, 3) AS kzstg
FROM dbp_etl.logo
WHERE LENGTH(kzstg) > 18)
UNION DISTINCT
SELECT SUBSTR(kzstg, 22, 3) AS kzstg
FROM dbp_etl.logo
WHERE LENGTH(kzstg) > 21
GROUP BY kzstg) AS t15);


INSERT INTO dbp_data.l_nachhaltigkeitslogo (
    nachhaltigkeitslogo_id, logo_kzstg, nachhaltigkeitslogo_bez
)
(
    SELECT
        -1,
        kzstg,
        'unbekannt'
    FROM dbp_etl.logo_kurz
    WHERE
        kzstg <> ''
        AND kzstg NOT IN (
            SELECT logo_kzstg
            FROM dbp_data.l_nachhaltigkeitslogo
        )
);
