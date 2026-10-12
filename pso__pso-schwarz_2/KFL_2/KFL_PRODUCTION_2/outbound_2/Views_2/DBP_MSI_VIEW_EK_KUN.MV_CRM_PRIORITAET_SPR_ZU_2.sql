CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ek_kun.mv_crm_prioritaet_spr_zu_2 (crm_prioritaet_id,
crm_prioritaet_bez, crm_prioritaet_bez_cz, crm_prioritaet_bez_pl, crm_prioritaet_bez_sk, crm_prioritaet_bez_hr,
crm_prioritaet_bez_ro, crm_prioritaet_bez_bg) AS SELECT crm_prioritaet_id,
 MAX(CASE
   WHEN spr_id = 22
   THEN crm_prioritaet_bez
   ELSE NULL
   END) AS crm_prioritaet_bez,
 MAX(CASE
   WHEN spr_id = 124
   THEN crm_prioritaet_bez
   ELSE NULL
   END) AS crm_prioritaet_bez_cz,
 MAX(CASE
   WHEN spr_id = 90
   THEN crm_prioritaet_bez
   ELSE NULL
   END) AS crm_prioritaet_bez_pl,
 MAX(CASE
   WHEN spr_id = 108
   THEN crm_prioritaet_bez
   ELSE NULL
   END) AS crm_prioritaet_bez_sk,
 MAX(CASE
   WHEN spr_id = 65
   THEN crm_prioritaet_bez
   ELSE NULL
   END) AS crm_prioritaet_bez_hr,
 MAX(CASE
   WHEN spr_id = 95
   THEN crm_prioritaet_bez
   ELSE NULL
   END) AS crm_prioritaet_bez_ro,
 MAX(CASE
   WHEN spr_id = 18
   THEN crm_prioritaet_bez
   ELSE NULL
   END) AS crm_prioritaet_bez_bg
FROM kfl_production_dbp_data.crm_prioritaet_spr_zu_2 AS V01
GROUP BY crm_prioritaet_id;