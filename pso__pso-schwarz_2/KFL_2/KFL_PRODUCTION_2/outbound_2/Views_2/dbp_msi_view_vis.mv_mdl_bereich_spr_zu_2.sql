CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_mdl_bereich_spr_zu_2 AS SELECT bereich_id,
 MAX(CASE
   WHEN spr_id = 22
   THEN bereich_bez
   ELSE SUBSTR(CAST(bereich_id AS STRING), 1, 80)
   END) AS bereich_bez_de,
 MAX(CASE
   WHEN spr_id = 22
   THEN bereich_bez
   ELSE SUBSTR(CAST(bereich_id AS STRING), 1, 80)
   END) AS bereich_bez,
 COALESCE(MAX(CASE
    WHEN spr_id = 124
    THEN bereich_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN bereich_bez
    ELSE SUBSTR(CAST(bereich_id AS STRING), 1, 80)
    END)) AS bereich_bez_cz,
 COALESCE(MAX(CASE
    WHEN spr_id = 90
    THEN bereich_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN bereich_bez
    ELSE SUBSTR(CAST(bereich_id AS STRING), 1, 80)
    END)) AS bereich_bez_pl,
 COALESCE(MAX(CASE
    WHEN spr_id = 108
    THEN bereich_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN bereich_bez
    ELSE SUBSTR(CAST(bereich_id AS STRING), 1, 80)
    END)) AS bereich_bez_sk,
 COALESCE(MAX(CASE
    WHEN spr_id = 65
    THEN bereich_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN bereich_bez
    ELSE SUBSTR(CAST(bereich_id AS STRING), 1, 80)
    END)) AS bereich_bez_hr,
 COALESCE(MAX(CASE
    WHEN spr_id = 95
    THEN bereich_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN bereich_bez
    ELSE SUBSTR(CAST(bereich_id AS STRING), 1, 80)
    END)) AS bereich_bez_ro,
 COALESCE(MAX(CASE
    WHEN spr_id = 18
    THEN bereich_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN bereich_bez
    ELSE SUBSTR(CAST(bereich_id AS STRING), 1, 80)
    END)) AS bereich_bez_bg
FROM kfl_production_dbp_view.v_mdl_vis_bereich_spr_zu_2 AS V01
GROUP BY bereich_id;