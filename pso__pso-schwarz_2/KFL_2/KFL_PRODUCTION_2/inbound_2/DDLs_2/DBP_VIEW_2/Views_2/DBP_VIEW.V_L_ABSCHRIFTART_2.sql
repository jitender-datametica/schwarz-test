CREATE OR REPLACE VIEW DBP_VIEW.V_L_ABSCHRIFTART_2 AS 
    SELECT 
        mandant_id,
        abschriftart_id,
        abschriftgruppe_id
FROM DBP_DATA.L_ABSCHRIFTART_2 ;