CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_d_pep_plan_tag_1 AS SELECT mandant_id,
 wup_id,
 dat_plan,
 ums_brutto_plan_man
FROM kfl_production_dbp_dialog.d_pep_plan_tag_1;