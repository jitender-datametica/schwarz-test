CREATE OR REPLACE MATERIALIZED VIEW kfl_production_dbp_msi_view_ims_dt.mv_ims_l_systemstatus
OPTIONS (
  ENABLE_REFRESH=TRUE,
  REFRESH_INTERVAL_MINUTES=90
) AS
SELECT
  systemstatus_id AS systemstatus_id,
  mandant_id AS mandant_id
FROM kfl_production_dbp_view.v_ims_l_systemstatus;
