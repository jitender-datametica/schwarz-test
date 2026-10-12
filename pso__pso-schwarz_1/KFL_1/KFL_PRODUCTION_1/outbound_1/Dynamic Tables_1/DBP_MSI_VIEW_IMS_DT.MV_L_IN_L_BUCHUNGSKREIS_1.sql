CREATE OR REPLACE MATERIALIZED VIEW kfl_production_dbp_msi_view_ims_dt.mv_l_in_l_buchungskreis_1
OPTIONS (
  ENABLE_REFRESH=TRUE,
  REFRESH_INTERVAL_MINUTES=90
) AS
SELECT
  mandant_id AS mandant_id,
  buchungskreis_id AS buchungskreis_id,
  kontenplan_id AS kontenplan_id,
  sako_fg AS sako_fg
FROM kfl_production_dbp_view.v_in_l_buchungskreis_1 AS v01;
