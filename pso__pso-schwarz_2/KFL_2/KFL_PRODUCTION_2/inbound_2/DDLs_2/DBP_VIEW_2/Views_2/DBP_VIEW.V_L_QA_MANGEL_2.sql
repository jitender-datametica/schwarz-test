CREATE OR REPLACE VIEW DBP_VIEW.V_L_QA_MANGEL_2 AS 
    SELECT 
        mandant_id,
        qa_mangel_id,
        pflanzen_fg,
        qa_prio,
        frischemangel_fg

FROM DBP_DATA.L_QA_MANGEL_2 ;