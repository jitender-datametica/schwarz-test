CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_geku_materialized.mv_mdl_kategorie_spr_zu_2 (kategorie_id,
kategorie_bez, kategorie_bez_cz, kategorie_bez_pl, kategorie_bez_sk, kategorie_bez_hr, kategorie_bez_ro,
kategorie_bez_bg) AS SELECT kategorie_id,
 MAX(CASE
   WHEN spr_id = 22
   THEN kategorie_bez
   ELSE NULL
   END) AS kategorie_bez,
 MAX(CASE
   WHEN spr_id = 124
   THEN kategorie_bez
   ELSE NULL
   END) AS kategorie_bez_cz,
 MAX(CASE
   WHEN spr_id = 90
   THEN kategorie_bez
   ELSE NULL
   END) AS kategorie_bez_pl,
 MAX(CASE
   WHEN spr_id = 108
   THEN kategorie_bez
   ELSE NULL
   END) AS kategorie_bez_sk,
 MAX(CASE
   WHEN spr_id = 65
   THEN kategorie_bez
   ELSE NULL
   END) AS kategorie_bez_hr,
 MAX(CASE
   WHEN spr_id = 95
   THEN kategorie_bez
   ELSE NULL
   END) AS kategorie_bez_ro,
 MAX(CASE
   WHEN spr_id = 18
   THEN kategorie_bez
   ELSE NULL
   END) AS kategorie_bez_bg
FROM kfl_production_dbp_view.v_mdl_kategorie_spr_zu_2 AS V01
GROUP BY kategorie_id;