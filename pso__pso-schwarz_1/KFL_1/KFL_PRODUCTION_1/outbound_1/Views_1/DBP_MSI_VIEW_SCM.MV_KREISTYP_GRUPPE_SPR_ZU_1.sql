CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_scm.mv_kreistyp_gruppe_spr_zu_1 AS SELECT mandant_id,
 kreistyp_gruppe_id,
 MAX(CASE
   WHEN spr_id = 22
   THEN kreistyp_gruppe_bez
   ELSE NULL
   END) AS kreistyp_gruppe_bez,
 MAX(CASE
   WHEN spr_id = 22
   THEN kreistyp_gruppe_bez
   ELSE NULL
   END) AS kreistyp_gruppe_bez_de,
 COALESCE(MAX(CASE
    WHEN spr_id = 124
    THEN kreistyp_gruppe_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN kreistyp_gruppe_bez
    ELSE NULL
    END)) AS kreistyp_gruppe_bez_cz,
 COALESCE(MAX(CASE
    WHEN spr_id = 108
    THEN kreistyp_gruppe_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN kreistyp_gruppe_bez
    ELSE NULL
    END)) AS kreistyp_gruppe_bez_sk,
 COALESCE(MAX(CASE
    WHEN spr_id = 65
    THEN kreistyp_gruppe_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN kreistyp_gruppe_bez
    ELSE NULL
    END)) AS kreistyp_gruppe_bez_hr,
 COALESCE(MAX(CASE
    WHEN spr_id = 90
    THEN kreistyp_gruppe_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN kreistyp_gruppe_bez
    ELSE NULL
    END)) AS kreistyp_gruppe_bez_pl,
 COALESCE(MAX(CASE
    WHEN spr_id = 95
    THEN kreistyp_gruppe_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN kreistyp_gruppe_bez
    ELSE NULL
    END)) AS kreistyp_gruppe_bez_ro,
 COALESCE(MAX(CASE
    WHEN spr_id = 18
    THEN kreistyp_gruppe_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN kreistyp_gruppe_bez
    ELSE NULL
    END)) AS kreistyp_gruppe_bez_bg
FROM kfl_production_dbp_view.v_kreistyp_gruppe_spr_zu_1 AS V01
GROUP BY mandant_id,
 kreistyp_gruppe_id
UNION ALL
SELECT mandant_id,
 '' AS kreistyp_id,
 'leer/empty' AS kreistyp_gruppe_bez,
 'leer/empty' AS kreistyp_gruppe_bez_de,
 'leer/empty' AS kreistyp_gruppe_bez_cz,
 'leer/empty' AS kreistyp_gruppe_bez_sk,
 'leer/empty' AS kreistyp_gruppe_bez_hr,
 'leer/empty' AS kreistyp_gruppe_bez_pl,
 'leer/empty' AS kreistyp_gruppe_bez_ro,
 'leer/empty' AS kreistyp_gruppe_bez_bg
FROM kfl_production_dbp_view.v_mandant_1 AS V02
WHERE mandant_id NOT IN (SELECT mandant_id
   FROM kfl_production_dbp_view.v_l_kreistyp_gruppe_1
   WHERE kreistyp_gruppe_id = '');