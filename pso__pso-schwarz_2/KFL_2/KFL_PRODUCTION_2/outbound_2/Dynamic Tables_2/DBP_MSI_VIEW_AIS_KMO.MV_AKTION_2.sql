CREATE OR REPLACE MATERIALIZED VIEW kfl_production_dbp_msi_view_ais_kmo.mv_aktion_2
OPTIONS (
  ENABLE_REFRESH=TRUE,
  REFRESH_INTERVAL_MINUTES=90
) AS
SELECT DISTINCT
  aktion_id AS aktion_id,
  mandant_id AS mandant_id,
  aktionsart_id AS aktionsart_id,
  dat_von AS dat_von,
  dat_bis AS dat_bis,
  kjwo_von AS ww_kjwo
FROM kfl_production_dbp_view.v_aktion_2 AS v01
WHERE
  mandant_id <> 1;
