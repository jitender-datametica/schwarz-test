CREATE OR REPLACE VIEW DBP_VIEW.V_BLOCKLAGERTYP_SPR_ZU AS 
    SELECT 
        mandant_id
        ,lagernummer_id
        ,blocklagertyp_id
        ,spr_id
        ,blocklagertyp_bez


FROM DBP_DATA.blocklagertyp_spr_zu ;