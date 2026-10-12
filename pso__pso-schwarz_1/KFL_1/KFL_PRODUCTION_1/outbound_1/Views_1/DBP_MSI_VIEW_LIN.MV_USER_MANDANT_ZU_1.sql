CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_lin.mv_user_mandant_zu_1 (mandant_id, user_id) AS SELECT mandant_id,
 user_id
FROM kfl_production_dbp_security.user_hr_objekt_id_zu_1
GROUP BY mandant_id,
 user_id;