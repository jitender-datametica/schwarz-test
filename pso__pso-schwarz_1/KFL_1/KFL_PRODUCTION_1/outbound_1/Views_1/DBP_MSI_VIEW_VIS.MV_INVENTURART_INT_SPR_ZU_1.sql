CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_inventurart_int_spr_zu_1 AS SELECT inventurart_int_id,
 MAX(CASE
   WHEN spr_id = 22
   THEN inventurart_int_bez
   ELSE NULL
   END) AS inventurart_int_bez,
 MAX(CASE
   WHEN spr_id = 22
   THEN inventurart_int_bez
   ELSE NULL
   END) AS inventurart_int_bez_de,
 MAX(CASE
   WHEN spr_id = 124
   THEN inventurart_int_bez
   ELSE NULL
   END) AS inventurart_int_bez_cz,
 MAX(CASE
   WHEN spr_id = 108
   THEN inventurart_int_bez
   ELSE NULL
   END) AS inventurart_int_bez_sk,
 MAX(CASE
   WHEN spr_id = 65
   THEN inventurart_int_bez
   ELSE NULL
   END) AS inventurart_int_bez_hr,
 MAX(CASE
   WHEN spr_id = 90
   THEN inventurart_int_bez
   ELSE NULL
   END) AS inventurart_int_bez_pl,
 MAX(CASE
   WHEN spr_id = 95
   THEN inventurart_int_bez
   ELSE NULL
   END) AS inventurart_int_bez_ro,
 MAX(CASE
   WHEN spr_id = 18
   THEN inventurart_int_bez
   ELSE NULL
   END) AS inventurart_int_bez_bg
FROM kfl_production_dbp_view.v_inventurart_int_spr_zu_1 AS IAS
GROUP BY inventurart_int_id;