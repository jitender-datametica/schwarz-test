CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_mcx_zeitspanne_spr_zu_2 AS SELECT zeitspanne_id,
 MAX(CASE
   WHEN spr_id = 22
   THEN zeitspanne_bez
   ELSE NULL
   END) AS zeitspanne_bez,
 MAX(CASE
   WHEN spr_id = 124
   THEN zeitspanne_bez
   ELSE NULL
   END) AS zeitspanne_bez_cz,
 MAX(CASE
   WHEN spr_id = 90
   THEN zeitspanne_bez
   ELSE NULL
   END) AS zeitspanne_bez_pl,
 MAX(CASE
   WHEN spr_id = 108
   THEN zeitspanne_bez
   ELSE NULL
   END) AS zeitspanne_bez_sk,
 MAX(CASE
   WHEN spr_id = 65
   THEN zeitspanne_bez
   ELSE NULL
   END) AS zeitspanne_bez_hr,
 MAX(CASE
   WHEN spr_id = 95
   THEN zeitspanne_bez
   ELSE NULL
   END) AS zeitspanne_bez_ro,
 MAX(CASE
   WHEN spr_id = 18
   THEN zeitspanne_bez
   ELSE NULL
   END) AS zeitspanne_bez_bg
FROM kfl_production_dbp_data.mcx_zeitspanne_spr_zu_2
GROUP BY zeitspanne_id;