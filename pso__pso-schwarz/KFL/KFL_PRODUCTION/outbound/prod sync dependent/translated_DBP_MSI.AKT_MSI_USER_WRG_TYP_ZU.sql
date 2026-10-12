CREATE OR REPLACE VIEW kfl_production_dbp_msi.akt_msi_user_wrg_typ_zu (user_id, wrg_typ_id, berichtskurs_typ_id) AS
SELECT V02.user_id,
 V02.wrg_typ_id,
 V02.berichtskurs_typ_id
FROM kfl_production_dbp_msi_data.akt_msi_user AS V01
 INNER JOIN kfl_production_dbp_msi_v_view.v_user_wrg_typ_zu AS V02 ON V01.user_id = V02.user_id AND V01.session_id = ABS(FARM_FINGERPRINT(SESSION_USER()
     ))
GROUP BY V02.user_id,
 V02.wrg_typ_id,
 V02.berichtskurs_typ_id;