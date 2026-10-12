CREATE OR REPLACE VIEW DBP_VIEW.V_WBS_L_MANDANT_ZEITSLOTS_2 AS 
    SELECT 
        mandant_id
        ,zeitslot_id
        ,zeitslot_bez


FROM DBP_DATA.wbs_l_mandant_zeitslots_2 ;