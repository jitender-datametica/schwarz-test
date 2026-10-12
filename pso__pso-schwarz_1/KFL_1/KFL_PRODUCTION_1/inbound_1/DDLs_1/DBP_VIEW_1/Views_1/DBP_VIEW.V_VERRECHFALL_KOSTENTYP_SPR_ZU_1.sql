CREATE OR REPLACE VIEW DBP_VIEW.V_verrechfall_kostentyp_spr_zu_1 AS 
    SELECT 
        mandant_id,
        verrechfall_kostentyp_id,
        spr_id,
        verrechfall_kostentyp_bez
FROM DBP_DATA.verrechfall_kostentyp_spr_zu_1 ;