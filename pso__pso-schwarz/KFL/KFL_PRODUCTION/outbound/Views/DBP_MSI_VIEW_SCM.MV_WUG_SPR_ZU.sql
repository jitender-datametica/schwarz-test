CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_scm.mv_wug_spr_zu AS SELECT mandant_id,
 arthiertyp_id,
 wg_id,
 wug_id,
 MAX(CASE
   WHEN spr_id = 22
   THEN wug_bez
   ELSE NULL
   END) AS wug_bez,
 MAX(CASE
   WHEN spr_id = 22
   THEN wug_bez
   ELSE NULL
   END) AS wug_bez_de,
 COALESCE(MAX(CASE
    WHEN spr_id = 124
    THEN wug_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN wug_bez
    ELSE NULL
    END)) AS wug_bez_cz,
 COALESCE(MAX(CASE
    WHEN spr_id = 108
    THEN wug_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN wug_bez
    ELSE NULL
    END)) AS wug_bez_sk,
 COALESCE(MAX(CASE
    WHEN spr_id = 65
    THEN wug_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN wug_bez
    ELSE NULL
    END)) AS wug_bez_hr,
 COALESCE(MAX(CASE
    WHEN spr_id = 90
    THEN wug_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN wug_bez
    ELSE NULL
    END)) AS wug_bez_pl,
 COALESCE(MAX(CASE
    WHEN spr_id = 95
    THEN wug_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN wug_bez
    ELSE NULL
    END)) AS wug_bez_ro,
 COALESCE(MAX(CASE
    WHEN spr_id = 18
    THEN wug_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN wug_bez
    ELSE NULL
    END)) AS wug_bez_bg
FROM kfl_production_dbp_view.v_wug_spr_zu AS V01
WHERE arthiertyp_id = 2
GROUP BY mandant_id,
 arthiertyp_id,
 wg_id,
 wug_id;