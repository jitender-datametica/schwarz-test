CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_mdl_kategorie_gruppe_spr_zu_1 AS SELECT kategorie_gruppe_id,
 MAX(CASE
   WHEN spr_id = 22
   THEN kategorie_gruppe_bez
   ELSE NULL
   END) AS kategorie_gruppe_bez,
 MAX(CASE
   WHEN spr_id = 124
   THEN kategorie_gruppe_bez
   ELSE NULL
   END) AS kategorie_gruppe_bez_cz,
 MAX(CASE
   WHEN spr_id = 90
   THEN kategorie_gruppe_bez
   ELSE NULL
   END) AS kategorie_gruppe_bez_pl,
 MAX(CASE
   WHEN spr_id = 108
   THEN kategorie_gruppe_bez
   ELSE NULL
   END) AS kategorie_gruppe_bez_sk,
 MAX(CASE
   WHEN spr_id = 65
   THEN kategorie_gruppe_bez
   ELSE NULL
   END) AS kategorie_gruppe_bez_hr,
 MAX(CASE
   WHEN spr_id = 95
   THEN kategorie_gruppe_bez
   ELSE NULL
   END) AS kategorie_gruppe_bez_ro,
 MAX(CASE
   WHEN spr_id = 18
   THEN kategorie_gruppe_bez
   ELSE NULL
   END) AS kategorie_gruppe_bez_bg
FROM kfl_production_dbp_view.v_mdl_kategorie_gruppe_spr_zu_1
GROUP BY kategorie_gruppe_id;