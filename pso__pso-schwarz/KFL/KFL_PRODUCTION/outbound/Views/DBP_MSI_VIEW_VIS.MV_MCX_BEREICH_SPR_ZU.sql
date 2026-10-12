CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_mcx_bereich_spr_zu (ber_id, ber_bez, ber_bez_cz, ber_bez_pl,
ber_bez_sk, ber_bez_hr, ber_bez_ro, ber_bez_bg) AS SELECT ber_id,
 MAX(CASE
   WHEN spr_id = 22
   THEN ber_bez
   ELSE NULL
   END) AS ber_bez,
 MAX(CASE
   WHEN spr_id = 124
   THEN ber_bez
   ELSE NULL
   END) AS ber_bez_cz,
 MAX(CASE
   WHEN spr_id = 90
   THEN ber_bez
   ELSE NULL
   END) AS ber_bez_pl,
 MAX(CASE
   WHEN spr_id = 108
   THEN ber_bez
   ELSE NULL
   END) AS ber_bez_sk,
 MAX(CASE
   WHEN spr_id = 65
   THEN ber_bez
   ELSE NULL
   END) AS ber_bez_hr,
 MAX(CASE
   WHEN spr_id = 95
   THEN ber_bez
   ELSE NULL
   END) AS ber_bez_ro,
 MAX(CASE
   WHEN spr_id = 18
   THEN ber_bez
   ELSE NULL
   END) AS ber_bez_bg
FROM kfl_production_dbp_view.v_mcx_bereich_spr_zu
GROUP BY ber_id;