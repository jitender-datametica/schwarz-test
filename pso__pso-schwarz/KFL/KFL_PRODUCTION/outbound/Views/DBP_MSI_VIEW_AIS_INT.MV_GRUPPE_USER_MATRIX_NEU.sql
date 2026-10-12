CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ais_int.mv_gruppe_user_matrix_neu (gruppe_id, user_id) AS SELECT
 gruppe_id,
 '' AS user_id
FROM kfl_production_dbp_security.gruppe AS V01;