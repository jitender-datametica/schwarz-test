--[OK] statement is translated correctly (syntax and type checks are fine)


SELECT
    mandant_id,
    spr_id
FROM (SELECT
    mandant_id,
    spr_id
FROM dbp_data.mandant_spr_zu
UNION DISTINCT
SELECT
    mandant_id,
    22 AS spr_id
FROM dbp_data.mandant) AS x;
