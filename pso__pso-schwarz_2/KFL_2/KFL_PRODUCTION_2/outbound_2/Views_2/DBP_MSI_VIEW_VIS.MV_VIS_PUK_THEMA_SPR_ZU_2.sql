CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_vis_puk_thema_spr_zu_2 AS SELECT thema_id,
 MAX(CASE
   WHEN spr_id = 22
   THEN thema_bez
   ELSE TRIM(SUBSTR(CAST(thema_id AS STRING), 1, 39))
   END) AS thema_bez,
 COALESCE(MAX(CASE
    WHEN spr_id = 124
    THEN thema_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN thema_bez
    ELSE TRIM(SUBSTR(CAST(thema_id AS STRING), 1, 39))
    END)) AS thema_bez_cz,
 COALESCE(MAX(CASE
    WHEN spr_id = 108
    THEN thema_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN thema_bez
    ELSE TRIM(SUBSTR(CAST(thema_id AS STRING), 1, 39))
    END)) AS thema_bez_sk,
 COALESCE(MAX(CASE
    WHEN spr_id = 65
    THEN thema_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN thema_bez
    ELSE TRIM(SUBSTR(CAST(thema_id AS STRING), 1, 39))
    END)) AS thema_bez_hr,
 COALESCE(MAX(CASE
    WHEN spr_id = 90
    THEN thema_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN thema_bez
    ELSE TRIM(SUBSTR(CAST(thema_id AS STRING), 1, 39))
    END)) AS thema_bez_pl,
 COALESCE(MAX(CASE
    WHEN spr_id = 95
    THEN thema_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN thema_bez
    ELSE TRIM(SUBSTR(CAST(thema_id AS STRING), 1, 39))
    END)) AS thema_bez_ro,
 COALESCE(MAX(CASE
    WHEN spr_id = 18
    THEN thema_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN thema_bez
    ELSE TRIM(SUBSTR(CAST(thema_id AS STRING), 1, 39))
    END)) AS thema_bez_bg,
 MAX(CASE
   WHEN spr_id = 22
   THEN thema_bez
   ELSE TRIM(SUBSTR(CAST(thema_id AS STRING), 1, 39))
   END) AS thema_bez_de
FROM kfl_production_dbp_data.vis_puk_thema_spr_zu_2
GROUP BY thema_id;