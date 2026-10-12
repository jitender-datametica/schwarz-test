CREATE OR REPLACE MATERIALIZED VIEW kfl_production_dbp_msi_view_ims_dt.mv_l_anlage_klasse_1
OPTIONS (
  ENABLE_REFRESH=TRUE,
  REFRESH_INTERVAL_MINUTES=90
) AS
SELECT
  mandant_id AS mandant_id,
  anlage_klasse_id AS anlage_klasse_id,
  gesperrt_fg AS gesperrt_fg
FROM kfl_production_dbp_view.v_l_anlage_klasse_1;
