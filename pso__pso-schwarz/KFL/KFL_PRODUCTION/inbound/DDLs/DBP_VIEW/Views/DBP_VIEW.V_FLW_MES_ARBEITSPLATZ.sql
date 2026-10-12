CREATE OR REPLACE VIEW DBP_VIEW.V_FLW_MES_ARBEITSPLATZ AS 
    SELECT 
        mandant_id
        ,flw_arbeitsplatz_id
        ,flw_arbeitsplatztyp_id


FROM DBP_DATA.flw_mes_arbeitsplatz ;