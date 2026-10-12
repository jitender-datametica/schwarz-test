CREATE OR REPLACE VIEW DBP_VIEW.V_L_BLOCKLAGERTYP AS 
    SELECT 
        mandant_id
        ,lagernummer_id
        ,blocklagertyp_id


FROM DBP_DATA.l_blocklagertyp ;