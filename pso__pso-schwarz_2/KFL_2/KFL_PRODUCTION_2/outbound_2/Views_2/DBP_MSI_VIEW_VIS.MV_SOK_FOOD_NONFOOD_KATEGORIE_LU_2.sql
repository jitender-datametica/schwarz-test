CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_sok_food_nonfood_kategorie_lu_2 (mandant_id,
sok_food_nonfood_kategorie_id, sok_food_nonfood_kategorie_bez_de, sok_food_nonfood_kategorie_bez,
sok_food_nonfood_kategorie_bez_cz, sok_food_nonfood_kategorie_bez_sk, sok_food_nonfood_kategorie_bez_hr,
sok_food_nonfood_kategorie_bez_pl, sok_food_nonfood_kategorie_bez_ro, sok_food_nonfood_kategorie_bez_bg) AS SELECT
 mandant_id,
 food_nonfood_kategorie_id AS sok_food_nonfood_kategorie_id,
 MAX(CASE
   WHEN spr_id = 22
   THEN food_nonfood_kategorie_bez
   ELSE TRIM(SUBSTR(CAST(food_nonfood_kategorie_id AS STRING), 1, 39))
   END) AS sok_food_nonfood_kategorie_bez_de,
 MAX(CASE
   WHEN spr_id = 22
   THEN food_nonfood_kategorie_bez
   ELSE TRIM(SUBSTR(CAST(food_nonfood_kategorie_id AS STRING), 1, 39))
   END) AS sok_food_nonfood_kategorie_bez,
 COALESCE(MAX(CASE
    WHEN spr_id = 124
    THEN food_nonfood_kategorie_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN food_nonfood_kategorie_bez
    ELSE TRIM(SUBSTR(CAST(food_nonfood_kategorie_id AS STRING), 1, 39))
    END)) AS sok_food_nonfood_kategorie_bez_cz,
 COALESCE(MAX(CASE
    WHEN spr_id = 108
    THEN food_nonfood_kategorie_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN food_nonfood_kategorie_bez
    ELSE TRIM(SUBSTR(CAST(food_nonfood_kategorie_id AS STRING), 1, 39))
    END)) AS sok_food_nonfood_kategorie_bez_sk,
 COALESCE(MAX(CASE
    WHEN spr_id = 65
    THEN food_nonfood_kategorie_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN food_nonfood_kategorie_bez
    ELSE TRIM(SUBSTR(CAST(food_nonfood_kategorie_id AS STRING), 1, 39))
    END)) AS sok_food_nonfood_kategorie_bez_hr,
 COALESCE(MAX(CASE
    WHEN spr_id = 90
    THEN food_nonfood_kategorie_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN food_nonfood_kategorie_bez
    ELSE TRIM(SUBSTR(CAST(food_nonfood_kategorie_id AS STRING), 1, 39))
    END)) AS sok_food_nonfood_kategorie_bez_pl,
 COALESCE(MAX(CASE
    WHEN spr_id = 95
    THEN food_nonfood_kategorie_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN food_nonfood_kategorie_bez
    ELSE TRIM(SUBSTR(CAST(food_nonfood_kategorie_id AS STRING), 1, 39))
    END)) AS sok_food_nonfood_kategorie_bez_ro,
 COALESCE(MAX(CASE
    WHEN spr_id = 18
    THEN food_nonfood_kategorie_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN food_nonfood_kategorie_bez
    ELSE TRIM(SUBSTR(CAST(food_nonfood_kategorie_id AS STRING), 1, 39))
    END)) AS sok_food_nonfood_kategorie_bez_bg
FROM kfl_production_dbp_view.v_food_nonfood_kategorie_spr_zu_2 AS FNF
GROUP BY mandant_id,
 sok_food_nonfood_kategorie_id;