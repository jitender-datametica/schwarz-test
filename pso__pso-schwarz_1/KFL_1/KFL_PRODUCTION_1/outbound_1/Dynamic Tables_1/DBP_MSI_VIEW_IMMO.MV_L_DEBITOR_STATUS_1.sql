CREATE OR REPLACE MATERIALIZED VIEW kfl_production_dbp_msi_view_immo.mv_l_debitor_status_1
OPTIONS (
  ENABLE_REFRESH=TRUE,
  REFRESH_INTERVAL_MINUTES=90
) AS
SELECT
  mandant_id AS mandant_id,
  debitor_status_id AS debitor_status_id,
  debitor_status_bez AS debitor_status_bez,
  spr_id AS spr_id
FROM kfl_production_dbp_view.v_ivs_l_debitor_status_1
WHERE
  spr_id = 22;
