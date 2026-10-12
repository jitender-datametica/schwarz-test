DELETE FROM dbp_data.stueckliste_1
WHERE EXISTS (
    SELECT *
    FROM ${TEMP_TABLE}
    WHERE
        stueckliste.mandant_id = mandant_id
        AND stueckliste.stueckliste_id = stueckliste_id
        AND stueckliste.stueckliste_verwendung_id = stueckliste_verwendung_id
        AND stueckliste.dat_von >= dat_von
);


INSERT INTO dbp_data.stueckliste_1 (
    mandant_id, stueckliste_id, dat_von, dat_bis, art_id,
    stueckliste_verwendung_id, td_update, td_insert
)
(SELECT
    mandant_id,
    stueckliste_id,
    dat_von,
    dat_bis,
    art_id,
    stueckliste_verwendung_id,
    CURRENT_TIMESTAMP(),
    CURRENT_TIMESTAMP()
FROM ${TEMP_TABLE});


UPDATE dbp_data.stueckliste_1 AS stueckliste0 SET
    dat_bis = dt1.dat_bis FROM (SELECT
    mandant_id,
    stueckliste_id,
    stueckliste_verwendung_id,
    dat_von,
    CASE
        WHEN (SUM(ROUND(CAST(
            FORMAT_DATE('%Y%m%d', dat_von) AS BIGNUMERIC), 0)) OVER (PARTITION BY
            mandant_id,
            stueckliste_id, stueckliste_verwendung_id
        ORDER BY dat_von IS NULL, dat_von
        ROWS BETWEEN 1 PRECEDING AND
        CURRENT ROW)) - ROUND(CAST(FORMAT_DATE('%Y%m%d', dat_von) AS BIGNUMERIC), 0) = 0
            THEN PARSE_DATE('%F', '9999-12-31')
        ELSE DATE_ADD(DATE(CAST((SUM(ROUND(CAST(FORMAT_DATE('%Y%m%d', dat_von) AS BIGNUMERIC), 0)) OVER (PARTITION BY
            mandant_id, stueckliste_id, stueckliste_verwendung_id
        ORDER BY dat_von IS NULL, dat_von ROWS BETWEEN 1
        PRECEDING AND CURRENT ROW)) - ROUND(CAST(FORMAT_DATE('%Y%m%d', dat_von) AS BIGNUMERIC), 0) AS STRING)),
        INTERVAL -1 DAY)
    END AS dat_bis
FROM dbp_data.stueckliste_1
WHERE (mandant_id, stueckliste_id, stueckliste_verwendung_id) IN (SELECT (
    mandant_id, stueckliste_id,
    stueckliste_verwendung_id
)
FROM ${TEMP_TABLE})) AS dt1
WHERE
    stueckliste0.mandant_id = dt1.mandant_id AND stueckliste0.stueckliste_id = dt1.stueckliste_id AND stueckliste0.stueckliste_verwendung_id
    = dt1.stueckliste_verwendung_id AND stueckliste0.dat_von = dt1.dat_von AND stueckliste0.dat_bis <> dt1.dat_bis;


UPDATE dbp_data.stueckliste_1 SET
    dat_bis = DATE_SUB(CURRENT_DATE("Europe/Berlin"), INTERVAL 1 DAY)
WHERE dat_bis > DATE_SUB(
    CURRENT_DATE("Europe/Berlin"), INTERVAL 1 DAY) AND mandant_id IN (SELECT mandant_id
FROM ${TEMP_TABLE}) AND (mandant_id, stueckliste_id,
stueckliste_verwendung_id) NOT IN (
    SELECT (mandant_id, stueckliste_id, stueckliste_verwendung_id)
    FROM ${TEMP_TABLE}
);


-- Duplication for MD


CREATE OR REPLACE TEMPORARY TABLE _missings_md AS
SELECT
    4 AS mandant_id,
    stueckliste_id,
    dat_von,
    dat_bis,
    art_id,
    stueckliste_verwendung_id,
    td_insert,
    td_update
FROM dbp_data.stueckliste_1
WHERE stueckliste_id IN (
    SELECT stueckliste_id
    FROM dbp_data.stueckliste_1
    WHERE mandant_id IN (4, 7)
    GROUP BY stueckliste_id
    HAVING COUNT(*) = 1
)
AND mandant_id = 7;


INSERT INTO dbp_data.stueckliste_1 (
    mandant_id, stueckliste_id, dat_von, dat_bis, art_id,
    stueckliste_verwendung_id, td_update, td_insert
)
(SELECT
    mandant_id,
    stueckliste_id,
    dat_von,
    dat_bis,
    art_id,
    stueckliste_verwendung_id,
    td_update,
    td_insert
FROM `_missings_md`);
