CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ek_kun.mv_crm_gutschein_grund_spr_zu_2 (crm_gutschein_grund_id,
crm_gutschein_grund_bez, crm_gutschein_grund_bez_cz, crm_gutschein_grund_bez_pl, crm_gutschein_grund_bez_sk,
crm_gutschein_grund_bez_hr, crm_gutschein_grund_bez_ro, crm_gutschein_grund_bez_bg) AS SELECT crm_gutschein_grund_id,
 MAX(CASE
   WHEN spr_id = 22
   THEN crm_gutschein_grund_bez
   ELSE NULL
   END) AS crm_gutschein_grund_bez,
 MAX(CASE
   WHEN spr_id = 124
   THEN crm_gutschein_grund_bez
   ELSE NULL
   END) AS crm_gutschein_grund_bez_cz,
 MAX(CASE
   WHEN spr_id = 90
   THEN crm_gutschein_grund_bez
   ELSE NULL
   END) AS crm_gutschein_grund_bez_pl,
 MAX(CASE
   WHEN spr_id = 108
   THEN crm_gutschein_grund_bez
   ELSE NULL
   END) AS crm_gutschein_grund_bez_sk,
 MAX(CASE
   WHEN spr_id = 65
   THEN crm_gutschein_grund_bez
   ELSE NULL
   END) AS crm_gutschein_grund_bez_hr,
 MAX(CASE
   WHEN spr_id = 95
   THEN crm_gutschein_grund_bez
   ELSE NULL
   END) AS crm_gutschein_grund_bez_ro,
 MAX(CASE
   WHEN spr_id = 18
   THEN crm_gutschein_grund_bez
   ELSE NULL
   END) AS crm_gutschein_grund_bez_bg
FROM kfl_production_dbp_data.crm_gutschein_grund_spr_zu_2 AS V01
GROUP BY crm_gutschein_grund_id;