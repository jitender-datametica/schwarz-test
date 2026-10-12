CREATE OR REPLACE VIEW kfl_production_dbp_msi.akt_msi_user_spr_zu_1 (user_id, spr_id) AS SELECT V02.user_id,
 V02.spr_id
FROM kfl_production_dbp_msi_data.akt_msi_user_1 AS V01
 INNER JOIN kfl_production_dbp_msi_v_view.v_user_spr_zu_1 AS V02 ON V01.user_id = V02.user_id AND V01.session_id = ABS(FARM_FINGERPRINT(SESSION_USER()
     ))
GROUP BY V02.user_id,
 V02.spr_id;