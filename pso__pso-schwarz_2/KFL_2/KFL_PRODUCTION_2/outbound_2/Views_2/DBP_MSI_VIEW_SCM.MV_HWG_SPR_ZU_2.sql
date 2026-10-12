CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_scm.mv_hwg_spr_zu_2 AS SELECT arthiertyp_id,
 hwg_id,
 MAX(CASE
   WHEN spr_id = 22
   THEN hwg_bez
   ELSE NULL
   END) AS hwg_bez,
 MAX(CASE
   WHEN spr_id = 22
   THEN hwg_bez
   ELSE NULL
   END) AS hwg_bez_de,
 COALESCE(MAX(CASE
    WHEN spr_id = 124
    THEN hwg_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN hwg_bez
    ELSE NULL
    END)) AS hwg_bez_cz,
 COALESCE(MAX(CASE
    WHEN spr_id = 108
    THEN hwg_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN hwg_bez
    ELSE NULL
    END)) AS hwg_bez_sk,
 COALESCE(MAX(CASE
    WHEN spr_id = 65
    THEN hwg_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN hwg_bez
    ELSE NULL
    END)) AS hwg_bez_hr,
 COALESCE(MAX(CASE
    WHEN spr_id = 90
    THEN hwg_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN hwg_bez
    ELSE NULL
    END)) AS hwg_bez_pl,
 COALESCE(MAX(CASE
    WHEN spr_id = 95
    THEN hwg_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN hwg_bez
    ELSE NULL
    END)) AS hwg_bez_ro,
 COALESCE(MAX(CASE
    WHEN spr_id = 18
    THEN hwg_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN hwg_bez
    ELSE NULL
    END)) AS hwg_bez_bg
FROM kfl_production_dbp_view.v_hwg_spr_zu_2 AS V01
WHERE arthiertyp_id = 2
GROUP BY arthiertyp_id,
 hwg_id;