CREATE OR REPLACE VIEW DBP_VIEW.V_IN_WARTUNGSPLAN_STATUS_PER AS 
    SELECT 
        mandant_id,
        wart_plan_id,
        wart_plan_status_id,
        status_fg,
        dat_von,
        dat_bis

FROM DBP_DATA.IN_WARTUNGSPLAN_STATUS_PER ;