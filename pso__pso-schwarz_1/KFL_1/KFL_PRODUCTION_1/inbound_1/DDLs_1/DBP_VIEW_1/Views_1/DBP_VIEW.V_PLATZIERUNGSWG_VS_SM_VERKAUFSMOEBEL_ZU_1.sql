CREATE OR REPLACE VIEW DBP_VIEW.V_PLATZIERUNGSWG_VS_SM_VERKAUFSMOEBEL_ZU_1 AS 
    SELECT 
        mandant_id,
        platzierungswg_id,
        vs_id,
        sm_id,
        verkaufsmoebel_id,
        menge_soll_flaeche,
        flaeche_einh_id
FROM DBP_DATA.PLATZIERUNGSWG_VS_SM_VERKAUFSMOEBEL_ZU_1 ;