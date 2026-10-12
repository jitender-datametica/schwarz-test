CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_sb_bt_bereich_spr_zu (beurteilung_bereich_id, mandant_id,
beurteilung_bereich_bez, beurteilung_bereich_bez_de, beurteilung_bereich_bez_cz, beurteilung_bereich_bez_pl,
beurteilung_bereich_bez_sk, beurteilung_bereich_bez_hr, beurteilung_bereich_bez_ro, beurteilung_bereich_bez_bg) AS
SELECT beurteilung_bereich_id,
 mandant_id,
 MAX(CASE
   WHEN spr_id = 22
   THEN beurteilung_bereich_bez
   ELSE NULL
   END) AS beurteilung_bereich_bez,
 MAX(CASE
   WHEN spr_id = 22
   THEN beurteilung_bereich_bez
   ELSE NULL
   END) AS beurteilung_bereich_bez_de,
 MAX(CASE
   WHEN spr_id = 124
   THEN beurteilung_bereich_bez
   ELSE NULL
   END) AS beurteilung_bereich_bez_cz,
 MAX(CASE
   WHEN spr_id = 90
   THEN beurteilung_bereich_bez
   ELSE NULL
   END) AS beurteilung_bereich_bez_pl,
 MAX(CASE
   WHEN spr_id = 108
   THEN beurteilung_bereich_bez
   ELSE NULL
   END) AS beurteilung_bereich_bez_sk,
 MAX(CASE
   WHEN spr_id = 65
   THEN beurteilung_bereich_bez
   ELSE NULL
   END) AS beurteilung_bereich_bez_hr,
 MAX(CASE
   WHEN spr_id = 95
   THEN beurteilung_bereich_bez
   ELSE NULL
   END) AS beurteilung_bereich_bez_ro,
 MAX(CASE
   WHEN spr_id = 18
   THEN beurteilung_bereich_bez
   ELSE NULL
   END) AS beurteilung_bereich_bez_bg
FROM kfl_production_dbp_view.v_sb_beurteil_bereich_spr_zu AS V01
GROUP BY beurteilung_bereich_id,
 mandant_id;