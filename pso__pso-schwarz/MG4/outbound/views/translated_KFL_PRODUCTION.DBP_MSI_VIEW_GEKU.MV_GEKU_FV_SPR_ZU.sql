-- standard=deutsch
 -- 27.02.2017 twie: SPEC0019359 Umstellung spaltenbasiert

CREATE OR REPLACE VIEW dbp_msi_view_geku.mv_geku_fv_spr_zu (fv_fg, fv_bez, fv_bez_cz, fv_bez_pl, fv_bez_sk, fv_bez_hr,
fv_bez_ro, fv_bez_bg) AS SELECT fv_fg,
 MAX(CASE
   WHEN spr_id = 22
   THEN fv_bez
   ELSE NULL
   END) AS fv_bez,
 MAX(CASE
   WHEN spr_id = 124
   THEN fv_bez
   ELSE NULL
   END) AS fv_bez_cz,
 MAX(CASE
   WHEN spr_id = 90
   THEN fv_bez
   ELSE NULL
   END) AS fv_bez_pl,
 MAX(CASE
   WHEN spr_id = 108
   THEN fv_bez
   ELSE NULL
   END) AS fv_bez_sk,
 MAX(CASE
   WHEN spr_id = 65
   THEN fv_bez
   ELSE NULL
   END) AS fv_bez_hr,
 MAX(CASE
   WHEN spr_id = 95
   THEN fv_bez
   ELSE NULL
   END) AS fv_bez_ro,
 MAX(CASE
   WHEN spr_id = 18
   THEN fv_bez
   ELSE NULL
   END) AS fv_bez_bg
FROM kfl_production_dbp_view.v_geku_fv_spr_zu AS v01
GROUP BY fv_fg;