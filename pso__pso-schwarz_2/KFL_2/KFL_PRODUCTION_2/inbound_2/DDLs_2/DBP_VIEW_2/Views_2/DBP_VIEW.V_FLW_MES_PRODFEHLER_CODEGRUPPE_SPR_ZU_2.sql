CREATE OR REPLACE VIEW DBP_VIEW.V_FLW_MES_PRODFEHLER_CODEGRUPPE_SPR_ZU_2 AS 
    SELECT 
        mandant_id
        ,fehler_code_gruppe_id
        ,spr_id
        ,fehler_code_gruppe_bez


FROM DBP_DATA.flw_mes_prodfehler_codegruppe_spr_zu_2 ;