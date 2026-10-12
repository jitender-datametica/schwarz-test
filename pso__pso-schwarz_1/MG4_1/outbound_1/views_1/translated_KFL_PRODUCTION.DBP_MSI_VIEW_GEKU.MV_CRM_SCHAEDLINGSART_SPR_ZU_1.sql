-- 17.07.2019 twie: SPEC0059158 Sprachview CRM Schaedlingsart
 -- standard=deutsch

CREATE OR REPLACE VIEW dbp_msi_view_geku.mv_crm_schaedlingsart_spr_zu_1 (crm_schaedlingsart_id, crm_schaedlingsart_bez,
crm_schaedlingsart_bez_cz, crm_schaedlingsart_bez_pl, crm_schaedlingsart_bez_sk, crm_schaedlingsart_bez_hr,
crm_schaedlingsart_bez_ro, crm_schaedlingsart_bez_bg) AS SELECT crm_schaedlingsart_id,
 MAX(CASE
   WHEN spr_id = 22
   THEN crm_schaedlingsart_bez
   ELSE NULL
   END) AS crm_schaedlingsart_bez,
 MAX(CASE
   WHEN spr_id = 124
   THEN crm_schaedlingsart_bez
   ELSE NULL
   END) AS crm_schaedlingsart_bez_cz,
 MAX(CASE
   WHEN spr_id = 90
   THEN crm_schaedlingsart_bez
   ELSE NULL
   END) AS crm_schaedlingsart_bez_pl,
 MAX(CASE
   WHEN spr_id = 108
   THEN crm_schaedlingsart_bez
   ELSE NULL
   END) AS crm_schaedlingsart_bez_sk,
 MAX(CASE
   WHEN spr_id = 65
   THEN crm_schaedlingsart_bez
   ELSE NULL
   END) AS crm_schaedlingsart_bez_hr,
 MAX(CASE
   WHEN spr_id = 95
   THEN crm_schaedlingsart_bez
   ELSE NULL
   END) AS crm_schaedlingsart_bez_ro,
 MAX(CASE
   WHEN spr_id = 18
   THEN crm_schaedlingsart_bez
   ELSE NULL
   END) AS crm_schaedlingsart_bez_bg
FROM kfl_production_dbp_view.v_crm_schaedlingsart_spr_zu_1 AS v01
GROUP BY crm_schaedlingsart_id;