CREATE OR REPLACE VIEW DBP_VIEW.V_IN_WARTUNGSPLAN_HIST_1 AS 
    SELECT 
        mandant_id
        ,wart_plan_id
        ,wart_plan_abruf_id
        ,wart_plan_abruf_zaehler
        ,dat_plan
        ,wart_plan_terminierungsart
        ,dat_start
        ,dat_erledigung
        ,dat_abruf


FROM DBP_DATA.IN_WARTUNGSPLAN_HIST_1 ;