CREATE OR REPLACE VIEW DBP_VIEW.V_WBS_ART_AKTION_KORRIGIERTE_MENGE_1 AS 
    SELECT 
        mandant_id
        ,wup_id
        ,nb_id
        ,art_id
        ,dat_von_aktion
        ,dat_bis_aktion
        ,zeitraum_korrigierte_menge


FROM DBP_DATA.wbs_art_aktion_korrigierte_menge_1 ;