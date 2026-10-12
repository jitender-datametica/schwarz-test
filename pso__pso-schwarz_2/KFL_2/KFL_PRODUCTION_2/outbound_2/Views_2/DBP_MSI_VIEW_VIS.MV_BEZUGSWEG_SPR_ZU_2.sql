CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_bezugsweg_spr_zu_2 AS SELECT bezugsweg_id,
 MAX(CASE
   WHEN spr_id = 22
   THEN bezugsweg_bez
   ELSE NULL
   END) AS bezugsweg_bez,
 MAX(CASE
   WHEN spr_id = 22
   THEN bezugsweg_bez
   ELSE NULL
   END) AS bezugsweg_bez_de,
 COALESCE(MAX(CASE
    WHEN spr_id = 124
    THEN bezugsweg_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN bezugsweg_bez
    ELSE NULL
    END)) AS bezugsweg_bez_cz,
 COALESCE(MAX(CASE
    WHEN spr_id = 108
    THEN bezugsweg_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN bezugsweg_bez
    ELSE NULL
    END)) AS bezugsweg_bez_sk,
 COALESCE(MAX(CASE
    WHEN spr_id = 65
    THEN bezugsweg_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN bezugsweg_bez
    ELSE NULL
    END)) AS bezugsweg_bez_hr,
 COALESCE(MAX(CASE
    WHEN spr_id = 90
    THEN bezugsweg_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN bezugsweg_bez
    ELSE NULL
    END)) AS bezugsweg_bez_pl,
 COALESCE(MAX(CASE
    WHEN spr_id = 95
    THEN bezugsweg_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN bezugsweg_bez
    ELSE NULL
    END)) AS bezugsweg_bez_ro,
 COALESCE(MAX(CASE
    WHEN spr_id = 18
    THEN bezugsweg_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN bezugsweg_bez
    ELSE NULL
    END)) AS bezugsweg_bez_bg
FROM kfl_production_dbp_view.v_bezugsweg_spr_zu_2 AS V01
WHERE mandant_id = 1
GROUP BY bezugsweg_id;