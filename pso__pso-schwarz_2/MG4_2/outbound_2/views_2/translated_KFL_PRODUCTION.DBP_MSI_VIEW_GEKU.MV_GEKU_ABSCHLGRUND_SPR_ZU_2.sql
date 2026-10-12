-- 08.02.2017 twie: SPEC0019359 Umstellung spaltenbasiert

CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_geku.mv_geku_abschlgrund_spr_zu_2 (abschlussgrund_id,
abschlussgrund_bez, abschlussgrund_bez_cz, abschlussgrund_bez_pl, abschlussgrund_bez_sk, abschlussgrund_bez_hr,
abschlussgrund_bez_ro, abschlussgrund_bez_bg) AS -- standard=deutsch
 SELECT abschlussgrund_id,
 MAX(CASE
   WHEN spr_id = 22
   THEN abschlussgrund_bez
   ELSE NULL
   END) AS abschlussgrund_bez,
 MAX(CASE
   WHEN spr_id = 124
   THEN abschlussgrund_bez
   ELSE NULL
   END) AS abschlussgrund_bez_cz,
 MAX(CASE
   WHEN spr_id = 90
   THEN abschlussgrund_bez
   ELSE NULL
   END) AS abschlussgrund_bez_pl,
 MAX(CASE
   WHEN spr_id = 108
   THEN abschlussgrund_bez
   ELSE NULL
   END) AS abschlussgrund_bez_sk,
 MAX(CASE
   WHEN spr_id = 65
   THEN abschlussgrund_bez
   ELSE NULL
   END) AS abschlussgrund_bez_hr,
 MAX(CASE
   WHEN spr_id = 95
   THEN abschlussgrund_bez
   ELSE NULL
   END) AS abschlussgrund_bez_ro,
 MAX(CASE
   WHEN spr_id = 18
   THEN abschlussgrund_bez
   ELSE NULL
   END) AS abschlussgrund_bez_bg
FROM kfl_production_dbp_view.v_geku_abschlussgrund_spr_zu_2 AS v01
GROUP BY abschlussgrund_id;