CREATE OR REPLACE VIEW DBP_VIEW.V_verrechnungsart_spr_zu AS 
    SELECT 
        mandant_id,
        verrechnungsart_id,
        spr_id,
        verrechnungsart_bez
FROM DBP_DATA.verrechnungsart_spr_zu ;