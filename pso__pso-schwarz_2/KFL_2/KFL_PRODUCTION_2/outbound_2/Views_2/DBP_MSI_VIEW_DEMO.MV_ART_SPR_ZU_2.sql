CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_demo.mv_art_spr_zu_2 AS SELECT mandant_id,
 art_id,
 MAX(CASE
   WHEN spr_id = 22
   THEN art_bez
   ELSE NULL
   END) AS art_bez,
 MAX(CASE
   WHEN spr_id = 22
   THEN art_bez
   ELSE NULL
   END) AS art_bez_de,
 COALESCE(MAX(CASE
    WHEN spr_id = 124
    THEN art_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN art_bez
    ELSE NULL
    END)) AS art_bez_cz,
 COALESCE(MAX(CASE
    WHEN spr_id = 108
    THEN art_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN art_bez
    ELSE NULL
    END)) AS art_bez_sk,
 COALESCE(MAX(CASE
    WHEN spr_id = 65
    THEN art_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN art_bez
    ELSE NULL
    END)) AS art_bez_hr,
 COALESCE(MAX(CASE
    WHEN spr_id = 90
    THEN art_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN art_bez
    ELSE NULL
    END)) AS art_bez_pl,
 COALESCE(MAX(CASE
    WHEN spr_id = 95
    THEN art_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN art_bez
    ELSE NULL
    END)) AS art_bez_ro,
 COALESCE(MAX(CASE
    WHEN spr_id = 18
    THEN art_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN art_bez
    ELSE NULL
    END)) AS art_bez_bg
FROM kfl_production_dbp_view.v_art_spr_zu_2 AS V01
GROUP BY mandant_id,
 art_id;