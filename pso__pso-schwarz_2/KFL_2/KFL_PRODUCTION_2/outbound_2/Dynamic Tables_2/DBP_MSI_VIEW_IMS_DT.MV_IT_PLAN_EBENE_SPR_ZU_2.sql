CREATE OR REPLACE MATERIALIZED VIEW kfl_production_dbp_msi_view_ims_dt.mv_it_plan_ebene_spr_zu_2
OPTIONS (
  ENABLE_REFRESH=TRUE,
  REFRESH_INTERVAL_MINUTES=90
) AS
SELECT
  it_plan_ebene_id AS it_plan_ebene_id,
  it_plan_ebene_kbez AS it_plan_ebene_kbez,
  it_plan_ebene_bez AS it_plan_ebene_bez
FROM kfl_production_dbp_view.v_it_plan_ebene_spr_zu_2
WHERE
  spr_id = 22;
