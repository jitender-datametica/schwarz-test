CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_dienstleister_spr_zu_2 (dienstleister_id, dienstleister_bez,
dienstleister_bez_cz, dienstleister_bez_pl, dienstleister_bez_sk, dienstleister_bez_hr, dienstleister_bez_ro,
dienstleister_bez_bg) AS SELECT dienstleister_id,
 MAX(CASE
   WHEN spr_id = 22
   THEN dienstleister_bez
   ELSE NULL
   END) AS dienstleister_bez,
 MAX(CASE
   WHEN spr_id = 124
   THEN dienstleister_bez
   ELSE NULL
   END) AS dienstleister_bez_cz,
 MAX(CASE
   WHEN spr_id = 90
   THEN dienstleister_bez
   ELSE NULL
   END) AS dienstleister_bez_pl,
 MAX(CASE
   WHEN spr_id = 108
   THEN dienstleister_bez
   ELSE NULL
   END) AS dienstleister_bez_sk,
 MAX(CASE
   WHEN spr_id = 65
   THEN dienstleister_bez
   ELSE NULL
   END) AS dienstleister_bez_hr,
 MAX(CASE
   WHEN spr_id = 95
   THEN dienstleister_bez
   ELSE NULL
   END) AS dienstleister_bez_ro,
 MAX(CASE
   WHEN spr_id = 18
   THEN dienstleister_bez
   ELSE NULL
   END) AS dienstleister_bez_bg
FROM kfl_production_dbp_data.dienstleister_spr_zu_2 AS DL
GROUP BY dienstleister_id;