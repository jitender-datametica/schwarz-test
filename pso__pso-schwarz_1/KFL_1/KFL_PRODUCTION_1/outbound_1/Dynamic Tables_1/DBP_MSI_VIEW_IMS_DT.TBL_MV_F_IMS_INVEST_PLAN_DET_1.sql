CREATE OR REPLACE MATERIALIZED VIEW kfl_production_dbp_msi_view_ims_dt.tbl_mv_f_ims_invest_plan_det_1
OPTIONS (
  ENABLE_REFRESH=TRUE,
  REFRESH_INTERVAL_MINUTES=90
) AS
SELECT
  mandant_id AS mandant_id,
  gj AS gj,
  hr_plan_gesamt_kz AS hochrechnung_fg,
  berichts_pos_invest_grp_id AS berichts_pos_invest_grp_id,
  psp_id AS psp_id,
  plan_betrag AS plan_betrag,
  wrg_id AS wrg_id,
  CASE WHEN sparte_id IN (4, 6, 8) THEN 5 ELSE sparte_id END AS sparte_id
FROM kfl_production_dbp_view.v_ims_invest_plan_det_1 AS v01;
