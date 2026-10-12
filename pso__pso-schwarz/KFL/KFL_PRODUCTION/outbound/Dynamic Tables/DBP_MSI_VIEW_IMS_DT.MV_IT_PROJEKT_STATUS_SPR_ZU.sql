CREATE OR REPLACE MATERIALIZED VIEW kfl_production_dbp_msi_view_ims_dt.mv_it_projekt_status_spr_zu
OPTIONS (
  ENABLE_REFRESH=TRUE,
  REFRESH_INTERVAL_MINUTES=90
) AS
SELECT
  it_projekt_status_id AS it_projekt_status_id,
  it_projekt_status_bez AS it_projekt_status_bez
FROM kfl_production_dbp_view.v_it_projekt_status_spr_zu
WHERE
  spr_id = 22;
