CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_problemcode_spr_zu AS SELECT mandant_id,
 problemcode_id,
 MAX(CASE
   WHEN spr_id = 22
   THEN problemcode_bez
   ELSE NULL
   END) AS problemcode_bez,
 MAX(CASE
   WHEN spr_id = 22
   THEN problemcode_bez
   ELSE NULL
   END) AS problemcode_bez_de,
 MAX(CASE
   WHEN spr_id = 124
   THEN problemcode_bez
   ELSE NULL
   END) AS problemcode_bez_cz,
 MAX(CASE
   WHEN spr_id = 90
   THEN problemcode_bez
   ELSE NULL
   END) AS problemcode_bez_pl,
 MAX(CASE
   WHEN spr_id = 108
   THEN problemcode_bez
   ELSE NULL
   END) AS problemcode_bez_sk,
 MAX(CASE
   WHEN spr_id = 65
   THEN problemcode_bez
   ELSE NULL
   END) AS problemcode_bez_hr,
 MAX(CASE
   WHEN spr_id = 95
   THEN problemcode_bez
   ELSE NULL
   END) AS problemcode_bez_ro,
 MAX(CASE
   WHEN spr_id = 18
   THEN problemcode_bez
   ELSE NULL
   END) AS problemcode_bez_bg,
 MAX(CASE
   WHEN spr_id = 22
   THEN problemcode_bez_kurz
   ELSE NULL
   END) AS problemcode_bez_kurz,
 MAX(CASE
   WHEN spr_id = 22
   THEN problemcode_bez_kurz
   ELSE NULL
   END) AS problemcode_bez_kurz_de,
 MAX(CASE
   WHEN spr_id = 124
   THEN problemcode_bez_kurz
   ELSE NULL
   END) AS problemcode_bez_kurz_cz,
 MAX(CASE
   WHEN spr_id = 90
   THEN problemcode_bez_kurz
   ELSE NULL
   END) AS problemcode_bez_kurz_pl,
 MAX(CASE
   WHEN spr_id = 108
   THEN problemcode_bez_kurz
   ELSE NULL
   END) AS problemcode_bez_kurz_sk,
 MAX(CASE
   WHEN spr_id = 65
   THEN problemcode_bez_kurz
   ELSE NULL
   END) AS problemcode_bez_kurz_hr,
 MAX(CASE
   WHEN spr_id = 95
   THEN problemcode_bez_kurz
   ELSE NULL
   END) AS problemcode_bez_kurz_ro,
 MAX(CASE
   WHEN spr_id = 18
   THEN problemcode_bez_kurz
   ELSE NULL
   END) AS problemcode_bez_kurz_bg,
 MAX(CASE
   WHEN spr_id = 22
   THEN problemcode_bez_lang
   ELSE NULL
   END) AS problemcode_bez_lang,
 MAX(CASE
   WHEN spr_id = 22
   THEN problemcode_bez_lang
   ELSE NULL
   END) AS problemcode_bez_lang_de,
 MAX(CASE
   WHEN spr_id = 124
   THEN problemcode_bez_lang
   ELSE NULL
   END) AS problemcode_bez_lang_cz,
 MAX(CASE
   WHEN spr_id = 90
   THEN problemcode_bez_lang
   ELSE NULL
   END) AS problemcode_bez_lang_pl,
 MAX(CASE
   WHEN spr_id = 108
   THEN problemcode_bez_lang
   ELSE NULL
   END) AS problemcode_bez_lang_sk,
 MAX(CASE
   WHEN spr_id = 65
   THEN problemcode_bez_lang
   ELSE NULL
   END) AS problemcode_bez_lang_hr,
 MAX(CASE
   WHEN spr_id = 95
   THEN problemcode_bez_lang
   ELSE NULL
   END) AS problemcode_bez_lang_ro,
 MAX(CASE
   WHEN spr_id = 18
   THEN problemcode_bez_lang
   ELSE NULL
   END) AS problemcode_bez_lang_bg
FROM kfl_production_dbp_view.v_problemcode_spr_zu
GROUP BY mandant_id,
 problemcode_id;