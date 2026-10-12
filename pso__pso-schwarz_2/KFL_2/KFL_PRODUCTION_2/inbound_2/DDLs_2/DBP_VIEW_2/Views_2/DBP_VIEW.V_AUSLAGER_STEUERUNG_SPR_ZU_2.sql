CREATE OR REPLACE VIEW DBP_VIEW.V_AUSLAGER_STEUERUNG_SPR_ZU_2 AS 
    SELECT 
        mandant_id
        ,lagernummer_id
        ,auslager_steuerung_id
        ,spr_id
        ,auslager_steuerung_bez


FROM DBP_DATA.auslager_steuerung_spr_zu_2 ;