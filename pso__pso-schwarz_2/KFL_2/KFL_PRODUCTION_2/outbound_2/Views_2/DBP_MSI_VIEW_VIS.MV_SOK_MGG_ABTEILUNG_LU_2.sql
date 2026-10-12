CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_sok_mgg_abteilung_lu_2 (mandant_id, sok_mgg_abteilung_id,
sok_food_nonfood_kategorie_id, sok_mgg_abteilung_bez_de, sok_mgg_abteilung_bez, sok_mgg_abteilung_bez_cz,
sok_mgg_abteilung_bez_sk, sok_mgg_abteilung_bez_hr, sok_mgg_abteilung_bez_pl, sok_mgg_abteilung_bez_ro,
sok_mgg_abteilung_bez_bg) AS SELECT ABT.mandant_id,
 ABT.mgg_abteilung_id AS sok_mgg_abteilung_id,
 ABT.food_nonfood_kategorie_id AS sok_food_nonfood_kategorie_id,
 MAX(CASE
   WHEN ABTS.spr_id = 22
   THEN ABTS.mgg_abteilung_bez
   ELSE TRIM(SUBSTR(CAST(ABTS.mgg_abteilung_id AS STRING), 1, 39))
   END) AS sok_mgg_abteilung_bez_de,
 MAX(CASE
   WHEN ABTS.spr_id = 22
   THEN ABTS.mgg_abteilung_bez
   ELSE TRIM(SUBSTR(CAST(ABTS.mgg_abteilung_id AS STRING), 1, 39))
   END) AS sok_mgg_abteilung_bez,
 COALESCE(MAX(CASE
    WHEN ABTS.spr_id = 124
    THEN ABTS.mgg_abteilung_bez
    ELSE NULL
    END), MAX(CASE
    WHEN ABTS.spr_id = 22
    THEN ABTS.mgg_abteilung_bez
    ELSE TRIM(SUBSTR(CAST(ABTS.mgg_abteilung_id AS STRING), 1, 39))
    END)) AS sok_mgg_abteilung_bez_cz,
 COALESCE(MAX(CASE
    WHEN ABTS.spr_id = 108
    THEN ABTS.mgg_abteilung_bez
    ELSE NULL
    END), MAX(CASE
    WHEN ABTS.spr_id = 22
    THEN ABTS.mgg_abteilung_bez
    ELSE TRIM(SUBSTR(CAST(ABTS.mgg_abteilung_id AS STRING), 1, 39))
    END)) AS sok_mgg_abteilung_bez_sk,
 COALESCE(MAX(CASE
    WHEN ABTS.spr_id = 65
    THEN ABTS.mgg_abteilung_bez
    ELSE NULL
    END), MAX(CASE
    WHEN ABTS.spr_id = 22
    THEN ABTS.mgg_abteilung_bez
    ELSE TRIM(SUBSTR(CAST(ABTS.mgg_abteilung_id AS STRING), 1, 39))
    END)) AS sok_mgg_abteilung_bez_hr,
 COALESCE(MAX(CASE
    WHEN ABTS.spr_id = 90
    THEN ABTS.mgg_abteilung_bez
    ELSE NULL
    END), MAX(CASE
    WHEN ABTS.spr_id = 22
    THEN ABTS.mgg_abteilung_bez
    ELSE TRIM(SUBSTR(CAST(ABTS.mgg_abteilung_id AS STRING), 1, 39))
    END)) AS sok_mgg_abteilung_bez_pl,
 COALESCE(MAX(CASE
    WHEN ABTS.spr_id = 95
    THEN ABTS.mgg_abteilung_bez
    ELSE NULL
    END), MAX(CASE
    WHEN ABTS.spr_id = 22
    THEN ABTS.mgg_abteilung_bez
    ELSE TRIM(SUBSTR(CAST(ABTS.mgg_abteilung_id AS STRING), 1, 39))
    END)) AS sok_mgg_abteilung_bez_ro,
 COALESCE(MAX(CASE
    WHEN ABTS.spr_id = 18
    THEN ABTS.mgg_abteilung_bez
    ELSE NULL
    END), MAX(CASE
    WHEN ABTS.spr_id = 22
    THEN ABTS.mgg_abteilung_bez
    ELSE TRIM(SUBSTR(CAST(ABTS.mgg_abteilung_id AS STRING), 1, 39))
    END)) AS sok_mgg_abteilung_bez_bg
FROM kfl_production_dbp_view.v_l_mgg_abteilung_2 AS ABT_2
 INNER JOIN kfl_production_dbp_view.v_mgg_abteilung_spr_zu_2 AS ABTS ON ABT.mandant_id = ABTS.mandant_id AND ABT.mgg_abteilung_id
    = ABTS.mgg_abteilung_id
GROUP BY ABT.mandant_id,
 sok_mgg_abteilung_id,
 sok_food_nonfood_kategorie_id;