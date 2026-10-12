CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_geku.mv_art_spr_zu_1 (art_id, mandant_id, art_bez, art_bez_cz,
art_bez_pl, art_bez_sk, art_bez_hr, art_bez_ro, art_bez_bg) AS SELECT art_id,
 mandant_id,
 MAX(CASE
   WHEN spr_id = 22 AND art_id <> 0
   THEN art_bez
   ELSE NULL
   END) AS art_bez,
 MAX(CASE
   WHEN spr_id = 124 AND art_id <> 0
   THEN art_bez
   ELSE NULL
   END) AS art_bez_cz,
 MAX(CASE
   WHEN spr_id = 90 AND art_id <> 0
   THEN art_bez
   ELSE NULL
   END) AS art_bez_pl,
 MAX(CASE
   WHEN spr_id = 108 AND art_id <> 0
   THEN art_bez
   ELSE NULL
   END) AS art_bez_sk,
 MAX(CASE
   WHEN spr_id = 65 AND art_id <> 0
   THEN art_bez
   ELSE NULL
   END) AS art_bez_hr,
 MAX(CASE
   WHEN spr_id = 95 AND art_id <> 0
   THEN art_bez
   ELSE NULL
   END) AS art_bez_ro,
 MAX(CASE
   WHEN spr_id = 18 AND art_id <> 0
   THEN art_bez
   ELSE NULL
   END) AS art_bez_bg
FROM kfl_production_dbp_view.v_art_spr_zu_1 AS V01
GROUP BY art_id,
 mandant_id;