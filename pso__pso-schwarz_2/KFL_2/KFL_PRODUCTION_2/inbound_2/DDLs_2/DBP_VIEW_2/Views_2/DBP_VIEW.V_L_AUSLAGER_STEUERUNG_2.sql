CREATE OR REPLACE VIEW DBP_VIEW.V_L_AUSLAGER_STEUERUNG_2 AS 
    SELECT 
        mandant_id
        ,lagernummer_id
        ,auslager_steuerung_id


FROM DBP_DATA.l_auslager_steuerung_2 ;