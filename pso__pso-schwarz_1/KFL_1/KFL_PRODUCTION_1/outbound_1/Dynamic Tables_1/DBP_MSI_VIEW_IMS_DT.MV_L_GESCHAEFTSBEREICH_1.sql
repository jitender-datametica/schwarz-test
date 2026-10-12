CREATE OR REPLACE MATERIALIZED VIEW kfl_production_dbp_msi_view_ims_dt.mv_l_geschaeftsbereich_1
OPTIONS (
  ENABLE_REFRESH=TRUE,
  REFRESH_INTERVAL_MINUTES=90
) AS
SELECT
  geschaeftsbereich_id AS geschaeftsbereich_id,
  mandant_id AS mandant_id
FROM kfl_production_dbp_view.v_l_geschaeftsbereich_1;
