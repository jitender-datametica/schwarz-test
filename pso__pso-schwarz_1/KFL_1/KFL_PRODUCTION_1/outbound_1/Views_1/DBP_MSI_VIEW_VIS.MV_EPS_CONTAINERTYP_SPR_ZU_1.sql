CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_eps_containertyp_spr_zu_1 AS SELECT containertyp_id,
 MAX(CASE
   WHEN spr_id = 22
   THEN containertyp_bez
   ELSE NULL
   END) AS containertyp_bez_de,
 MAX(CASE
   WHEN spr_id = 22
   THEN containertyp_bez
   ELSE NULL
   END) AS containertyp_bez,
 COALESCE(MAX(CASE
    WHEN spr_id = 124
    THEN containertyp_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN containertyp_bez
    ELSE NULL
    END)) AS containertyp_bez_cz,
 COALESCE(MAX(CASE
    WHEN spr_id = 108
    THEN containertyp_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN containertyp_bez
    ELSE NULL
    END)) AS containertyp_bez_sk,
 COALESCE(MAX(CASE
    WHEN spr_id = 65
    THEN containertyp_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN containertyp_bez
    ELSE NULL
    END)) AS containertyp_bez_hr,
 COALESCE(MAX(CASE
    WHEN spr_id = 90
    THEN containertyp_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN containertyp_bez
    ELSE NULL
    END)) AS containertyp_bez_pl,
 COALESCE(MAX(CASE
    WHEN spr_id = 95
    THEN containertyp_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN containertyp_bez
    ELSE NULL
    END)) AS containertyp_bez_ro,
 COALESCE(MAX(CASE
    WHEN spr_id = 18
    THEN containertyp_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN containertyp_bez
    ELSE NULL
    END)) AS containertyp_bez_bg
FROM kfl_production_dbp_view.v_eps_containertyp_spr_zu_1
GROUP BY containertyp_id;