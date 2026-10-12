CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_mcx_antwort_spr_zu AS SELECT antwort_id,
 umfrage_id,
 2 AS kmr_quelle_id,
 MAX(CASE
   WHEN spr_id = 22
   THEN antwort_bez
   ELSE NULL
   END) AS antwort_bez,
 MAX(CASE
   WHEN spr_id = 124
   THEN antwort_bez
   ELSE NULL
   END) AS antwort_bez_cz,
 MAX(CASE
   WHEN spr_id = 90
   THEN antwort_bez
   ELSE NULL
   END) AS antwort_bez_pl,
 MAX(CASE
   WHEN spr_id = 108
   THEN antwort_bez
   ELSE NULL
   END) AS antwort_bez_sk,
 MAX(CASE
   WHEN spr_id = 65
   THEN antwort_bez
   ELSE NULL
   END) AS antwort_bez_hr,
 MAX(CASE
   WHEN spr_id = 95
   THEN antwort_bez
   ELSE NULL
   END) AS antwort_bez_ro,
 MAX(CASE
   WHEN spr_id = 18
   THEN antwort_bez
   ELSE NULL
   END) AS antwort_bez_bg,
 MAX(antwort_datentyp) AS antwort_datentyp
FROM kfl_production_dbp_view.v_mcx_antwort_spr_zu
GROUP BY antwort_id,
 umfrage_id,
 kmr_quelle_id;