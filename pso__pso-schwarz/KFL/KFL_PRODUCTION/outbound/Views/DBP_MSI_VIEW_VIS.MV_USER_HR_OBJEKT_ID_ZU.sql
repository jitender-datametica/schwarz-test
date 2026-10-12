CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_user_hr_objekt_id_zu (mandant_id, hr_objekt_ebene1_id, user_id
) AS SELECT mandant_id,
 hr_objekt_ebene1_id,
 user_id
FROM kfl_production_dbp_security.user_hr_objekt_id_zu;