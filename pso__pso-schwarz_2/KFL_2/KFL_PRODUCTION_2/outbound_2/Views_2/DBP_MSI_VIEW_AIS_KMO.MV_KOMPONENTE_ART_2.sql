CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ais_kmo.mv_komponente_art_2 (mandant_id, komponente_art_id,
komponente_kl_art_id, komponente_kl_art_id_lang) AS SELECT mandant_id,
 art_id AS komponente_art_id,
 kl_art_id AS komponente_kl_art_id,
 TRIM(CAST(kl_art_id AS STRING FORMAT '00000000')) AS komponente_kl_art_id_lang
FROM kfl_production_dbp_view.v_art_2 AS V01
WHERE mandant_id <> 1
 AND (CAST(mandant_id AS BIGNUMERIC), CAST(art_id AS BIGNUMERIC)) IN (SELECT (mandant_id, art_id)
   FROM kfl_production_dbp_view.v_stueckliste_det_2);