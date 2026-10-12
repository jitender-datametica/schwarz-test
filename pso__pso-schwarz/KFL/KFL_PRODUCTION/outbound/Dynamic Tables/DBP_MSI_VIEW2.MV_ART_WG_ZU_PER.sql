CREATE OR REPLACE MATERIALIZED VIEW kfl_production_dbp_msi_view2.mv_art_wg_zu_per
OPTIONS (
  ENABLE_REFRESH=TRUE,
  REFRESH_INTERVAL_MINUTES=90
) AS
SELECT
  art_id AS art_id,
  mandant_id AS mandant_id,
  arthiertyp_id AS arthiertyp_id,
  wug_id AS wug_id,
  wg_id AS wg_id,
  dat_von AS dat_von,
  dat_bis AS dat_bis
FROM kfl_production_dbp_view.v_art_wg_zu_per
WHERE
  arthiertyp_id = 2 AND mandant_id = 1 AND dat_bis = CAST('9999-12-31' AS DATE);
