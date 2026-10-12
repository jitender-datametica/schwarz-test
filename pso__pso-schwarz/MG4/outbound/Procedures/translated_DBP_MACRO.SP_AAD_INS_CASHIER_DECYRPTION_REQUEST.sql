CREATE OR REPLACE PROCEDURE kfl_production_dbp_macro.sp_aad_ins_cashier_decyrption_request(IN p_aad_request_id INT64, IN p_mandant_id INT64, IN p_creator_user_id STRING, IN p_request_reason_type_id INT64, IN p_comment_txt STRING, IN p_second_approver_user_id STRING, IN p_scenario_hit_receipts_cnt INT64, IN p_fraud_value_gross_local_val NUMERIC, OUT out_param STRING)
BEGIN
DECLARE v_period BIGNUMERIC;
DECLARE v_max_request_status BIGNUMERIC;
BEGIN
--########### Check if the time extension for the request have been approved or are still alived ######################
SET v_max_request_status  =  (SELECT MAX(request_status_type_id)
FROM kfl_production_dbp_msi_data.ts_aad_request_workflow
WHERE aad_request_id = p_aad_request_id);
--########### decryption request only if the time_extension approved (request_status_type_id=2) ######################

IF v_max_request_status = 2 THEN
    BEGIN
    --########### Get the period extension for the given mandant_id###################################
    SET v_period  =  (SELECT DISTINCT config_val
FROM kfl_production_dbp_data.aad_engine_config
WHERE mandant_id = p_mandant_id AND config_id = 2);
    --##########ADD new Row for History: Copy time extension request  ################################ 
INSERT INTO kfl_production_dbp_msi_data.ts_aad_request_workflow (aad_request_id, mandant_id, dwh_created_tmsp, creation_reason_comment_txt, wup_id, creator_user_id, request_type_id, hashed_cashier_id, request_status_type_id, fraud_value_gross_local_val, wrg_id, expiration_tmsp, scenario_id, scenario_hit_receipts_cnt, request_reason_type_id, first_approver_user_id, second_approver_user_id)
SELECT p_aad_request_id, p_mandant_id, CAST(CURRENT_TIMESTAMP() AS DATETIME), p_comment_txt, wup_id, p_creator_user_id, 2, hashed_cashier_id, 3, p_fraud_value_gross_local_val, wrg_id, CAST(CURRENT_TIMESTAMP() + INTERVAL 1 DAY * CAST(v_period AS INTEGER) AS DATETIME) AS day_v_period, scenario_id, p_scenario_hit_receipts_cnt, p_request_reason_type_id, first_approver_user_id, p_second_approver_user_id
    FROM kfl_production_dbp_msi_data.ts_aad_request_workflow
    WHERE aad_request_id = p_aad_request_id AND request_type_id = 1 AND request_status_type_id = 2;

    COMMIT TRANSACTION;
    END;
END IF;

SET out_param  =  'Bedienerentschluesselungsantrag wurde angelegt';
SELECT out_param;
RETURN;
END;
END;
