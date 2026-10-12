CREATE OR REPLACE MATERIALIZED VIEW kfl_production_dbp_msi_view_ais_int.mv_art_gp_nm_zu_per_1
OPTIONS (
  ENABLE_REFRESH=TRUE,
  REFRESH_INTERVAL_MINUTES=90
) AS
SELECT
  mandant_id,
  art_id,
  wup_id,
  nb_id,
  dat_von,
  gp_id,
  einkaufsorganisation_id,
  dat_bis
FROM kfl_production_dbp_view.v_art_gp_nm_zu_per_1 AS v01;