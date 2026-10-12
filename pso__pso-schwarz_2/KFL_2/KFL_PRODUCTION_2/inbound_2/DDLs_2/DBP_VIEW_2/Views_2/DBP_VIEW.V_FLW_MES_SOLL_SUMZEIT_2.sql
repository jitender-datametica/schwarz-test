CREATE OR REPLACE VIEW DBP_VIEW.V_FLW_MES_SOLL_SUMZEIT_2 AS 
    SELECT 
        mandant_id
        ,flw_werk_id
        ,flw_arbeitsplatz_id
        ,schicht_id
        ,mes_prodzeittyp_id
        ,dat_soll_prod
        ,planungs_dauer
        ,planungs_einh
        ,datzeit_aenderung


FROM DBP_DATA.flw_mes_soll_sumzeit_2 ;