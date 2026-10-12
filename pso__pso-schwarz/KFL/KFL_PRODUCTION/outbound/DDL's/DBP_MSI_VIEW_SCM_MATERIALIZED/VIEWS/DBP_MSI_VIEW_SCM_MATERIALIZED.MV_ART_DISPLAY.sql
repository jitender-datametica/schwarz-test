-- 2024-10-23, dknop, initial
 CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_scm_materialized.mv_art_display (art_id
, mandant_id, kl_art_id, kl_art_id_lang, artikeltyp_id) AS SELECT art_id,
 mandant_id,
  CASE
  WHEN kl_art_id = 0
  THEN art_id
  ELSE kl_art_id
  END AS kl_art_id,
 TRIM(CAST(kl_art_id AS STRING FORMAT '00000000')) AS kl_art_id_lang,
 artikeltyp_id
FROM kfl_production_dbp_view.v_art AS V01
UNION DISTINCT
SELECT -3 AS art_id,
 mandant_id,
 -1 AS kl_art_id,
 '-1' AS kl_art_id_lang,
 -1 AS artikeltyp_id
FROM kfl_production_dbp_view.v_mandant AS V01;