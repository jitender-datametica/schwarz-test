CREATE OR REPLACE MATERIALIZED VIEW kfl_production_dbp_msi_view_ais_int.mv_art_gp_nm_zu_akt
OPTIONS (
  ENABLE_REFRESH=TRUE,
  REFRESH_INTERVAL_MINUTES=90
) AS
SELECT
  mandant_id AS mandant_id,
  art_id AS art_id,
  wup_id AS wup_id,
  nb_id AS nb_id,
  dat_von AS dat_von,
  gp_id AS akt_gp_id,
  einkaufsorganisation_id AS einkaufsorganisation_id,
  dat_bis AS dat_bis
FROM kfl_production_dbp_view.v_art_gp_nm_zu_per AS v01
WHERE
  dat_bis = CAST('9999-12-31' AS DATE);
