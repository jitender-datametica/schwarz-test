CREATE OR REPLACE VIEW DBP_MSI_V_VIEW.V_TS_AAD_THRESHOLD_WORKFLOW AS 
    SELECT 
        threshold_request_id,
        dwh_created_tmsp,
        mandant_id,
        region_id,
        scenario_id,
        scenario_metric_id,
        creator_user_id,
        scenario_metric_threshold_init_val,
        scenario_metric_user_val,
        request_status_type_id,
        creation_reason_comment_txt,
        approver_comment_txt,
        expiration_tmsp

FROM DBP_MSI_DATA.TS_AAD_THRESHOLD_WORKFLOW ;