CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ek_kun.mv_crm_brand_spr_zu_1 (crm_brand_id, crm_brand_bez,
crm_brand_bez_cz, crm_brand_bez_pl, crm_brand_bez_sk, crm_brand_bez_hr, crm_brand_bez_ro, crm_brand_bez_bg) AS SELECT
 crm_brand_id,
 MAX(crm_brand_bez) AS crm_brand_bez,
 MAX(CASE
   WHEN spr_id = 124
   THEN crm_brand_bez
   ELSE NULL
   END) AS crm_brand_bez_cz,
 MAX(CASE
   WHEN spr_id = 90
   THEN crm_brand_bez
   ELSE NULL
   END) AS crm_brand_bez_pl,
 MAX(CASE
   WHEN spr_id = 108
   THEN crm_brand_bez
   ELSE NULL
   END) AS crm_brand_bez_sk,
 MAX(CASE
   WHEN spr_id = 65
   THEN crm_brand_bez
   ELSE NULL
   END) AS crm_brand_bez_hr,
 MAX(CASE
   WHEN spr_id = 95
   THEN crm_brand_bez
   ELSE NULL
   END) AS crm_brand_bez_ro,
 MAX(CASE
   WHEN spr_id = 18
   THEN crm_brand_bez
   ELSE NULL
   END) AS crm_brand_bez_bg
FROM kfl_production_dbp_data.crm_brand_spr_zu_1 AS V01
GROUP BY crm_brand_id;