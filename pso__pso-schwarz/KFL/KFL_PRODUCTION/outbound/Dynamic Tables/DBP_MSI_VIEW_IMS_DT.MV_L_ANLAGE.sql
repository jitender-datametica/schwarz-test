CREATE OR REPLACE MATERIALIZED VIEW kfl_production_dbp_msi_view_ims_dt.mv_l_anlage
OPTIONS (
  ENABLE_REFRESH=TRUE,
  REFRESH_INTERVAL_MINUTES=90
) AS
SELECT
  anlage_id AS anlage_id,
  anlage_sub_id AS anlage_sub_id,
  mandant_id AS mandant_id,
  buchungskreis_id AS anlage_buchungskreis_id,
  anlage_bez AS anlage_bez
FROM kfl_production_dbp_view.v_anlage;
