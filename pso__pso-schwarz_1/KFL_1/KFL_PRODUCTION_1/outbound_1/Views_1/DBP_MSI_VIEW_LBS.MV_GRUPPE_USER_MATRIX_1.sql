CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_lbs.mv_gruppe_user_matrix_1 (gruppe_id, user_id) AS SELECT
 lbs_gruppe_id AS gruppe_id,
 'User anlegen' AS user_id
FROM kfl_production_dbp_security.lbs_gruppe_1 AS V01
WHERE lbs_gruppe_id <> 0
UNION DISTINCT
SELECT lbs_gruppe_id,
 user_id
FROM kfl_production_dbp_security.lbs_gruppe_user_zu_1 AS V02
WHERE lbs_gruppe_id <> 0;