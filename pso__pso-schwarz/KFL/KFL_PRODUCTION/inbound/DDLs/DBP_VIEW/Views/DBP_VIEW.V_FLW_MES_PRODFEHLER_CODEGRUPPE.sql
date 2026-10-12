CREATE OR REPLACE VIEW DBP_VIEW.V_FLW_MES_PRODFEHLER_CODEGRUPPE AS 
    SELECT 
        mandant_id
        ,fehler_katalog_id
        ,fehler_code_gruppe_id


FROM DBP_DATA.flw_mes_prodfehler_codegruppe ;