CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ais_int.mv_gruppe_user_matrix_2 (gruppe_id, user_id) AS SELECT
 gruppe_id,
 'User anlegen' AS user_id
FROM kfl_production_dbp_security.gruppe_2 AS V01
WHERE gruppe_id <> 0
UNION DISTINCT
SELECT gruppe_id,
 user_id
FROM kfl_production_dbp_security.gruppe_user_zu_2 AS V02
WHERE gruppe_id <> 0;