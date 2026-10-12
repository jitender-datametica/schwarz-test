CREATE OR REPLACE PROCEDURE dbp_macro.sp_aad_ups_casemanagement_bon(IN p_aad_request_id INT64, IN p_mandant_id INT64, IN p_creator_user_id STRING, OUT out_param STRING)
BEGIN
BEGIN TRANSACTION;

INSERT INTO dbp_msi_data.ts_aad_request_workflow_1 (aad_request_id, mandant_id, dwh_created_tmsp, creation_reason_comment_txt, wup_id, creator_user_id, request_type_id, hashed_cashier_id, request_status_type_id, fraud_value_gross_local_val, wrg_id, expiration_tmsp, scenario_id, scenario_hit_receipts_cnt, request_reason_type_id, comment_txt, first_approver_user_id, second_approver_user_id, approve_by_council_fg, criminal_complain_fg, taken_measure_comment_txt, loss_amount_gross_local_val)
WITH T_LETZTER_EINTRAG AS (SELECT aad_request_id, MAX(dwh_created_tmsp) AS letzter_eintrag
            FROM dbp_msi_data.ts_aad_request_workflow_1
            WHERE aad_request_id = p_aad_request_id AND mandant_id = p_mandant_id
            GROUP BY aad_request_id) (SELECT V01.aad_request_id, V01.mandant_id, CAST(CURRENT_TIMESTAMP() AS DATETIME), V01.creation_reason_comment_txt, V01.wup_id, p_creator_user_id, V01.request_type_id, V01.hashed_cashier_id, V01.request_status_type_id, SUM(V03.fraud_value_gross_local_val) AS fraud_value_gross_local_val, V01.wrg_id, V01.expiration_tmsp, V01.scenario_id, COUNT(V02.bon_id) AS scenario_hit_receipts_cnt, V01.request_reason_type_id, V01.comment_txt, V01.first_approver_user_id, V01.second_approver_user_id, V01.approve_by_council_fg, V01.criminal_complain_fg, V01.taken_measure_comment_txt, V01.loss_amount_gross_local_val
            FROM dbp_msi_data.ts_aad_request_workflow_1 AS V01
                INNER JOIN T_LETZTER_EINTRAG AS v001 ON V01.aad_request_id = v001.aad_request_id AND V01.dwh_created_tmsp = v001.letzter_eintrag
                INNER JOIN dbp_msi_data.ts_aad_request_receipt_zu_1 AS V02 ON V01.aad_request_id = V02.aad_request_id AND V01.mandant_id = V02.mandant_id
                INNER JOIN dbp_view.v_aad_scenario_hit_1 AS V03 ON V02.bon_id = V03.bon_id AND V02.mandant_id = V03.mandant_id AND V02.bon_dat = V03.bon_dat
            WHERE V01.aad_request_id = p_aad_request_id AND V01.mandant_id = p_mandant_id AND (V01.request_status_type_id = 4 OR V01.request_type_id = 0)
            GROUP BY V01.aad_request_id, V01.mandant_id, V01.dwh_created_tmsp, V01.creation_reason_comment_txt, V01.wup_id, V01.request_type_id, V01.hashed_cashier_id, V01.request_status_type_id, V01.wrg_id, V01.expiration_tmsp, V01.scenario_id, V01.request_reason_type_id, V01.comment_txt, V01.first_approver_user_id, V01.second_approver_user_id, V01.approve_by_council_fg, V01.criminal_complain_fg, V01.taken_measure_comment_txt, V01.loss_amount_gross_local_val);
COMMIT TRANSACTION;
SET out_param  =  'Casemangement Bons hinzugefügt';
SELECT out_param;
RETURN;
END;
