CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ims.tbl_mv_f_ims_invest_plan_det AS SELECT mandant_id,
 gj,
 hr_plan_gesamt_kz AS hochrechnung_fg,
 berichts_pos_invest_grp_id,
 psp_id,
 plan_betrag,
 wrg_id,
  CASE
  WHEN sparte_id IN (4, 6, 8)
  THEN 5
  ELSE sparte_id
  END AS sparte_id
FROM kfl_production_dbp_view.v_ims_invest_plan_det AS V01;