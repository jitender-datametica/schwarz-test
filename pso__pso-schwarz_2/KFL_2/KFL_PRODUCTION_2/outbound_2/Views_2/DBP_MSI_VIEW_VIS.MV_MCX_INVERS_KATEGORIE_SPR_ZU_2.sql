CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_mcx_invers_kategorie_spr_zu_2 AS SELECT invers_kat_id,
 MAX(CASE
   WHEN spr_id = 22
   THEN invers_kat_bez
   ELSE NULL
   END) AS invers_kat_bez,
 MAX(CASE
   WHEN spr_id = 22
   THEN invers_kat_bez_2
   ELSE NULL
   END) AS invers_kat_kbez,
 MAX(CASE
   WHEN spr_id = 124
   THEN invers_kat_bez
   ELSE NULL
   END) AS invers_kat_bez_cz,
 MAX(CASE
   WHEN spr_id = 124
   THEN invers_kat_bez_2
   ELSE NULL
   END) AS invers_kat_kbez_cz,
 MAX(CASE
   WHEN spr_id = 108
   THEN invers_kat_bez
   ELSE NULL
   END) AS invers_kat_bez_sk,
 MAX(CASE
   WHEN spr_id = 108
   THEN invers_kat_bez_2
   ELSE NULL
   END) AS invers_kat_kbez_sk,
 MAX(CASE
   WHEN spr_id = 90
   THEN invers_kat_bez
   ELSE NULL
   END) AS invers_kat_bez_pl,
 MAX(CASE
   WHEN spr_id = 90
   THEN invers_kat_bez_2
   ELSE NULL
   END) AS invers_kat_kbez_pl,
 MAX(CASE
   WHEN spr_id = 65
   THEN invers_kat_bez
   ELSE NULL
   END) AS invers_kat_bez_hr,
 MAX(CASE
   WHEN spr_id = 65
   THEN invers_kat_bez_2
   ELSE NULL
   END) AS invers_kat_kbez_hr,
 MAX(CASE
   WHEN spr_id = 95
   THEN invers_kat_bez
   ELSE NULL
   END) AS invers_kat_bez_ro,
 MAX(CASE
   WHEN spr_id = 95
   THEN invers_kat_bez_2
   ELSE NULL
   END) AS invers_kat_kbez_ro,
 MAX(CASE
   WHEN spr_id = 18
   THEN invers_kat_bez
   ELSE NULL
   END) AS invers_kat_bez_bg,
 MAX(CASE
   WHEN spr_id = 18
   THEN invers_kat_bez_2
   ELSE NULL
   END) AS invers_kat_kbez_bg
FROM kfl_production_dbp_view.v_mcx_invers_kategorie_spr_zu_2
GROUP BY invers_kat_id;