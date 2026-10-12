CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_geku.mv_mcx_kategorie_spr_zu_2 (kat_id, kat_bez, kat_bez_cz, kat_bez_pl
, kat_bez_sk, kat_bez_hr, kat_bez_ro, kat_bez_bg) AS SELECT kat_id,
 MAX(CASE
   WHEN spr_id = 22
   THEN kat_bez
   ELSE NULL
   END) AS kat_bez,
 MAX(CASE
   WHEN spr_id = 124
   THEN kat_bez
   ELSE NULL
   END) AS kat_bez_cz,
 MAX(CASE
   WHEN spr_id = 90
   THEN kat_bez
   ELSE NULL
   END) AS kat_bez_pl,
 MAX(CASE
   WHEN spr_id = 108
   THEN kat_bez
   ELSE NULL
   END) AS kat_bez_sk,
 MAX(CASE
   WHEN spr_id = 65
   THEN kat_bez
   ELSE NULL
   END) AS kat_bez_hr,
 MAX(CASE
   WHEN spr_id = 95
   THEN kat_bez
   ELSE NULL
   END) AS kat_bez_ro,
 MAX(CASE
   WHEN spr_id = 18
   THEN kat_bez
   ELSE NULL
   END) AS kat_bez_bg
FROM kfl_production_dbp_view.v_mcx_kategorie_spr_zu_2
GROUP BY kat_id;