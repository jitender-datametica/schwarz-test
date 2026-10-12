CREATE OR REPLACE VIEW kfl_production_dbp_msi.akt_msi_user_sqlvariable AS SELECT user_id,
 session_id
FROM kfl_production_dbp_msi_data.akt_msi_user AS V01
WHERE user_id = $userid
GROUP BY user_id,
 session_id;