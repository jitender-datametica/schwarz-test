CREATE OR REPLACE VIEW DBP_VIEW.V_L_AUSLAGER_STEUERUNG AS 
    SELECT 
        mandant_id
        ,lagernummer_id
        ,auslager_steuerung_id


FROM DBP_DATA.l_auslager_steuerung ;