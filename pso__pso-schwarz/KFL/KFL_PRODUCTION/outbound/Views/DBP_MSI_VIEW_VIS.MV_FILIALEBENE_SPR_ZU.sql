CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_filialebene_spr_zu AS SELECT filialebene_id,
 MAX(CASE
   WHEN spr_id = 22
   THEN filialebene_bez
   ELSE NULL
   END) AS filialebene_bez,
 MAX(CASE
   WHEN spr_id = 22
   THEN filialebene_bez
   ELSE NULL
   END) AS filialebene_bez_de,
 COALESCE(MAX(CASE
    WHEN spr_id = 124
    THEN filialebene_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN filialebene_bez
    ELSE NULL
    END)) AS filialebene_bez_cz,
 COALESCE(MAX(CASE
    WHEN spr_id = 108
    THEN filialebene_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN filialebene_bez
    ELSE NULL
    END)) AS filialebene_bez_sk,
 COALESCE(MAX(CASE
    WHEN spr_id = 65
    THEN filialebene_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN filialebene_bez
    ELSE NULL
    END)) AS filialebene_bez_hr,
 COALESCE(MAX(CASE
    WHEN spr_id = 90
    THEN filialebene_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN filialebene_bez
    ELSE NULL
    END)) AS filialebene_bez_pl,
 COALESCE(MAX(CASE
    WHEN spr_id = 95
    THEN filialebene_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN filialebene_bez
    ELSE NULL
    END)) AS filialebene_bez_ro,
 COALESCE(MAX(CASE
    WHEN spr_id = 18
    THEN filialebene_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN filialebene_bez
    ELSE NULL
    END)) AS filialebene_bez_bg
FROM kfl_production_dbp_view.v_filialebene_spr_zu
GROUP BY filialebene_id;