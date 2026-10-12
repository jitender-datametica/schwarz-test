CREATE OR REPLACE VIEW DBP_VIEW.V_FLW_MES_PRODFEHLER_CODE_SPR_ZU AS 
    SELECT 
        mandant_id
        ,fehler_code_id
        ,fehler_code_gruppe_id
        ,spr_id
        ,fehler_code_bez


FROM DBP_DATA.flw_mes_prodfehler_code_spr_zu ;