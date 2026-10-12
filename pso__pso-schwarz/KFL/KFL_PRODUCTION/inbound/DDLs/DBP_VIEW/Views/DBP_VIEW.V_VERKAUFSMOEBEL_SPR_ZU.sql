CREATE OR REPLACE VIEW DBP_VIEW.V_VERKAUFSMOEBEL_SPR_ZU AS 
    SELECT 
        mandant_id,
        verkaufsmoebel_id,
        spr_id,
        verkaufsmoebel_bez
FROM DBP_DATA.VERKAUFSMOEBEL_SPR_ZU ;