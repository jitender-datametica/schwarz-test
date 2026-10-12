-- 17.07.2019 twie: SPEC0059158 Sprachview CRM Eingangskanal
 -- standard=deutsch

CREATE OR REPLACE VIEW dbp_msi_view_geku.mv_crm_eingangskanal_spr_zu_2 (crm_eingangskanal_id, crm_eingangskanal_bez,
crm_eingangskanal_bez_cz, crm_eingangskanal_bez_pl, crm_eingangskanal_bez_sk, crm_eingangskanal_bez_hr,
crm_eingangskanal_bez_ro, crm_eingangskanal_bez_bg) AS SELECT crm_eingangskanal_id,
 MAX(CASE
   WHEN spr_id = 22
   THEN crm_eingangskanal_bez
   ELSE NULL
   END) AS crm_eingangskanal_bez,
 MAX(CASE
   WHEN spr_id = 124
   THEN crm_eingangskanal_bez
   ELSE NULL
   END) AS crm_eingangskanal_bez_cz,
 MAX(CASE
   WHEN spr_id = 90
   THEN crm_eingangskanal_bez
   ELSE NULL
   END) AS crm_eingangskanal_bez_pl,
 MAX(CASE
   WHEN spr_id = 108
   THEN crm_eingangskanal_bez
   ELSE NULL
   END) AS crm_eingangskanal_bez_sk,
 MAX(CASE
   WHEN spr_id = 65
   THEN crm_eingangskanal_bez
   ELSE NULL
   END) AS crm_eingangskanal_bez_hr,
 MAX(CASE
   WHEN spr_id = 95
   THEN crm_eingangskanal_bez
   ELSE NULL
   END) AS crm_eingangskanal_bez_ro,
 MAX(CASE
   WHEN spr_id = 18
   THEN crm_eingangskanal_bez
   ELSE NULL
   END) AS crm_eingangskanal_bez_bg
FROM kfl_production_dbp_view.v_crm_eingangskanal_spr_zu_2 AS v01
GROUP BY crm_eingangskanal_id;