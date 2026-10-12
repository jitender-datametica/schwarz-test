CREATE OR REPLACE VIEW DBP_VIEW.V_EINLAGER_STEUERUNG_SPR_ZU_1 AS 
    SELECT 
        mandant_id
        ,lagernummer_id
        ,einlager_steuerung_id
        ,spr_id
        ,einlager_steuerung_bez


FROM DBP_DATA.einlager_steuerung_spr_zu_1 ;