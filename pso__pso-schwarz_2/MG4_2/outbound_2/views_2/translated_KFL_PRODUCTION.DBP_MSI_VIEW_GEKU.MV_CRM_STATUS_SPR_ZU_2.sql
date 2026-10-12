-- 17.07.2019 twie: SPEC0059158 Sprachview CRM Status_2

CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_geku.mv_crm_status_spr_zu_2 (crm_status_id, crm_status_bez,
crm_status_bez_cz, crm_status_bez_pl, crm_status_bez_sk, crm_status_bez_hr, crm_status_bez_ro, crm_status_bez_bg) AS
-- standard=deutsch
 SELECT crm_status_id,
 MAX(CASE
   WHEN spr_id = 22
   THEN crm_status_bez
   ELSE NULL
   END) AS crm_status_bez,
 MAX(CASE
   WHEN spr_id = 124
   THEN crm_status_bez
   ELSE NULL
   END) AS crm_status_bez_cz,
 MAX(CASE
   WHEN spr_id = 90
   THEN crm_status_bez
   ELSE NULL
   END) AS crm_status_bez_pl,
 MAX(CASE
   WHEN spr_id = 108
   THEN crm_status_bez
   ELSE NULL
   END) AS crm_status_bez_sk,
 MAX(CASE
   WHEN spr_id = 65
   THEN crm_status_bez
   ELSE NULL
   END) AS crm_status_bez_hr,
 MAX(CASE
   WHEN spr_id = 95
   THEN crm_status_bez
   ELSE NULL
   END) AS crm_status_bez_ro,
 MAX(CASE
   WHEN spr_id = 18
   THEN crm_status_bez
   ELSE NULL
   END) AS crm_status_bez_bg
FROM kfl_production_dbp_view.v_crm_status_spr_zu_2 AS v01
GROUP BY crm_status_id;