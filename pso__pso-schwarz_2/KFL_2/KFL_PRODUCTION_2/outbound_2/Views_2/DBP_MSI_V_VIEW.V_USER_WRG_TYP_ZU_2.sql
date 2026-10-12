CREATE OR REPLACE VIEW kfl_production_dbp_msi_v_view.v_user_wrg_typ_zu_2 (user_id OPTIONS(description='ID des MSI Users'),
wrg_typ_id OPTIONS(description='Es gibt zwei Typen der Währung - Land_2 = 1 und Euro = 0'), berichtskurs_typ_id
OPTIONS(description='Es gibt zwei Typen des Berichtskurs - aktueller Berichtskurs = 0 und historischer Berichtskurs = 1'))
OPTIONS(DESCRIPTION = `AIS_KMO - ZUORDNUNG DES FRONTEND-USERS ZU EINEM WÄHRUNGSTYP UND BERICHTSKURSTYP - ÜBER FRONTEND EINSTELLBAR.`)
AS SELECT user_id,
 wrg_typ_id,
 berichtskurs_typ_id
FROM kfl_production_dbp_msi_data.user_wrg_typ_zu_2;