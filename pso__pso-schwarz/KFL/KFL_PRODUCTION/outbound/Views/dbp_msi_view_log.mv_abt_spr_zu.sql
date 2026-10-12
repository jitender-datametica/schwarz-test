CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_log.mv_abt_spr_zu AS SELECT arthiertyp_id,
 abt_id,
 MAX(CASE
   WHEN spr_id = 22
   THEN abt_bez
   ELSE NULL
   END) AS abt_bez,
 MAX(CASE
   WHEN spr_id = 22
   THEN abt_bez
   ELSE NULL
   END) AS abt_bez_de,
 COALESCE(MAX(CASE
    WHEN spr_id = 124
    THEN abt_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN abt_bez
    ELSE NULL
    END)) AS abt_bez_cz,
 COALESCE(MAX(CASE
    WHEN spr_id = 108
    THEN abt_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN abt_bez
    ELSE NULL
    END)) AS abt_bez_sk,
 COALESCE(MAX(CASE
    WHEN spr_id = 65
    THEN abt_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN abt_bez
    ELSE NULL
    END)) AS abt_bez_hr,
 COALESCE(MAX(CASE
    WHEN spr_id = 90
    THEN abt_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN abt_bez
    ELSE NULL
    END)) AS abt_bez_pl,
 COALESCE(MAX(CASE
    WHEN spr_id = 95
    THEN abt_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN abt_bez
    ELSE NULL
    END)) AS abt_bez_ro,
 COALESCE(MAX(CASE
    WHEN spr_id = 18
    THEN abt_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN abt_bez
    ELSE NULL
    END)) AS abt_bez_bg
FROM kfl_production_dbp_view.v_abt_spr_zu AS V01
WHERE arthiertyp_id = 2
GROUP BY arthiertyp_id,
 abt_id;