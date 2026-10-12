CREATE OR REPLACE VIEW DBP_VIEW.V_FLW_MES_PRODFEHLER_SPR_ZU_1 AS 
    SELECT 
        mandant_id
        ,mes_prodzeittyp_id
        ,spr_id
        ,mes_prodzeittyp_bez


FROM DBP_DATA.flw_mes_prodfehler_spr_zu_1 ;