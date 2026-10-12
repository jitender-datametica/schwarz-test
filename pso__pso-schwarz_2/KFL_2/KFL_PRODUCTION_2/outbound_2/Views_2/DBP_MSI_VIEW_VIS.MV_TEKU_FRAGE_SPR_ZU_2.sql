CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_teku_frage_spr_zu_2 AS SELECT teku_frage_id,
 MAX(CASE
   WHEN spr_id = 22
   THEN teku_frage_bez
   ELSE NULL
   END) AS teku_frage_bez,
 MAX(CASE
   WHEN spr_id = 22
   THEN teku_frage_bez
   ELSE NULL
   END) AS teku_frage_bez_de,
 MAX(CASE
   WHEN spr_id = 124
   THEN teku_frage_bez
   ELSE NULL
   END) AS teku_frage_bez_cz,
 MAX(CASE
   WHEN spr_id = 90
   THEN teku_frage_bez
   ELSE NULL
   END) AS teku_frage_bez_pl,
 MAX(CASE
   WHEN spr_id = 108
   THEN teku_frage_bez
   ELSE NULL
   END) AS teku_frage_bez_sk,
 MAX(CASE
   WHEN spr_id = 65
   THEN teku_frage_bez
   ELSE NULL
   END) AS teku_frage_bez_hr,
 MAX(CASE
   WHEN spr_id = 95
   THEN teku_frage_bez
   ELSE NULL
   END) AS teku_frage_bez_ro,
 MAX(CASE
   WHEN spr_id = 18
   THEN teku_frage_bez
   ELSE NULL
   END) AS teku_frage_bez_bg,
 MAX(CASE
   WHEN spr_id = 22
   THEN teku_frage_bez_lang
   ELSE NULL
   END) AS teku_frage_bez_lang,
 MAX(CASE
   WHEN spr_id = 22
   THEN teku_frage_bez_lang
   ELSE NULL
   END) AS teku_frage_bez_lang_de,
 MAX(CASE
   WHEN spr_id = 124
   THEN teku_frage_bez_lang
   ELSE NULL
   END) AS teku_frage_bez_lang_cz,
 MAX(CASE
   WHEN spr_id = 90
   THEN teku_frage_bez_lang
   ELSE NULL
   END) AS teku_frage_bez_lang_pl,
 MAX(CASE
   WHEN spr_id = 108
   THEN teku_frage_bez_lang
   ELSE NULL
   END) AS teku_frage_bez_lang_sk,
 MAX(CASE
   WHEN spr_id = 65
   THEN teku_frage_bez_lang
   ELSE NULL
   END) AS teku_frage_bez_lang_hr,
 MAX(CASE
   WHEN spr_id = 95
   THEN teku_frage_bez_lang
   ELSE NULL
   END) AS teku_frage_bez_lang_ro,
 MAX(CASE
   WHEN spr_id = 18
   THEN teku_frage_bez_lang
   ELSE NULL
   END) AS teku_frage_bez_lang_bg
FROM kfl_production_dbp_view.v_teku_frage_spr_zu_2
GROUP BY teku_frage_id;