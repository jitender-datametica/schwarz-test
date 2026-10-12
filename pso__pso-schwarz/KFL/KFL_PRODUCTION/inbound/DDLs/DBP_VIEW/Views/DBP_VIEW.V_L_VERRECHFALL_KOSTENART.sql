CREATE OR REPLACE VIEW DBP_VIEW.V_l_verrechfall_kostenart AS 
    SELECT 
        mandant_id,
        verrechfall_kostenart_id,
        verrechfall_kostentyp_id,
        verrechnungsart_id
FROM DBP_DATA.l_verrechfall_kostenart ;