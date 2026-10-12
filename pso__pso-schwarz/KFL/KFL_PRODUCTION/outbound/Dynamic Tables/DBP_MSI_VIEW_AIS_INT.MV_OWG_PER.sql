CREATE OR REPLACE MATERIALIZED VIEW kfl_production_dbp_msi_view_ais_int.mv_owg_per
OPTIONS (
  ENABLE_REFRESH=TRUE,
  REFRESH_INTERVAL_MINUTES=90
) AS
SELECT
  owg_id AS owg_id,
  mandant_id AS mandant_id,
  dat_von AS dat_von,
  dat_bis AS dat_bis,
  arthiertyp_id AS arthiertyp_id,
  hwg_id AS hwg_id
FROM kfl_production_dbp_view.v_owg_per AS v01
WHERE
  arthiertyp_id = 2 AND dat_bis = CAST('9999-12-31' AS DATE);
