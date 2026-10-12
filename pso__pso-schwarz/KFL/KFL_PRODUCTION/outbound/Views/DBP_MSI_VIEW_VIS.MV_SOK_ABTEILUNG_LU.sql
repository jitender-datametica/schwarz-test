CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_sok_abteilung_lu (mandant_id, sok_abteilung_id,
sok_food_nonfood_kategorie_id, sok_abteilung_bez_de, sok_abteilung_bez, sok_abteilung_bez_cz, sok_abteilung_bez_sk,
sok_abteilung_bez_hr, sok_abteilung_bez_pl, sok_abteilung_bez_ro, sok_abteilung_bez_bg) AS SELECT ABT.mandant_id,
 ABT.sok_abteilung_id,
 ABT.food_nonfood_kategorie_id AS sok_food_nonfood_kategorie_id,
 MAX(CASE
   WHEN ABTS.spr_id = 22
   THEN ABTS.sok_abteilung_bez
   ELSE TRIM(SUBSTR(CAST(ABTS.sok_abteilung_id AS STRING), 1, 39))
   END) AS sok_abteilung_bez_de,
 MAX(CASE
   WHEN ABTS.spr_id = 22
   THEN ABTS.sok_abteilung_bez
   ELSE TRIM(SUBSTR(CAST(ABTS.sok_abteilung_id AS STRING), 1, 39))
   END) AS sok_abteilung_bez,
 COALESCE(MAX(CASE
    WHEN ABTS.spr_id = 124
    THEN ABTS.sok_abteilung_bez
    ELSE NULL
    END), MAX(CASE
    WHEN ABTS.spr_id = 22
    THEN ABTS.sok_abteilung_bez
    ELSE TRIM(SUBSTR(CAST(ABTS.sok_abteilung_id AS STRING), 1, 39))
    END)) AS sok_abteilung_bez_cz,
 COALESCE(MAX(CASE
    WHEN ABTS.spr_id = 108
    THEN ABTS.sok_abteilung_bez
    ELSE NULL
    END), MAX(CASE
    WHEN ABTS.spr_id = 22
    THEN ABTS.sok_abteilung_bez
    ELSE TRIM(SUBSTR(CAST(ABTS.sok_abteilung_id AS STRING), 1, 39))
    END)) AS sok_abteilung_bez_sk,
 COALESCE(MAX(CASE
    WHEN ABTS.spr_id = 65
    THEN ABTS.sok_abteilung_bez
    ELSE NULL
    END), MAX(CASE
    WHEN ABTS.spr_id = 22
    THEN ABTS.sok_abteilung_bez
    ELSE TRIM(SUBSTR(CAST(ABTS.sok_abteilung_id AS STRING), 1, 39))
    END)) AS sok_abteilung_bez_hr,
 COALESCE(MAX(CASE
    WHEN ABTS.spr_id = 90
    THEN ABTS.sok_abteilung_bez
    ELSE NULL
    END), MAX(CASE
    WHEN ABTS.spr_id = 22
    THEN ABTS.sok_abteilung_bez
    ELSE TRIM(SUBSTR(CAST(ABTS.sok_abteilung_id AS STRING), 1, 39))
    END)) AS sok_abteilung_bez_pl,
 COALESCE(MAX(CASE
    WHEN ABTS.spr_id = 95
    THEN ABTS.sok_abteilung_bez
    ELSE NULL
    END), MAX(CASE
    WHEN ABTS.spr_id = 22
    THEN ABTS.sok_abteilung_bez
    ELSE TRIM(SUBSTR(CAST(ABTS.sok_abteilung_id AS STRING), 1, 39))
    END)) AS sok_abteilung_bez_ro,
 COALESCE(MAX(CASE
    WHEN ABTS.spr_id = 18
    THEN ABTS.sok_abteilung_bez
    ELSE NULL
    END), MAX(CASE
    WHEN ABTS.spr_id = 22
    THEN ABTS.sok_abteilung_bez
    ELSE TRIM(SUBSTR(CAST(ABTS.sok_abteilung_id AS STRING), 1, 39))
    END)) AS sok_abteilung_bez_bg
FROM kfl_production_dbp_view.v_l_sok_abteilung AS ABT
 INNER JOIN kfl_production_dbp_view.v_sok_abteilung_spr_zu AS ABTS ON ABT.mandant_id = ABTS.mandant_id AND ABT.sok_abteilung_id
    = ABTS.sok_abteilung_id
GROUP BY ABT.mandant_id,
 ABT.sok_abteilung_id,
 sok_food_nonfood_kategorie_id;