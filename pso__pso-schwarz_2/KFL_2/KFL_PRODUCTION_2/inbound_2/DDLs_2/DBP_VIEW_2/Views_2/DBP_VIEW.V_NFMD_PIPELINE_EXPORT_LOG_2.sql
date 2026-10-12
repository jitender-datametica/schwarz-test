CREATE OR REPLACE VIEW DBP_VIEW.V_NFMD_PIPELINE_EXPORT_LOG_2 AS 
    SELECT 
        mandant_id
        ,execution_year
        ,execution_week
        ,sent_rows_cnt
        ,environment_name
        ,erp_guid
        ,execution_tmsp


FROM DBP_DATA.nfmd_pipeline_export_log_2 ;