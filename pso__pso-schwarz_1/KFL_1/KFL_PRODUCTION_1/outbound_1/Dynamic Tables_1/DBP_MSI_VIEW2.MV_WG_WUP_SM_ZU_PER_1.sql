CREATE OR REPLACE MATERIALIZED VIEW kfl_production_dbp_msi_view2.mv_wg_wup_sm_zu_per_1
OPTIONS (
  ENABLE_REFRESH=TRUE,
  REFRESH_INTERVAL_MINUTES=90
) AS
SELECT
  mandant_id AS mandant_id,
  wup_id AS wup_id,
  wg_id AS wg_id,
  nb_id AS nb_id,
  dat_von AS dat_von,
  arthiertyp_id AS arthiertyp_id,
  dat_bis AS dat_bis,
  sm_id AS sm_id
FROM kfl_production_dbp_view.v_sm_wup_wg_zu_per_1
WHERE
  mandant_id = 1
  AND arthiertyp_id = 2
  AND dat_bis = CAST('9999-12-31' AS DATE)
  AND nb_id <> 99;
