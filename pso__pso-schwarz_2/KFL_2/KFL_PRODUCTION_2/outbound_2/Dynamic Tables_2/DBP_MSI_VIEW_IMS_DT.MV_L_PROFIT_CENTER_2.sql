CREATE OR REPLACE MATERIALIZED VIEW kfl_production_dbp_msi_view_ims_dt.mv_l_profit_center_2
OPTIONS (
  ENABLE_REFRESH=TRUE,
  REFRESH_INTERVAL_MINUTES=90
) AS
SELECT
  krk_id AS krk_id,
  mandant_id AS mandant_id,
  pc_id AS pc_id,
  wup_id AS wup_id,
  nb_id AS nb_id
FROM kfl_production_dbp_view.v_profit_center_2;
