CREATE OR REPLACE VIEW DBP_VIEW.V_FLW_MES_PRODFEHLER AS 
    SELECT 
        mandant_id
        ,schicht_id
        ,mes_prodzeittyp_id
        ,fehler_katalog_id
        ,fehler_code_gruppe_id
        ,fehler_code_id
        ,datzeit_anfang
        ,datzeit_ende
        ,ist_fehler_dauer
        ,ist_fehler_einh


FROM DBP_DATA.flw_mes_prodfehler ;