CREATE OR REPLACE VIEW DBP_VIEW.V_L_PREIS_AENDERUNG_1 AS 
    SELECT 
        mandant_id,
        preis_aend_grund_id,
        abschriftgruppe_id
FROM DBP_DATA.L_PREIS_AENDERUNG_1 ;