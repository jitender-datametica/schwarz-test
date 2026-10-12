CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_kmr_kategorie_spr_zu (kmr_kategorie_id, kmr_kategorie_bez,
kmr_kategorie_bez_cz, kmr_kategorie_bez_pl, kmr_kategorie_bez_sk, kmr_kategorie_bez_hr, kmr_kategorie_bez_ro,
kmr_kategorie_bez_bg) AS SELECT kmr_kategorie_id,
 MAX(CASE
   WHEN spr_id = 22
   THEN kmr_kategorie_bez
   ELSE NULL
   END) AS kmr_kategorie_bez,
 MAX(CASE
   WHEN spr_id = 124
   THEN kmr_kategorie_bez
   ELSE NULL
   END) AS kmr_kategorie_bez_cz,
 MAX(CASE
   WHEN spr_id = 90
   THEN kmr_kategorie_bez
   ELSE NULL
   END) AS kmr_kategorie_bez_pl,
 MAX(CASE
   WHEN spr_id = 108
   THEN kmr_kategorie_bez
   ELSE NULL
   END) AS kmr_kategorie_bez_sk,
 MAX(CASE
   WHEN spr_id = 65
   THEN kmr_kategorie_bez
   ELSE NULL
   END) AS kmr_kategorie_bez_hr,
 MAX(CASE
   WHEN spr_id = 95
   THEN kmr_kategorie_bez
   ELSE NULL
   END) AS kmr_kategorie_bez_ro,
 MAX(CASE
   WHEN spr_id = 18
   THEN kmr_kategorie_bez
   ELSE NULL
   END) AS kmr_kategorie_bez_bg
FROM kfl_production_dbp_view.v_kmr_kategorie_spr_zu
GROUP BY kmr_kategorie_id;