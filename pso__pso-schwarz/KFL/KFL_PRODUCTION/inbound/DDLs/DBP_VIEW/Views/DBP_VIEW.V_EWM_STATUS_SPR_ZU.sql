CREATE OR REPLACE VIEW DBP_VIEW.V_ewm_status_spr_zu AS 
    SELECT 
        status_id,
        spr_id,
        status_schema_id,
        status_kbez,
        status_bez,
        td_update,
        td_insert
FROM DBP_DATA.ewm_status_spr_zu ;