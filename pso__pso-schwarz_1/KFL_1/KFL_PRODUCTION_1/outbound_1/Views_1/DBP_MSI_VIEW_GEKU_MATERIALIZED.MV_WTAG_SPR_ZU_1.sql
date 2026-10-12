CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_geku_materialized.mv_wtag_spr_zu_1 (wtag_id, wtag_bez, wtag_bez_cz,
wtag_bez_pl, wtag_bez_sk, wtag_bez_hr, wtag_bez_ro, wtag_bez_bg) AS SELECT wtag_id,
 MAX(CASE
   WHEN spr_id = 22
   THEN wtag_bez
   ELSE NULL
   END) AS wtag_bez,
 MAX(CASE
   WHEN spr_id = 124
   THEN wtag_bez
   ELSE NULL
   END) AS wtag_bez_cz,
 MAX(CASE
   WHEN spr_id = 90
   THEN wtag_bez
   ELSE NULL
   END) AS wtag_bez_pl,
 MAX(CASE
   WHEN spr_id = 108
   THEN wtag_bez
   ELSE NULL
   END) AS wtag_bez_sk,
 MAX(CASE
   WHEN spr_id = 65
   THEN wtag_bez
   ELSE NULL
   END) AS wtag_bez_hr,
 MAX(CASE
   WHEN spr_id = 95
   THEN wtag_bez
   ELSE NULL
   END) AS wtag_bez_ro,
 MAX(CASE
   WHEN spr_id = 18
   THEN wtag_bez
   ELSE NULL
   END) AS wtag_bez_bg
FROM kfl_production_dbp_view.v_wtag_spr_zu_1 AS V01
GROUP BY wtag_id;