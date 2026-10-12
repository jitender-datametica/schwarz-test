CREATE OR REPLACE MATERIALIZED VIEW kfl_production_dbp_msi_view_ims_dt.mv_l_ginfo_bauform_1
OPTIONS (
  ENABLE_REFRESH=TRUE,
  REFRESH_INTERVAL_MINUTES=90
) AS
SELECT
   ginfo_bauform_id
FROM kfl_production_dbp_view.v_l_ginfo_bauform_1;
