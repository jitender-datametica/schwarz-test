CREATE OR REPLACE MATERIALIZED VIEW kfl_production_dbp_msi_view_ims_dt.mv_geschaeftsbereich_spr_zu_cz
OPTIONS (
  ENABLE_REFRESH=TRUE,
  REFRESH_INTERVAL_MINUTES=90
) AS
SELECT
  mandant_id AS mandant_id,
  geschaeftsbereich_id AS geschaeftsbereich_id,
  geschaeftsbereich_bez AS geschaeftsbereich_bez
FROM kfl_production_dbp_view.v_geschaeftsbereich_spr_zu
WHERE
  spr_id = 124;
