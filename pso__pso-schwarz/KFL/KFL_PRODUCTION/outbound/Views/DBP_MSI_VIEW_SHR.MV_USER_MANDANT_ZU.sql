CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_shr.mv_user_mandant_zu (mandant_id, user_id) AS SELECT mandant_id,
 LOWER(user_id) AS user_id
FROM kfl_production_dbp_security.user_hr_objekt_id_zu
GROUP BY mandant_id,
 user_id;