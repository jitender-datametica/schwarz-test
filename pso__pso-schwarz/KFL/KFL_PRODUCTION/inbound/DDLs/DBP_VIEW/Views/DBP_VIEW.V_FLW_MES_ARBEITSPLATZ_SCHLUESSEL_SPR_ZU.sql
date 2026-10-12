CREATE OR REPLACE VIEW DBP_VIEW.V_FLW_MES_ARBEITSPLATZ_SCHLUESSEL_SPR_ZU AS 
    SELECT 
        mandant_id
        ,flw_arbeitsplatzschluessel_id
        ,spr_id
        ,flw_arbeitsplatz_bez


FROM DBP_DATA.flw_mes_arbeitsplatz_schluessel_spr_zu ;