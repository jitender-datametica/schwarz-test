CREATE OR REPLACE VIEW kfl_production_dbp_msi_view2.mv_gruppe_user_zu (gruppe_id, user_id) AS SELECT gruppe_id,
 user_id
FROM kfl_production_dbp_security.gruppe_user_zu AS V01;