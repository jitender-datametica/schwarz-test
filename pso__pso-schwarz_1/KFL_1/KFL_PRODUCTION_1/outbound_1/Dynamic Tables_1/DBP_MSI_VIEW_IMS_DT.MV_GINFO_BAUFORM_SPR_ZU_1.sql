CREATE OR REPLACE MATERIALIZED VIEW kfl_production_dbp_msi_view_ims_dt.mv_ginfo_bauform_spr_zu_1
OPTIONS (
  ENABLE_REFRESH=TRUE,
  REFRESH_INTERVAL_MINUTES=90
) AS
SELECT
  ginfo_bauform_id AS ginfo_bauform_id,
  ginfo_bauform_bez AS ginfo_bauform_bez
FROM kfl_production_dbp_view.v_ginfo_bauform_spr_zu_1
WHERE
  spr_id = 22;
