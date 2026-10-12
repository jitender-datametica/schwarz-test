CREATE OR REPLACE VIEW DBP_VIEW.V_WUP_TAG_WBS_SETTING_2 AS 
    SELECT 
        mandant_id,
        wup_id,
        nb_id,
        dat,
        non_adjustable_day_fg
		
FROM DBP_DATA.WUP_TAG_WBS_SETTING_2 ;