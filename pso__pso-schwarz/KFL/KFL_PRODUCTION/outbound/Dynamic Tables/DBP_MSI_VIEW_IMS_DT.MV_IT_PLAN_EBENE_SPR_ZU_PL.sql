CREATE OR REPLACE MATERIALIZED VIEW kfl_production_dbp_msi_view_ims_dt.mv_it_plan_ebene_spr_zu_pl
OPTIONS (
  ENABLE_REFRESH=TRUE,
  REFRESH_INTERVAL_MINUTES=90,
  max_staleness=INTERVAL '90' MINUTE,
  allow_non_incremental_definition=TRUE
) AS
SELECT
  de.it_plan_ebene_id AS it_plan_ebene_id,
  COALESCE(ls.it_plan_ebene_kbez, de.it_plan_ebene_kbez) AS it_plan_ebene_kbez,
  COALESCE(ls.it_plan_ebene_bez, de.it_plan_ebene_bez) AS it_plan_ebene_bez
FROM kfl_production_dbp_view.v_it_plan_ebene_spr_zu AS de
LEFT JOIN (
  SELECT
    *
  FROM kfl_production_dbp_view.v_it_plan_ebene_spr_zu
  WHERE
    spr_id = 90
) AS ls
  ON de.it_plan_ebene_id = ls.it_plan_ebene_id
WHERE
  de.spr_id = 22;
