-- 17.07.2019 twie: SPEC0059158 Sprachview CRM Eigenmarke
 -- standard=deutsch

CREATE OR REPLACE VIEW dbp_msi_view_geku.mv_crm_eigenmarke_spr_zu (crm_eigenmarke_id, crm_eigenmarke_bez,
crm_eigenmarke_bez_cz, crm_eigenmarke_bez_pl, crm_eigenmarke_bez_sk, crm_eigenmarke_bez_hr, crm_eigenmarke_bez_ro,
crm_eigenmarke_bez_bg) AS SELECT crm_eigenmarke_id,
 MAX(CASE
   WHEN spr_id = 22
   THEN crm_eigenmarke_bez
   ELSE NULL
   END) AS crm_eigenmarke_bez,
 MAX(CASE
   WHEN spr_id = 124
   THEN crm_eigenmarke_bez
   ELSE NULL
   END) AS crm_eigenmarke_bez_cz,
 MAX(CASE
   WHEN spr_id = 90
   THEN crm_eigenmarke_bez
   ELSE NULL
   END) AS crm_eigenmarke_bez_pl,
 MAX(CASE
   WHEN spr_id = 108
   THEN crm_eigenmarke_bez
   ELSE NULL
   END) AS crm_eigenmarke_bez_sk,
 MAX(CASE
   WHEN spr_id = 65
   THEN crm_eigenmarke_bez
   ELSE NULL
   END) AS crm_eigenmarke_bez_hr,
 MAX(CASE
   WHEN spr_id = 95
   THEN crm_eigenmarke_bez
   ELSE NULL
   END) AS crm_eigenmarke_bez_ro,
 MAX(CASE
   WHEN spr_id = 18
   THEN crm_eigenmarke_bez
   ELSE NULL
   END) AS crm_eigenmarke_bez_bg
FROM kfl_production_dbp_view.v_crm_eigenmarke_spr_zu AS v01
GROUP BY crm_eigenmarke_id;