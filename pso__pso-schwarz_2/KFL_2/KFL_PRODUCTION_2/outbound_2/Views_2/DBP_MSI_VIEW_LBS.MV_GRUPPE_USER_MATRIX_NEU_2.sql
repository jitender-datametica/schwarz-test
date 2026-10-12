CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_lbs.mv_gruppe_user_matrix_neu_2 (gruppe_id, user_id) AS SELECT
 lbs_gruppe_id AS gruppe_id,
 '' AS user_id
FROM kfl_production_dbp_security.lbs_gruppe_2 AS V01;