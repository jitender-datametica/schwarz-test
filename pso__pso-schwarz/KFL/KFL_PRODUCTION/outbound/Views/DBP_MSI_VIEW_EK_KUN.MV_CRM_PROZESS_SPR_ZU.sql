CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ek_kun.mv_crm_prozess_spr_zu (crm_prozess_id, prozess_bez,
prozess_bez_cz, prozess_bez_pl, prozess_bez_sk, prozess_bez_hr, prozess_bez_ro, prozess_bez_bg) AS SELECT crm_prozess_id
 ,
 MAX(CASE
   WHEN spr_id = 22
   THEN prozess_bez
   ELSE NULL
   END) AS prozess_bez,
 MAX(CASE
   WHEN spr_id = 124
   THEN prozess_bez
   ELSE NULL
   END) AS prozess_bez_cz,
 MAX(CASE
   WHEN spr_id = 90
   THEN prozess_bez
   ELSE NULL
   END) AS prozess_bez_pl,
 MAX(CASE
   WHEN spr_id = 108
   THEN prozess_bez
   ELSE NULL
   END) AS prozess_bez_sk,
 MAX(CASE
   WHEN spr_id = 65
   THEN prozess_bez
   ELSE NULL
   END) AS prozess_bez_hr,
 MAX(CASE
   WHEN spr_id = 95
   THEN prozess_bez
   ELSE NULL
   END) AS prozess_bez_ro,
 MAX(CASE
   WHEN spr_id = 18
   THEN prozess_bez
   ELSE NULL
   END) AS prozess_bez_bg
FROM kfl_production_dbp_data.crm_prozess_spr_zu AS V01
GROUP BY crm_prozess_id;