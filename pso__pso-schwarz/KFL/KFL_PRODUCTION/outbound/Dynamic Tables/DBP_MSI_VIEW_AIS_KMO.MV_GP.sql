CREATE OR REPLACE MATERIALIZED VIEW kfl_production_dbp_msi_view_ais_kmo.mv_gp
OPTIONS (
  ENABLE_REFRESH=TRUE,
  REFRESH_INTERVAL_MINUTES=90
) AS
SELECT
  mandant_id,
  gp_id,
  gp_name,
  zek_id,
  land_id,
  zahlungsziel_id,
  ivn,
  markant_id
FROM kfl_production_dbp_view.v_gp AS v01
WHERE
  mandant_id <> 1 AND einkaufsorganisation_id <> -1;