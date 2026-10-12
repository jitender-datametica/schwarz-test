CREATE OR REPLACE VIEW DBP_VIEW.V_FLW_MES_IST_SUMMENGE_2 AS 
    SELECT 
        mandant_id
        ,flw_werk_id
        ,flw_arbeitsplatz_id
        ,schicht_id
        ,mes_prodmengetyp_id
        ,dat_prod
        ,ist_menge
        ,ist_einh
        ,datzeit_aenderung


FROM DBP_DATA.flw_mes_ist_summenge_2 ;