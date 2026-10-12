CREATE OR REPLACE MATERIALIZED VIEW kfl_production_dbp_msi_view_ais_kmo.mv_wg_wup_pm_zu_per_2
OPTIONS (
  ENABLE_REFRESH=TRUE,
  REFRESH_INTERVAL_MINUTES=90
) AS
SELECT
  wup_id AS wup_id,
  nb_id AS nb_id,
  arthiertyp_id AS arthiertyp_id,
  wg_id AS wg_id,
  pm_id AS pm_id,
  dat_von AS dat_von,
  dat_bis AS dat_bis,
  mandant_id AS mandant_id
FROM kfl_production_dbp_view.v_pm_wup_wg_zu_per_2
WHERE
  mandant_id <> 1 AND arthiertyp_id = 2 AND dat_bis = CAST('9999-12-31' AS DATE);
