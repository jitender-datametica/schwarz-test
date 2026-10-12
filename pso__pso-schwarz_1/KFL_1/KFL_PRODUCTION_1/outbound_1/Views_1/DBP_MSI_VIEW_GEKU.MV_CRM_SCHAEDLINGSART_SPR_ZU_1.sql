CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_geku.mv_crm_schaedlingsart_spr_zu_1 AS SELECT crm_schaedlingsart_id,
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
FROM kfl_production_dbp_view.v_crm_schaedlingsart_spr_zu_1 AS V01
GROUP BY crm_schaedlingsart_id;