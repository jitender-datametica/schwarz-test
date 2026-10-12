CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_warenverlust_inventurart_lu_2 (inventurart_id,
inventurart_bez_de, inventurart_bez, inventurart_bez_cz, inventurart_bez_sk, inventurart_bez_hr, inventurart_bez_pl,
inventurart_bez_ro, inventurart_bez_bg) AS SELECT inventurart_id,
 MAX(CASE
   WHEN spr_id = 22
   THEN inventurart_bez
   ELSE TRIM(SUBSTR(CAST(inventurart_id AS STRING), 1, 39))
   END) AS inventurart_bez_de,
 MAX(CASE
   WHEN spr_id = 22
   THEN inventurart_bez
   ELSE TRIM(SUBSTR(CAST(inventurart_id AS STRING), 1, 39))
   END) AS inventurart_bez,
 COALESCE(MAX(CASE
    WHEN spr_id = 124
    THEN inventurart_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN inventurart_bez
    ELSE TRIM(SUBSTR(CAST(inventurart_id AS STRING), 1, 39))
    END)) AS inventurart_bez_cz,
 COALESCE(MAX(CASE
    WHEN spr_id = 108
    THEN inventurart_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN inventurart_bez
    ELSE TRIM(SUBSTR(CAST(inventurart_id AS STRING), 1, 39))
    END)) AS inventurart_bez_sk,
 COALESCE(MAX(CASE
    WHEN spr_id = 65
    THEN inventurart_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN inventurart_bez
    ELSE TRIM(SUBSTR(CAST(inventurart_id AS STRING), 1, 39))
    END)) AS inventurart_bez_hr,
 COALESCE(MAX(CASE
    WHEN spr_id = 90
    THEN inventurart_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN inventurart_bez
    ELSE TRIM(SUBSTR(CAST(inventurart_id AS STRING), 1, 39))
    END)) AS inventurart_bez_pl,
 COALESCE(MAX(CASE
    WHEN spr_id = 95
    THEN inventurart_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN inventurart_bez
    ELSE TRIM(SUBSTR(CAST(inventurart_id AS STRING), 1, 39))
    END)) AS inventurart_bez_ro,
 COALESCE(MAX(CASE
    WHEN spr_id = 18
    THEN inventurart_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN inventurart_bez
    ELSE TRIM(SUBSTR(CAST(inventurart_id AS STRING), 1, 39))
    END)) AS inventurart_bez_bg
FROM kfl_production_dbp_view.v_inventurart_spr_zu_2 AS INV
GROUP BY inventurart_id;