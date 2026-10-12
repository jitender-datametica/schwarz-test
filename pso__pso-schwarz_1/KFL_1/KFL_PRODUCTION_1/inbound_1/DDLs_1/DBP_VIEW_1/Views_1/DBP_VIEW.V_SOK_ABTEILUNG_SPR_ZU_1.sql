CREATE OR REPLACE VIEW DBP_VIEW.V_SOK_ABTEILUNG_SPR_ZU_1 AS 
    SELECT 
        mandant_id,
        sok_abteilung_id,
        spr_id,
        sok_abteilung_bez
FROM DBP_DATA.SOK_ABTEILUNG_SPR_ZU_1 ;