CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_vis_puk_kennzahl_spr_zu_2 AS SELECT KZS.kennzahl_id,
 LKZ.thema_id,
 MAX(CASE
   WHEN KZS.spr_id = 22
   THEN KZS.kennzahl_bez
   ELSE TRIM(SUBSTR(CAST(KZS.kennzahl_id AS STRING), 1, 39))
   END) AS kennzahl_bez_de,
 MAX(CASE
   WHEN KZS.spr_id = 22
   THEN KZS.kennzahl_bez
   ELSE TRIM(SUBSTR(CAST(KZS.kennzahl_id AS STRING), 1, 39))
   END) AS kennzahl_bez,
 COALESCE(MAX(CASE
    WHEN KZS.spr_id = 124
    THEN KZS.kennzahl_bez
    ELSE NULL
    END), MAX(CASE
    WHEN KZS.spr_id = 22
    THEN KZS.kennzahl_bez
    ELSE TRIM(SUBSTR(CAST(KZS.kennzahl_id AS STRING), 1, 39))
    END)) AS kennzahl_bez_cz,
 COALESCE(MAX(CASE
    WHEN KZS.spr_id = 108
    THEN KZS.kennzahl_bez
    ELSE NULL
    END), MAX(CASE
    WHEN KZS.spr_id = 22
    THEN KZS.kennzahl_bez
    ELSE TRIM(SUBSTR(CAST(KZS.kennzahl_id AS STRING), 1, 39))
    END)) AS kennzahl_bez_sk,
 COALESCE(MAX(CASE
    WHEN KZS.spr_id = 65
    THEN KZS.kennzahl_bez
    ELSE NULL
    END), MAX(CASE
    WHEN KZS.spr_id = 22
    THEN KZS.kennzahl_bez
    ELSE TRIM(SUBSTR(CAST(KZS.kennzahl_id AS STRING), 1, 39))
    END)) AS kennzahl_bez_hr,
 COALESCE(MAX(CASE
    WHEN KZS.spr_id = 90
    THEN KZS.kennzahl_bez
    ELSE NULL
    END), MAX(CASE
    WHEN KZS.spr_id = 22
    THEN KZS.kennzahl_bez
    ELSE TRIM(SUBSTR(CAST(KZS.kennzahl_id AS STRING), 1, 39))
    END)) AS kennzahl_bez_pl,
 COALESCE(MAX(CASE
    WHEN KZS.spr_id = 95
    THEN KZS.kennzahl_bez
    ELSE NULL
    END), MAX(CASE
    WHEN KZS.spr_id = 22
    THEN KZS.kennzahl_bez
    ELSE TRIM(SUBSTR(CAST(KZS.kennzahl_id AS STRING), 1, 39))
    END)) AS kennzahl_bez_ro,
 COALESCE(MAX(CASE
    WHEN KZS.spr_id = 18
    THEN KZS.kennzahl_bez
    ELSE NULL
    END), MAX(CASE
    WHEN KZS.spr_id = 22
    THEN KZS.kennzahl_bez
    ELSE TRIM(SUBSTR(CAST(KZS.kennzahl_id AS STRING), 1, 39))
    END)) AS kennzahl_bez_bg
FROM kfl_production_dbp_data.vis_puk_kennzahl_spr_zu_2 AS KZS
 INNER JOIN kfl_production_dbp_data.vis_l_puk_kennzahl_2 AS LKZ ON KZS.kennzahl_id = LKZ.kennzahl_id
GROUP BY KZS.kennzahl_id,
 LKZ.thema_id;