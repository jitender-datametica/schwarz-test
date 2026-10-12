CREATE OR REPLACE VIEW kfl_production_dbp_view.v_flw_mes_prodfehler_spr_zu AS SELECT mandant_id,
 mes_prodzeittyp_id,
 spr_id,
 mes_prodzeittyp_bez
FROM kfl_production_dbp_data.flw_mes_prodfehler_spr_zu;