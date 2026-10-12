CREATE OR REPLACE VIEW DBP_VIEW.V_TS_WBS_VZ_TAG AS 
    SELECT 
        mandant_id,
        wup_id,
        nb_id,
        dat,
        non_adjustable_day_fg,
        kommentar

FROM DBP_DATA.TS_WBS_VZ_TAG ;