CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_sok_verkaufsmoebel_lu (mandant_id, sok_verkaufsmoebel_id,
sok_verkaufsmoebel_bez_de, sok_verkaufsmoebel_bez, sok_verkaufsmoebel_bez_cz, sok_verkaufsmoebel_bez_sk,
sok_verkaufsmoebel_bez_hr, sok_verkaufsmoebel_bez_pl, sok_verkaufsmoebel_bez_ro, sok_verkaufsmoebel_bez_bg) AS SELECT
 mandant_id,
 verkaufsmoebel_id AS sok_verkaufsmoebel_id,
 MAX(CASE
   WHEN spr_id = 22
   THEN verkaufsmoebel_bez
   ELSE TRIM(SUBSTR(CAST(verkaufsmoebel_id AS STRING), 1, 39))
   END) AS sok_verkaufsmoebel_bez_de,
 MAX(CASE
   WHEN spr_id = 22
   THEN verkaufsmoebel_bez
   ELSE TRIM(SUBSTR(CAST(verkaufsmoebel_id AS STRING), 1, 39))
   END) AS sok_verkaufsmoebel_bez,
 COALESCE(MAX(CASE
    WHEN spr_id = 124
    THEN verkaufsmoebel_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN verkaufsmoebel_bez
    ELSE TRIM(SUBSTR(CAST(verkaufsmoebel_id AS STRING), 1, 39))
    END)) AS sok_verkaufsmoebel_bez_cz,
 COALESCE(MAX(CASE
    WHEN spr_id = 108
    THEN verkaufsmoebel_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN verkaufsmoebel_bez
    ELSE TRIM(SUBSTR(CAST(verkaufsmoebel_id AS STRING), 1, 39))
    END)) AS sok_verkaufsmoebel_bez_sk,
 COALESCE(MAX(CASE
    WHEN spr_id = 65
    THEN verkaufsmoebel_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN verkaufsmoebel_bez
    ELSE TRIM(SUBSTR(CAST(verkaufsmoebel_id AS STRING), 1, 39))
    END)) AS sok_verkaufsmoebel_bez_hr,
 COALESCE(MAX(CASE
    WHEN spr_id = 90
    THEN verkaufsmoebel_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN verkaufsmoebel_bez
    ELSE TRIM(SUBSTR(CAST(verkaufsmoebel_id AS STRING), 1, 39))
    END)) AS sok_verkaufsmoebel_bez_pl,
 COALESCE(MAX(CASE
    WHEN spr_id = 95
    THEN verkaufsmoebel_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN verkaufsmoebel_bez
    ELSE TRIM(SUBSTR(CAST(verkaufsmoebel_id AS STRING), 1, 39))
    END)) AS sok_verkaufsmoebel_bez_ro,
 COALESCE(MAX(CASE
    WHEN spr_id = 18
    THEN verkaufsmoebel_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN verkaufsmoebel_bez
    ELSE TRIM(SUBSTR(CAST(verkaufsmoebel_id AS STRING), 1, 39))
    END)) AS sok_verkaufsmoebel_bez_bg
FROM kfl_production_dbp_view.v_verkaufsmoebel_spr_zu AS VM
GROUP BY mandant_id,
 sok_verkaufsmoebel_id;