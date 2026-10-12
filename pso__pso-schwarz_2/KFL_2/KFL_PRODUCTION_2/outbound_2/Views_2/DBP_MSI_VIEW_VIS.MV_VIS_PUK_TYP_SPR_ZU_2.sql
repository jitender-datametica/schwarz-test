CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_vis_puk_typ_spr_zu_2 AS SELECT puk_typ_id,
 MAX(CASE
   WHEN spr_id = 22
   THEN puk_typ_bez
   ELSE TRIM(SUBSTR(CAST(puk_typ_id AS STRING), 1, 39))
   END) AS puk_typ_bez,
 COALESCE(MAX(CASE
    WHEN spr_id = 124
    THEN puk_typ_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN puk_typ_bez
    ELSE TRIM(SUBSTR(CAST(puk_typ_id AS STRING), 1, 39))
    END)) AS puk_typ_bez_cz,
 COALESCE(MAX(CASE
    WHEN spr_id = 108
    THEN puk_typ_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN puk_typ_bez
    ELSE TRIM(SUBSTR(CAST(puk_typ_id AS STRING), 1, 39))
    END)) AS puk_typ_bez_sk,
 COALESCE(MAX(CASE
    WHEN spr_id = 65
    THEN puk_typ_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN puk_typ_bez
    ELSE TRIM(SUBSTR(CAST(puk_typ_id AS STRING), 1, 39))
    END)) AS puk_typ_bez_hr,
 COALESCE(MAX(CASE
    WHEN spr_id = 90
    THEN puk_typ_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN puk_typ_bez
    ELSE TRIM(SUBSTR(CAST(puk_typ_id AS STRING), 1, 39))
    END)) AS puk_typ_bez_pl,
 COALESCE(MAX(CASE
    WHEN spr_id = 95
    THEN puk_typ_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN puk_typ_bez
    ELSE TRIM(SUBSTR(CAST(puk_typ_id AS STRING), 1, 39))
    END)) AS puk_typ_bez_ro,
 COALESCE(MAX(CASE
    WHEN spr_id = 18
    THEN puk_typ_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN puk_typ_bez
    ELSE TRIM(SUBSTR(CAST(puk_typ_id AS STRING), 1, 39))
    END)) AS puk_typ_bez_bg,
 MAX(CASE
   WHEN spr_id = 22
   THEN puk_typ_bez
   ELSE TRIM(SUBSTR(CAST(puk_typ_id AS STRING), 1, 39))
   END) AS puk_typ_bez_de
FROM kfl_production_dbp_data.vis_puk_typ_spr_zu_2
GROUP BY puk_typ_id;