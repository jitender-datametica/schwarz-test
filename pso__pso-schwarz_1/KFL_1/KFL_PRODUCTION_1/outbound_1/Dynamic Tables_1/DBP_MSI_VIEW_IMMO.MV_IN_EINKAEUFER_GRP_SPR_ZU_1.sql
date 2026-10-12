CREATE OR REPLACE MATERIALIZED VIEW kfl_production_dbp_msi_view_immo.mv_in_einkaeufer_grp_spr_zu_1
OPTIONS (
  ENABLE_REFRESH=TRUE,
  REFRESH_INTERVAL_MINUTES=90
) AS
SELECT
  mandant_id AS mandant_id,
  einkaeufer_grp_id AS einkaeufer_grp_id,
  spr_id AS spr_id,
  einkaeufer_grp_bez AS einkaeufer_grp_bez
FROM kfl_production_dbp_view.v_in_einkaeufer_grp_spr_zu_1
WHERE
  spr_id = 22;
