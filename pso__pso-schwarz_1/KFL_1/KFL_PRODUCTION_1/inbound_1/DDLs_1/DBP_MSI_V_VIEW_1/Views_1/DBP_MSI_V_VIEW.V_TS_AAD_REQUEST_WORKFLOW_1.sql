CREATE OR REPLACE VIEW DBP_MSI_V_VIEW.V_TS_AAD_REQUEST_WORKFLOW_1 AS 
    SELECT 
        aad_request_id,
        mandant_id,
        dwh_created_tmsp,
        creation_reason_comment_txt,
        wup_id,
        creator_user_id,
        request_type_id,
        hashed_cashier_id,
        request_status_type_id,
        fraud_value_gross_local_val,
        wrg_id,
        expiration_tmsp,
        scenario_id,
        scenario_hit_receipts_cnt,
        request_reason_type_id,
        comment_txt,
        first_approver_user_id,
        second_approver_user_id,
        approve_by_council_fg,
        criminal_complain_fg,
        taken_measure_comment_txt,
        loss_amount_gross_local_val

FROM DBP_MSI_DATA.TS_AAD_REQUEST_WORKFLOW_1 ;