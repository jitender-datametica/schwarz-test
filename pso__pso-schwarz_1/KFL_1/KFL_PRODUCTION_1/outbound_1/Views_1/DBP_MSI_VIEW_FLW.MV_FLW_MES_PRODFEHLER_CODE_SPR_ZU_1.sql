CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_flw.mv_flw_mes_prodfehler_code_spr_zu_1 (mandant_id, fehler_code_id,
fehler_code_gruppe_id, fehler_code_bez) AS SELECT V01.mandant_id,
 V01.fehler_code_id,
 V01.fehler_code_gruppe_id,
 V01.fehler_code_bez
FROM kfl_production_dbp_view.v_flw_mes_prodfehler_code_spr_zu_1 AS V01
 INNER JOIN kfl_production_dbp_msi.akt_msi_user_spr_zu_1 AS V02 ON V01.spr_id = V02.spr_id;