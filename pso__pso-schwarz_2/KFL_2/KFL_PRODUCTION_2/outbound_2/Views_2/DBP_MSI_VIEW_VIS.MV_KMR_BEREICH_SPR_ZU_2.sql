CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_kmr_bereich_spr_zu_2 (kmr_bereich_id, kmr_bereich_bez,
kmr_bereich_bez_cz, kmr_bereich_bez_pl, kmr_bereich_bez_sk, kmr_bereich_bez_hr, kmr_bereich_bez_ro, kmr_bereich_bez_bg)
AS SELECT kmr_bereich_id,
 MAX(CASE
   WHEN spr_id = 22
   THEN kmr_bereich_bez
   ELSE NULL
   END) AS kmr_bereich_bez,
 MAX(CASE
   WHEN spr_id = 124
   THEN kmr_bereich_bez
   ELSE NULL
   END) AS kmr_bereich_bez_cz,
 MAX(CASE
   WHEN spr_id = 90
   THEN kmr_bereich_bez
   ELSE NULL
   END) AS kmr_bereich_bez_pl,
 MAX(CASE
   WHEN spr_id = 108
   THEN kmr_bereich_bez
   ELSE NULL
   END) AS kmr_bereich_bez_sk,
 MAX(CASE
   WHEN spr_id = 65
   THEN kmr_bereich_bez
   ELSE NULL
   END) AS kmr_bereich_bez_hr,
 MAX(CASE
   WHEN spr_id = 95
   THEN kmr_bereich_bez
   ELSE NULL
   END) AS kmr_bereich_bez_ro,
 MAX(CASE
   WHEN spr_id = 18
   THEN kmr_bereich_bez
   ELSE NULL
   END) AS kmr_bereich_bez_bg
FROM kfl_production_dbp_view.v_kmr_bereich_spr_zu_2
GROUP BY kmr_bereich_id;