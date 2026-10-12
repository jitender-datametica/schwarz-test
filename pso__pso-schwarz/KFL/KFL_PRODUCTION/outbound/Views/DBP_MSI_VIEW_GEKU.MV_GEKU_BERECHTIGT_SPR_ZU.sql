CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_geku.mv_geku_berechtigt_spr_zu (berechtigt_fg, berechtigt_bez,
berechtigt_bez_cz, berechtigt_bez_pl, berechtigt_bez_sk, berechtigt_bez_hr, berechtigt_bez_ro, berechtigt_bez_bg) AS
SELECT berechtigt_fg,
 MAX(CASE
   WHEN spr_id = 22
   THEN berechtigt_bez
   ELSE NULL
   END) AS berechtigt_bez,
 MAX(CASE
   WHEN spr_id = 124
   THEN berechtigt_bez
   ELSE NULL
   END) AS berechtigt_bez_cz,
 MAX(CASE
   WHEN spr_id = 90
   THEN berechtigt_bez
   ELSE NULL
   END) AS berechtigt_bez_pl,
 MAX(CASE
   WHEN spr_id = 108
   THEN berechtigt_bez
   ELSE NULL
   END) AS berechtigt_bez_sk,
 MAX(CASE
   WHEN spr_id = 65
   THEN berechtigt_bez
   ELSE NULL
   END) AS berechtigt_bez_hr,
 MAX(CASE
   WHEN spr_id = 95
   THEN berechtigt_bez
   ELSE NULL
   END) AS berechtigt_bez_ro,
 MAX(CASE
   WHEN spr_id = 18
   THEN berechtigt_bez
   ELSE NULL
   END) AS berechtigt_bez_bg
FROM kfl_production_dbp_view.v_geku_berechtigt_spr_zu AS V01
GROUP BY berechtigt_fg;