DELETE FROM dbp_data.stueckliste_det_2
WHERE EXISTS (
    SELECT *
    FROM ${TEMP_TABLE}
    WHERE
        stueckliste_det.mandant_id = mandant_id
        AND stueckliste_det.stueckliste_id = stueckliste_id
        AND stueckliste_det.stueckliste_typ_id = stueckliste_typ_id
        AND stueckliste_det.stueckliste_pos_id = stueckliste_pos_id
        AND stueckliste_det.dat_von >= dat_von
);


INSERT INTO dbp_data.stueckliste_det_2 (
    art_id, mandant_id, stueckliste_id, stueckliste_pos_id, dat_von,
    dat_bis, stueckliste_typ_id, komponentenmenge, komponentenmenge_einh_id, td_update, td_insert
)
(SELECT
    art_id,
    mandant_id,
    stueckliste_id,
    stueckliste_pos_id,
    dat_von,
    dat_bis,
    stueckliste_typ_id,
    komponentenmenge,
    komponentenmenge_einh_id,
    CURRENT_TIMESTAMP(),
    CURRENT_TIMESTAMP()
FROM ${TEMP_TABLE});


UPDATE dbp_data.stueckliste_det_2 AS stueckliste_det0 SET
    dat_bis = dt1.dat_bis FROM (SELECT
    mandant_id,
    stueckliste_id,
    stueckliste_pos_id,
    stueckliste_typ_id,
    dat_von,
    CASE
        WHEN (SUM(ROUND(CAST(
            FORMAT_DATE('%Y%m%d', dat_von) AS BIGNUMERIC), 0)) OVER (PARTITION BY
            mandant_id,
            stueckliste_id, stueckliste_pos_id, stueckliste_typ_id
        ORDER BY dat_von IS NULL, dat_von
        ROWS BETWEEN 1
        PRECEDING AND CURRENT ROW)) - ROUND(CAST(FORMAT_DATE('%Y%m%d', dat_von) AS BIGNUMERIC), 0) = 0
            THEN PARSE_DATE('%F', '9999-12-31')
        ELSE DATE_ADD(DATE(CAST((SUM(ROUND(CAST(FORMAT_DATE('%Y%m%d', dat_von) AS BIGNUMERIC), 0)) OVER (PARTITION BY
            mandant_id, stueckliste_id, stueckliste_pos_id, stueckliste_typ_id
        ORDER BY dat_von IS NULL, dat_von
        ROWS BETWEEN 1 PRECEDING AND CURRENT ROW)) - ROUND(CAST(FORMAT_DATE('%Y%m%d', dat_von) AS BIGNUMERIC), 0) AS
        STRING)), INTERVAL -1 DAY)
    END AS dat_bis
FROM dbp_data.stueckliste_det_2
WHERE (mandant_id, stueckliste_id, stueckliste_pos_id, stueckliste_typ_id) IN (SELECT (
    mandant_id, stueckliste_id,
    stueckliste_pos_id, stueckliste_typ_id
)
FROM ${TEMP_TABLE})) AS dt1
WHERE
    stueckliste_det0.mandant_id = dt1.mandant_id AND stueckliste_det0.stueckliste_id = dt1.stueckliste_id AND
    stueckliste_det0.stueckliste_pos_id = dt1.stueckliste_pos_id AND stueckliste_det0.stueckliste_typ_id = dt1.stueckliste_typ_id
    AND stueckliste_det0.dat_von = dt1.dat_von AND stueckliste_det0.dat_bis <> dt1.dat_bis;


UPDATE dbp_data.stueckliste_det_2 SET
    dat_bis = DATE_SUB(CURRENT_DATE("Europe/Berlin"), INTERVAL 1 DAY)
WHERE dat_bis > DATE_SUB(
    CURRENT_DATE("Europe/Berlin"), INTERVAL 1 DAY) AND mandant_id IN (SELECT mandant_id
FROM ${TEMP_TABLE}) AND (mandant_id, stueckliste_id,
stueckliste_pos_id, stueckliste_typ_id) NOT IN (
    SELECT (
        mandant_id, stueckliste_id, stueckliste_pos_id,
        stueckliste_typ_id
    )
    FROM ${TEMP_TABLE}
);


-- Duplication for MD


CREATE OR REPLACE TEMPORARY TABLE _missings_md_det AS
SELECT
    4 AS mandant_id,
    stueckliste_id,
    stueckliste_pos_id,
    dat_von,
    dat_bis,
    art_id,
    stueckliste_typ_id,
    komponentenmenge,
    komponentenmenge_einh_id,
    td_update,
    td_insert
FROM dbp_data.stueckliste_det_2
WHERE (
    stueckliste_id, stueckliste_pos_id, dat_von) IN (
    SELECT (stueckliste_id, stueckliste_pos_id, dat_von)
    FROM dbp_data.stueckliste_det_2
    WHERE mandant_id IN (4, 7)
    GROUP BY
        stueckliste_id,
        stueckliste_pos_id,
        dat_von
    HAVING COUNT(*) = 1
)
AND mandant_id = 7;


INSERT INTO dbp_data.stueckliste_det_2 (
    art_id, mandant_id, stueckliste_id, stueckliste_pos_id, dat_von,
    dat_bis, stueckliste_typ_id, komponentenmenge, komponentenmenge_einh_id, td_update, td_insert
)
(SELECT
    art_id,
    mandant_id,
    stueckliste_id,
    stueckliste_pos_id,
    dat_von,
    dat_bis,
    stueckliste_typ_id,
    komponentenmenge,
    komponentenmenge_einh_id,
    td_update,
    td_insert
FROM `_missings_md_det`);
