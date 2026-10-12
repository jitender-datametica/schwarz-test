CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ais_int.mv_user (user_id) AS SELECT user_id
FROM kfl_production_dbp_security.gruppe_user_zu AS V01
GROUP BY user_id;