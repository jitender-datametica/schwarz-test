CREATE OR REPLACE VIEW DBP_VIEW.V_IN_WARTUNGSPLAN AS 
    SELECT 
        mandant_id
        ,wart_plan_id
        ,wart_plan_bez
        ,wart_plan_sort_id


FROM DBP_DATA.IN_WARTUNGSPLAN ;