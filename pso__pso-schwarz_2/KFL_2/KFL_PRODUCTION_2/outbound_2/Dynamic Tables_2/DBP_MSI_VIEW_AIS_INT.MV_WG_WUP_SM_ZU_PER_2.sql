CREATE OR REPLACE MATERIALIZED VIEW kfl_production_dbp_msi_view_ais_int.mv_wg_wup_sm_zu_per_2
OPTIONS (
  ENABLE_REFRESH=TRUE,
  REFRESH_INTERVAL_MINUTES=90
) AS
SELECT
  mandant_id,
  wup_id,
  wg_id,
  nb_id,
  dat_von,
  arthiertyp_id,
  dat_bis,
  CAST(TRIM(NULL) AS STRING) AS sm_id
FROM kfl_production_dbp_view.v_sm_wup_wg_zu_per_2
WHERE
  arthiertyp_id = 2 AND dat_bis = CAST('9999-12-31' AS DATE);