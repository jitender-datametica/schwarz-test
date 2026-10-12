CREATE OR REPLACE VIEW DBP_VIEW.V_LIN_KURS_SPR_ZU AS 
    SELECT 
        lin_kurs_id,
        spr_id,
        mandant_id,
        lin_bericht,
        lin_kurs_bez

FROM DBP_DATA.LIN_KURS_SPR_ZU ;