CREATE OR REPLACE VIEW DBP_VIEW.V_l_verrechnungsart AS 
    SELECT 
        mandant_id,
        verrechnungsart_id
FROM DBP_DATA.l_verrechnungsart ;