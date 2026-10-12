CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ims.mv_l_ims_invest_plan_2 AS SELECT mandant_id,
 hr_plan_gesamt_kz AS hochrechnung_fg,
 gj,
 sperr_fg,
 datzeit_upload
FROM kfl_production_dbp_view.v_ims_invest_plan_2 AS V01;