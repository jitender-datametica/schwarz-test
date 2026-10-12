CREATE OR REPLACE VIEW kfl_production_dbp_view.v_ims_invest_plan_1 AS SELECT mandant_id,
 hr_plan_gesamt_kz,
 gj,
 datzeit_upload,
 sperr_fg
FROM kfl_production_dbp_data.ims_invest_plan_1;