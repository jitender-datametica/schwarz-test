CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_scm.mv_kreistyp_spr_zu_2 AS SELECT mandant_id,
 kreistyp_id,
 MAX(CASE
   WHEN spr_id = 22
   THEN kreistyp_bez
   ELSE NULL
   END) AS kreistyp_bez,
 MAX(CASE
   WHEN spr_id = 22
   THEN kreistyp_bez
   ELSE NULL
   END) AS kreistyp_bez_de,
 COALESCE(MAX(CASE
    WHEN spr_id = 124
    THEN kreistyp_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN kreistyp_bez
    ELSE NULL
    END)) AS kreistyp_bez_cz,
 COALESCE(MAX(CASE
    WHEN spr_id = 108
    THEN kreistyp_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN kreistyp_bez
    ELSE NULL
    END)) AS kreistyp_bez_sk,
 COALESCE(MAX(CASE
    WHEN spr_id = 65
    THEN kreistyp_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN kreistyp_bez
    ELSE NULL
    END)) AS kreistyp_bez_hr,
 COALESCE(MAX(CASE
    WHEN spr_id = 90
    THEN kreistyp_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN kreistyp_bez
    ELSE NULL
    END)) AS kreistyp_bez_pl,
 COALESCE(MAX(CASE
    WHEN spr_id = 95
    THEN kreistyp_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN kreistyp_bez
    ELSE NULL
    END)) AS kreistyp_bez_ro,
 COALESCE(MAX(CASE
    WHEN spr_id = 18
    THEN kreistyp_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN kreistyp_bez
    ELSE NULL
    END)) AS kreistyp_bez_bg
FROM kfl_production_dbp_view.v_kreistyp_spr_zu_2 AS V01
GROUP BY mandant_id,
 kreistyp_id
UNION ALL
SELECT 1 AS mandant_id,
 '' AS kreistyp_id,
 'leer/empty' AS kreistyp_bez,
 'leer/empty' AS kreistyp_bez_de,
 'leer/empty' AS kreistyp_bez_cz,
 'leer/empty' AS kreistyp_bez_sk,
 'leer/empty' AS kreistyp_bez_hr,
 'leer/empty' AS kreistyp_bez_pl,
 'leer/empty' AS kreistyp_bez_ro,
 'leer/empty' AS kreistyp_bez_bg;