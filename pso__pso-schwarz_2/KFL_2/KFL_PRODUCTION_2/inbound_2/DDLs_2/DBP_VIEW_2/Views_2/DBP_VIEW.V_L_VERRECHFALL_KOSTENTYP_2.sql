CREATE OR REPLACE VIEW DBP_VIEW.V_l_verrechfall_kostentyp_2 AS 
    SELECT 
        mandant_id,
        verrechfall_kostentyp_id
FROM DBP_DATA.l_verrechfall_kostentyp_2 ;