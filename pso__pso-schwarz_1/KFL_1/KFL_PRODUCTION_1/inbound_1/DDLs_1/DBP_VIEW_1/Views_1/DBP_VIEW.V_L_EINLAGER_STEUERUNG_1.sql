CREATE OR REPLACE VIEW DBP_VIEW.V_L_EINLAGER_STEUERUNG_1 AS 
    SELECT 
        mandant_id
        ,lagernummer_id
        ,einlager_steuerung_id


FROM DBP_DATA.l_einlager_steuerung_1 ;