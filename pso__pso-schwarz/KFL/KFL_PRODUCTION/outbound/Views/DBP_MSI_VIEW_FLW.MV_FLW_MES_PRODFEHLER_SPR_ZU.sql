CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_flw.mv_flw_mes_prodfehler_spr_zu (mandant_id, mes_prodzeittyp_id,
mes_prodzeittyp_bez) AS SELECT V01.mandant_id,
 V01.mes_prodzeittyp_id,
 V01.mes_prodzeittyp_bez
FROM kfl_production_dbp_view.v_flw_mes_prodfehler_spr_zu AS V01
 INNER JOIN kfl_production_dbp_msi.akt_msi_user_spr_zu AS V02 ON V01.spr_id = V02.spr_id;