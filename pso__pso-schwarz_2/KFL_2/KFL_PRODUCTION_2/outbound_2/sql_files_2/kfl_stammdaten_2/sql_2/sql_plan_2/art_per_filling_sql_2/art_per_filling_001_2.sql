CREATE TEMPORARY TABLE IF NOT EXISTS _art_per_tmp AS
SELECT
    art_id,
    mandant_id,
    CURRENT_DATE("Europe/Berlin") AS dat_von,
    '9999-12-31' AS dat_bis,
    mutter_wb_id,
    posten_id,
    ipn_id,
    mwst_id,
    oug_id,
    CURRENT_TIMESTAMP() AS td_insert,
    CURRENT_TIMESTAMP() AS td_update
FROM dbp_data.art_2
WHERE
    CURRENT_DATE("Europe/Berlin") > (
        SELECT MAX(dat_von)
        FROM dbp_data.art_per_2
    )
GROUP BY
    art_id,
    mandant_id,
    dat_von,
    dat_bis,
    mutter_wb_id,
    posten_id,
    ipn_id,
    mwst_id,
    oug_id;


CREATE TEMPORARY TABLE IF NOT EXISTS _art_per_new AS
SELECT
    B.art_id,
    B.mandant_id,
    B.dat_von,
    B.dat_bis,
    B.mutter_wb_id,
    B.posten_id,
    B.ipn_id,
    B.mwst_id,
    B.oug_id,
    B.td_insert,
    B.td_update
FROM dbp_data.art_per_2 AS A
INNER JOIN `_art_per_tmp` AS B
    ON A.mandant_id = B.mandant_id AND A.art_id = B.art_id AND A.dat_bis = PARSE_DATE(
        '%F',
        '9999-12-31'
    )
WHERE
    COALESCE(A.mutter_wb_id, -999) <> COALESCE(B.mutter_wb_id, -999)
    OR A.posten_id <> B.posten_id
    OR A.oug_id <> B.oug_id
    OR A.mwst_id <> B.mwst_id
    OR COALESCE(A.ipn_id, -999) <> COALESCE(B.ipn_id, -999);


INSERT INTO `_art_per_new`
(
    SELECT *
    FROM `_art_per_tmp`
    WHERE (
        art_id, mandant_id) NOT IN (
        SELECT (art_id, mandant_id)
        FROM dbp_data.art_per_2
    )
);


INSERT INTO dbp_data.art_per_2 (
    art_id, mandant_id, dat_von, dat_bis, mutter_wb_id, posten_id, ipn_id,
    mwst_id, oug_id, td_update, td_insert
)
(SELECT
    art_id AS art_id,
    mandant_id AS mandant_id,
    dat_von,
    DATE(dat_bis) AS dat_bis,
    mutter_wb_id AS mutter_wb_id,
    posten_id,
    ipn_id,
    mwst_id AS mwst_id,
    oug_id AS oug_id,
    td_update,
    td_insert
FROM `_art_per_new`);


UPDATE dbp_data.art_per_2 AS art_per0 SET
    dat_bis = dt1.dat_bis FROM (SELECT
    mandant_id,
    art_id,
    dat_von,
    COALESCE(LEAD(DATE_SUB(dat_von, INTERVAL 1 DAY)) OVER (
        PARTITION BY
            mandant_id, art_id ORDER BY
            dat_von IS NULL,
            dat_von
    ), PARSE_DATE('%F', '9999-12-31')) AS dat_bis
FROM dbp_data.art_per_2) AS dt1
WHERE
    art_per0.mandant_id = dt1.mandant_id AND art_per0.art_id = dt1.art_id AND art_per0.dat_von = dt1.dat_von AND
    art_per0.dat_bis <> dt1.dat_bis;
