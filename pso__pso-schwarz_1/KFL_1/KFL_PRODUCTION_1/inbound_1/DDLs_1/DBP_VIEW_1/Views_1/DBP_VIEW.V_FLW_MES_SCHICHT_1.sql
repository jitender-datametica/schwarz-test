CREATE OR REPLACE VIEW DBP_VIEW.V_FLW_MES_SCHICHT_1 AS 
    SELECT 
        mandant_id
        ,schicht_id
        ,schichttyp_id
        ,datzeit_schicht_anfang
        ,datzeit_schicht_ende
        ,zeit_schicht_beginn
        ,zeit_schicht_ende
        ,flw_werk_id
        ,flw_arbeitsplatz_id
        ,dat_schicht
        ,schicht_dauer
        ,schicht_dauer_einh


FROM DBP_DATA.flw_mes_schicht_1 ;