CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_aktion_wme_ame_status_einholung_spr_zu_2 AS SELECT mandant_id,
 status_einholung_id,
 MAX(CASE
   WHEN spr_id = 22
   THEN status_einholung_bez
   ELSE NULL
   END) AS status_einholung_bez,
 MAX(CASE
   WHEN spr_id = 124
   THEN status_einholung_bez
   ELSE NULL
   END) AS status_einholung_bez_cz,
 MAX(CASE
   WHEN spr_id = 90
   THEN status_einholung_bez
   ELSE NULL
   END) AS status_einholung_bez_pl,
 MAX(CASE
   WHEN spr_id = 108
   THEN status_einholung_bez
   ELSE NULL
   END) AS status_einholung_bez_sk,
 MAX(CASE
   WHEN spr_id = 65
   THEN status_einholung_bez
   ELSE NULL
   END) AS status_einholung_bez_hr,
 MAX(CASE
   WHEN spr_id = 95
   THEN status_einholung_bez
   ELSE NULL
   END) AS status_einholung_bez_ro,
 MAX(CASE
   WHEN spr_id = 18
   THEN status_einholung_bez
   ELSE NULL
   END) AS status_einholung_bez_bg
FROM kfl_production_dbp_data.aktion_wme_ame_status_einholung_spr_zu_2
GROUP BY mandant_id,
 status_einholung_id;