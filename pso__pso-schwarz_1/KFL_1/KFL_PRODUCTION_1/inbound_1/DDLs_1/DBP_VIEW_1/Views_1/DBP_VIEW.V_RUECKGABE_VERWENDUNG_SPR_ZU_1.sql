CREATE OR REPLACE VIEW DBP_VIEW.V_RUECKGABE_VERWENDUNG_SPR_ZU_1 AS 
    SELECT 
        mandant_id,
        spr_id,
        rueckgabe_verwendung_kz,
        rueckgabe_verwendung_bez
FROM DBP_DATA.RUECKGABE_VERWENDUNG_SPR_ZU_1 ;