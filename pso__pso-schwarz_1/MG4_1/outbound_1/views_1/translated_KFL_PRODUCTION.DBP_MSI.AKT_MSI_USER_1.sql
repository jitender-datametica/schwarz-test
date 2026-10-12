CREATE OR REPLACE VIEW kfl_production_dbp_msi.akt_msi_user_1 (user_id, session_id) AS SELECT *
FROM kfl_production_dbp_msi_data.akt_msi_user_1 AS v01
WHERE session_id = ABS(FARM_FINGERPRINT(SESSION_USER()))
GROUP BY user_id,
 session_id;