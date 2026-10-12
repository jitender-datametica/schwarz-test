CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_owg_int_spr_zu_1 AS SELECT arthiertyp_id,
 owg_id,
 MAX(CASE
   WHEN spr_id = 22
   THEN owg_bez
   ELSE TRIM(SUBSTR(CAST(owg_id AS STRING), 1, 39))
   END) AS owg_bez,
 COALESCE(MAX(CASE
    WHEN spr_id = 124
    THEN owg_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN owg_bez
    ELSE TRIM(SUBSTR(CAST(owg_id AS STRING), 1, 39))
    END)) AS owg_bez_cz,
 COALESCE(MAX(CASE
    WHEN spr_id = 108
    THEN owg_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN owg_bez
    ELSE TRIM(SUBSTR(CAST(owg_id AS STRING), 1, 39))
    END)) AS owg_bez_sk,
 COALESCE(MAX(CASE
    WHEN spr_id = 65
    THEN owg_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN owg_bez
    ELSE TRIM(SUBSTR(CAST(owg_id AS STRING), 1, 39))
    END)) AS owg_bez_hr,
 COALESCE(MAX(CASE
    WHEN spr_id = 90
    THEN owg_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN owg_bez
    ELSE TRIM(SUBSTR(CAST(owg_id AS STRING), 1, 39))
    END)) AS owg_bez_pl,
 COALESCE(MAX(CASE
    WHEN spr_id = 95
    THEN owg_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN owg_bez
    ELSE TRIM(SUBSTR(CAST(owg_id AS STRING), 1, 39))
    END)) AS owg_bez_ro,
 COALESCE(MAX(CASE
    WHEN spr_id = 18
    THEN owg_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN owg_bez
    ELSE TRIM(SUBSTR(CAST(owg_id AS STRING), 1, 39))
    END)) AS owg_bez_bg,
 MAX(CASE
   WHEN spr_id = 22
   THEN owg_bez
   ELSE TRIM(SUBSTR(CAST(owg_id AS STRING), 1, 39))
   END) AS owg_bez_de
FROM kfl_production_dbp_view.v_owg_spr_zu_1 AS OWG
WHERE arthiertyp_id = 2
GROUP BY arthiertyp_id,
 owg_id;