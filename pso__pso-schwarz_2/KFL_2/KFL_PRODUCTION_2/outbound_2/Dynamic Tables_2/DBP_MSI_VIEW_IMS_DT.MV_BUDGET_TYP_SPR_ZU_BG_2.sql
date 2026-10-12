CREATE OR REPLACE MATERIALIZED VIEW kfl_production_dbp_msi_view_ims_dt.mv_budget_typ_spr_zu_bg_2
OPTIONS (
  ENABLE_REFRESH=TRUE,
  REFRESH_INTERVAL_MINUTES=90
) AS
SELECT
  in_budget_typ_id AS in_budget_typ_id,
  in_budget_typ_bez AS in_budget_typ_bez
FROM kfl_production_dbp_view.v_in_budget_typ_spr_zu_2
WHERE
  spr_id = 18;
