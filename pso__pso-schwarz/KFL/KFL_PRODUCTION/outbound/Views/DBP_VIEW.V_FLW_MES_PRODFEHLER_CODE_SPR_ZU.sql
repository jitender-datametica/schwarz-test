CREATE OR REPLACE VIEW kfl_production_dbp_view.v_flw_mes_prodfehler_code_spr_zu AS SELECT mandant_id,
 fehler_code_id,
 fehler_code_gruppe_id,
 spr_id,
 fehler_code_bez
FROM kfl_production_dbp_data.flw_mes_prodfehler_code_spr_zu;