CREATE OR REPLACE MATERIALIZED VIEW kfl_production_dbp_msi_view_ims_dt.mv_monat_spr_zu_pl_2
OPTIONS (
  ENABLE_REFRESH=TRUE,
  REFRESH_INTERVAL_MINUTES=90
) AS
SELECT
  CASE WHEN mo_id >= 3 THEN mo_id - 2 ELSE mo_id + 10 END AS mo_gj,
  mo_bez AS mo_bez
FROM kfl_production_dbp_view.v_monat_spr_zu_2 AS v01
WHERE
  spr_id = 90;
