CREATE OR REPLACE VIEW DBP_VIEW.V_T_FACT_IOT_ERRORMESSAGES AS 
    SELECT 
        mandant_id
        ,wup_id
        ,device_id
        ,fault_nr
        ,cal_dt
        ,measurement_tmsp
        ,device_type_id
        ,alarm_priority_cd
        ,error_source
        ,error_message
        ,value_cycling
        ,active_fg
FROM DBP_DATA.t_fact_iot_errormessages ;