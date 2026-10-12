CREATE OR REPLACE VIEW kfl_production_dbp_msi_view2.mv_user_2 (user_id) AS SELECT user_id
FROM kfl_production_dbp_security.gruppe_user_zu_2 AS V01
GROUP BY user_id;