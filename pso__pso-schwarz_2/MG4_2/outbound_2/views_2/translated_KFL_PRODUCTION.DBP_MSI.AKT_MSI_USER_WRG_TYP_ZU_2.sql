CREATE OR REPLACE VIEW kfl_production_dbp_msi.akt_msi_user_wrg_typ_zu_2 (user_id, wrg_typ_id, berichtskurs_typ_id) AS
SELECT v02.user_id,
 v02.wrg_typ_id,
 v02.berichtskurs_typ_id
FROM kfl_production_dbp_msi_data.akt_msi_user_2 AS v01
 INNER JOIN kfl_production_dbp_msi_v_view.v_user_wrg_typ_zu_2 AS v02 ON v01.user_id = v02.user_id AND v01.session_id = ABS(FARM_FINGERPRINT(SESSION_USER()
     ))
GROUP BY v02.user_id,
 v02.wrg_typ_id,
 v02.berichtskurs_typ_id;