CREATE OR REPLACE VIEW kfl_production_dbp_msi.akt_msi_user_sqlvariable_2 AS SELECT user_id,
 session_id
FROM kfl_production_dbp_msi_data.akt_msi_user_2 AS V01
WHERE user_id = $userid
GROUP BY user_id,
 session_id;