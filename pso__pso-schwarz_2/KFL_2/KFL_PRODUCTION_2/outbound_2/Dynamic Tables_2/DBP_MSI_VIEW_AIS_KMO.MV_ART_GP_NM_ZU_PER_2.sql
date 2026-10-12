CREATE OR REPLACE MATERIALIZED VIEW kfl_production_dbp_msi_view_ais_kmo.mv_art_gp_nm_zu_per_2
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
  gp_id AS gp_id,
  einkaufsorganisation_id AS einkaufsorganisation_id,
  dat_bis AS dat_bis
FROM kfl_production_dbp_view.v_art_gp_nm_zu_per_2 AS v01
WHERE
  mandant_id <> 1;
