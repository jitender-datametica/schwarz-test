CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_mcx_invers_bereich_spr_zu_1 AS SELECT invers_ber_id,
 MAX(CASE
   WHEN spr_id = 22
   THEN invers_ber_bez
   ELSE NULL
   END) AS invers_ber_bez,
 MAX(CASE
   WHEN spr_id = 22
   THEN invers_ber_bez_2
   ELSE NULL
   END) AS invers_ber_kbez,
 MAX(CASE
   WHEN spr_id = 124
   THEN invers_ber_bez
   ELSE NULL
   END) AS invers_ber_bez_cz,
 MAX(CASE
   WHEN spr_id = 124
   THEN invers_ber_bez_2
   ELSE NULL
   END) AS invers_ber_kbez_cz,
 MAX(CASE
   WHEN spr_id = 108
   THEN invers_ber_bez
   ELSE NULL
   END) AS invers_ber_bez_sk,
 MAX(CASE
   WHEN spr_id = 108
   THEN invers_ber_bez_2
   ELSE NULL
   END) AS invers_ber_kbez_sk,
 MAX(CASE
   WHEN spr_id = 65
   THEN invers_ber_bez
   ELSE NULL
   END) AS invers_ber_bez_hr,
 MAX(CASE
   WHEN spr_id = 65
   THEN invers_ber_bez_2
   ELSE NULL
   END) AS invers_ber_kbez_hr,
 MAX(CASE
   WHEN spr_id = 90
   THEN invers_ber_bez
   ELSE NULL
   END) AS invers_ber_bez_pl,
 MAX(CASE
   WHEN spr_id = 90
   THEN invers_ber_bez_2
   ELSE NULL
   END) AS invers_ber_kbez_pl,
 MAX(CASE
   WHEN spr_id = 95
   THEN invers_ber_bez
   ELSE NULL
   END) AS invers_ber_bez_ro,
 MAX(CASE
   WHEN spr_id = 95
   THEN invers_ber_bez_2
   ELSE NULL
   END) AS invers_ber_kbez_ro,
 MAX(CASE
   WHEN spr_id = 18
   THEN invers_ber_bez
   ELSE NULL
   END) AS invers_ber_bez_bg,
 MAX(CASE
   WHEN spr_id = 18
   THEN invers_ber_bez_2
   ELSE NULL
   END) AS invers_ber_kbez_bg
FROM kfl_production_dbp_view.v_mcx_invers_bereich_spr_zu_1
GROUP BY invers_ber_id;