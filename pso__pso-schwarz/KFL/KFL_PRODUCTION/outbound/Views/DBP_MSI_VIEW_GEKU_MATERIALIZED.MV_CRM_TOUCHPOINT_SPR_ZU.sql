CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_geku_materialized.mv_crm_touchpoint_spr_zu (touchpoint_id,
touchpoint_bez, touchpoint_bez_cz, touchpoint_bez_pl, touchpoint_bez_sk, touchpoint_bez_hr, touchpoint_bez_ro,
touchpoint_bez_bg) AS SELECT touchpoint_id,
 MAX(CASE
   WHEN spr_id = 22
   THEN touchpoint_bez
   ELSE NULL
   END) AS touchpoint_bez,
 MAX(CASE
   WHEN spr_id = 124
   THEN touchpoint_bez
   ELSE NULL
   END) AS touchpoint_bez_cz,
 MAX(CASE
   WHEN spr_id = 90
   THEN touchpoint_bez
   ELSE NULL
   END) AS touchpoint_bez_pl,
 MAX(CASE
   WHEN spr_id = 108
   THEN touchpoint_bez
   ELSE NULL
   END) AS touchpoint_bez_sk,
 MAX(CASE
   WHEN spr_id = 65
   THEN touchpoint_bez
   ELSE NULL
   END) AS touchpoint_bez_hr,
 MAX(CASE
   WHEN spr_id = 95
   THEN touchpoint_bez
   ELSE NULL
   END) AS touchpoint_bez_ro,
 MAX(CASE
   WHEN spr_id = 18
   THEN touchpoint_bez
   ELSE NULL
   END) AS touchpoint_bez_bg
FROM kfl_production_dbp_view.v_crm_touchpoint_spr_zu AS V01
GROUP BY touchpoint_id;