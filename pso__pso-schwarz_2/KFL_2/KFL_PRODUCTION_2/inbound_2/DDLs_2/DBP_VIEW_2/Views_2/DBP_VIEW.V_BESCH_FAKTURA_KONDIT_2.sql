CREATE OR REPLACE VIEW DBP_VIEW.V_BESCH_FAKTURA_KONDIT_2 AS 
    SELECT 
        mandant_id
        ,faktura_beleg_id
        ,faktura_beleg_pos_id
        ,beleg_kondition_id
        ,kondition_schl_id
        ,wrg_id
        ,kondition_wert
        ,kappl
FROM DBP_DATA.besch_faktura_kondit_2 ;