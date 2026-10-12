CREATE OR REPLACE VIEW DBP_VIEW.V_L_ABSCHRIFTART AS 
    SELECT 
        mandant_id,
        abschriftart_id,
        abschriftgruppe_id
FROM DBP_DATA.L_ABSCHRIFTART ;