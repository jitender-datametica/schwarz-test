CREATE OR REPLACE MATERIALIZED VIEW kfl_production_dbp_msi_view_ims_dt.mv_in_buchungskreis_spr_zu
OPTIONS (
  ENABLE_REFRESH=TRUE,
  REFRESH_INTERVAL_MINUTES=90
) AS
SELECT
  mandant_id AS mandant_id,
  buchungskreis_id AS buchungskreis_id,
  CASE WHEN buchungskreis_id = -1 THEN '' ELSE buchungskreis_bez END AS buchungskreis_bez
FROM kfl_production_dbp_view.v_in_buchungskreis_spr_zu;
