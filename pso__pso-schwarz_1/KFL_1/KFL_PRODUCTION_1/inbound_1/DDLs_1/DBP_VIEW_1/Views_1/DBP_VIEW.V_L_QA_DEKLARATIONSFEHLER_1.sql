CREATE OR REPLACE VIEW DBP_VIEW.V_L_QA_DEKLARATIONSFEHLER_1 AS 
    SELECT 
        mandant_id,
        qa_deklarationsfehler_id,
        aktiv_fg,
        pflanzen_fg

FROM DBP_DATA.L_QA_DEKLARATIONSFEHLER_1 ;