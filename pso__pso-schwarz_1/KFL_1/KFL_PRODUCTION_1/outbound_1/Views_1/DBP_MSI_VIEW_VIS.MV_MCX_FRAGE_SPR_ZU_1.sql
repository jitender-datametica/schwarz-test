CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_mcx_frage_spr_zu_1 AS SELECT frage_id,
 umfrage_id,
 2 AS kmr_quelle_id,
 MAX(CASE
   WHEN spr_id = 22
   THEN frage_bez
   ELSE NULL
   END) AS frage_bez,
 MAX(CASE
   WHEN spr_id = 124
   THEN frage_bez
   ELSE NULL
   END) AS frage_bez_cz,
 MAX(CASE
   WHEN spr_id = 90
   THEN frage_bez
   ELSE NULL
   END) AS frage_bez_pl,
 MAX(CASE
   WHEN spr_id = 108
   THEN frage_bez
   ELSE NULL
   END) AS frage_bez_sk,
 MAX(CASE
   WHEN spr_id = 65
   THEN frage_bez
   ELSE NULL
   END) AS frage_bez_hr,
 MAX(CASE
   WHEN spr_id = 95
   THEN frage_bez
   ELSE NULL
   END) AS frage_bez_ro,
 MAX(CASE
   WHEN spr_id = 18
   THEN frage_bez
   ELSE NULL
   END) AS frage_bez_bg,
 MAX(frage_typ) AS frage_typ,
 MAX(frage_alias) AS frage_alias
FROM kfl_production_dbp_view.v_mcx_frage_spr_zu_1
GROUP BY frage_id,
 umfrage_id,
 kmr_quelle_id;