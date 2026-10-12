CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_geku.mv_crm_ebene_2_spr_zu_1 AS SELECT ebene_2_id,
 MAX(CASE
   WHEN spr_id = 22
   THEN ebene_2_bez
   ELSE NULL
   END) AS ebene_2_bez,
 MAX(CASE
   WHEN spr_id = 124
   THEN ebene_2_bez
   ELSE NULL
   END) AS ebene_2_bez_cz,
 MAX(CASE
   WHEN spr_id = 90
   THEN ebene_2_bez
   ELSE NULL
   END) AS ebene_2_bez_pl,
 MAX(CASE
   WHEN spr_id = 108
   THEN ebene_2_bez
   ELSE NULL
   END) AS ebene_2_bez_sk,
 MAX(CASE
   WHEN spr_id = 65
   THEN ebene_2_bez
   ELSE NULL
   END) AS ebene_2_bez_hr,
 MAX(CASE
   WHEN spr_id = 95
   THEN ebene_2_bez
   ELSE NULL
   END) AS ebene_2_bez_ro,
 MAX(CASE
   WHEN spr_id = 18
   THEN ebene_2_bez
   ELSE NULL
   END) AS ebene_2_bez_bg
FROM kfl_production_dbp_view.v_crm_themenbaum_lv2_spr_zu_1 AS V01
GROUP BY ebene_2_id;