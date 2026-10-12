CREATE OR REPLACE MATERIALIZED VIEW kfl_production_dbp_msi_view_ais_kmo.mv_disponent_wup_zu_1
OPTIONS (
  ENABLE_REFRESH=TRUE,
  REFRESH_INTERVAL_MINUTES=90
) AS
SELECT
  mandant_id AS mandant_id,
  wup_id AS wup_id,
  nb_id AS nb_id,
  disponent_id AS disponent_id,
  disponent_name AS disponent_name
FROM kfl_production_dbp_view.v_disponent_wup_zu_1
WHERE
  mandant_id <> 1 AND nb_id <> 99;
