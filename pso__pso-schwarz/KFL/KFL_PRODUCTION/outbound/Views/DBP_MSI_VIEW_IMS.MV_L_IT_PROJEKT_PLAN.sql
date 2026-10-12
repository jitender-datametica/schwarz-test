CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ims.mv_l_it_projekt_plan AS SELECT plan_revision_id AS
 plan_version_id,
 it_projekt_id,
 sonstiger_aufwand,
 aktivierungsquote_intern_plan AS aktivierungsquote_intern,
 aktivierungsquote_extern_plan AS aktivierungsquote_extern,
 dat_von,
 dat_bis
FROM kfl_production_dbp_view.v_it_projekt_plan;