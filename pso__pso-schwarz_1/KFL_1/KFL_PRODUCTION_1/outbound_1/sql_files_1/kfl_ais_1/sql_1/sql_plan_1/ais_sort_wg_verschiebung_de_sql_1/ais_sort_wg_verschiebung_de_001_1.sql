--[OK] statement is translated correctly (syntax and type checks are fine)

--PE_Review: Columns Not Found in DDL
-- UPDATE DBP_ETL.art_matching_nielsen_per_1 
-- SET kl_owg_id = b.wg_id_neu,
--     kl_uwg_id = b.wug_id_neu

-- FROM (SELECT mandant_id,
--                                                                     art_nielsen_id,
--                                                                     CASE WHEN wg_id  = -1 THEN wg_id_vorschl  ELSE wg_id  END AS wg_id_neu,
--                                                                     CASE WHEN wug_id = -1 THEN wug_id_vorschl ELSE wug_id END AS wug_id_neu
--                                                              FROM DBP_DATA.art_nielsen_wug_zu_pflege_1
--                                                              WHERE mandant_id = 1) b
--  WHERE DBP_ETL.art_matching_nielsen_per.mandant_id = b.mandant_id AND
--       DBP_ETL.art_matching_nielsen_per.art_nielsen_id = b.art_nielsen_id AND
--       DBP_ETL.art_matching_nielsen_per.art_id = -1
-- ;

UPDATE dbp_etl.art_matching_nielsen_per_1 SET
    kl_wg_id = CAST(
        b.owg_id AS INTEGER) FROM (
    SELECT *
    FROM dbp_data.wg_per_1
    WHERE
        dat_bis = PARSE_DATE('%F', '9999-12-31')
        AND owg_id <> -1
) AS b
WHERE art_matching_nielsen_per.mandant_id = b.mandant_id AND art_matching_nielsen_per.kl_owg_id = b.wg_id;


CREATE OR REPLACE TEMPORARY TABLE _upd_stable_xxx AS
SELECT
    mandant_id,
    art_matching_id,
    COUNT(DISTINCT kl_wg_id) AS anz1,
    COUNT(DISTINCT kl_owg_id) AS anz2,
    COUNT(DISTINCT kl_uwg_id) AS anz3
FROM dbp_etl.art_matching_nielsen_per_1
GROUP BY
    mandant_id,
    art_matching_id
HAVING anz1 > 1 OR anz2 > 1 OR anz3 > 1;


UPDATE dbp_etl.art_matching_nielsen_per_1 SET
    kl_owg_id = b.kl_owg_id,
    kl_uwg_id = b.kl_uwg_id FROM (
    SELECT
        A.mandant_id,
        A.art_matching_id,
        MAX(A.kl_owg_id) AS kl_owg_id,
        MIN(A.kl_uwg_id) AS kl_uwg_id
    FROM dbp_etl.art_matching_nielsen_per_1 AS A
    INNER JOIN `_upd_stable_xxx` AS B ON A.mandant_id = B.mandant_id AND A.art_matching_id = B.art_matching_id
    WHERE
        B.anz2 > 1
        OR B.anz3 > 1
    GROUP BY
        A.mandant_id,
        A.art_matching_id
) AS b
WHERE art_matching_nielsen_per.mandant_id = b.mandant_id AND art_matching_nielsen_per.art_matching_id = b.art_matching_id;


UPDATE dbp_etl.art_matching_nielsen_per_1 SET
    kl_wg_id = CAST(
        b.owg_id AS INTEGER) FROM (
    SELECT *
    FROM dbp_data.wg_per_1
    WHERE
        dat_bis = PARSE_DATE('%F', '9999-12-31')
        AND mandant_id = 1
        AND owg_id NOT IN (-1, -3)
) AS b
WHERE art_matching_nielsen_per.mandant_id = b.mandant_id AND art_matching_nielsen_per.kl_owg_id = b.wg_id;
