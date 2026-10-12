--aad_request_id INTEGER 



CREATE OR REPLACE PROCEDURE kfl_production_dbp_macro.sp_aad_ins_time_extension_request(IN p_mandant_id INT64, IN p_creation_reason_comment_txt STRING, IN p_wup_id INT64, IN p_creator_user_id STRING, IN p_hashed_cashier_id STRING, IN p_fraud_value_gross_local_val NUMERIC, IN p_wrg_id STRING, IN p_scenario_id INT64, IN p_scenario_hit_receipts_cnt INT64, IN p_request_reason_type_id INT64, IN p_first_approver_user_id STRING, IN p_concat_bon_ids STRING, OUT out_param STRING)
BEGIN
DECLARE v_period BIGNUMERIC;
DECLARE v_aad_request_id INT64;
BEGIN
BEGIN TRANSACTION;
--########### Get the period extension for the given mandant_id
-- CALL SP_GET_CONFIG_PERIOD(:mandant_id, 1) INTO :period;
SET v_period  =  (SELECT DISTINCT config_val
FROM kfl_production_dbp_data.aad_engine_config
WHERE mandant_id = p_mandant_id AND config_id = 1);
-- REQUEST ID ermitteln 
SET v_aad_request_id  =  (SELECT COALESCE(MAX(aad_request_id), 0)
FROM kfl_production_dbp_msi_data.ts_aad_request_workflow);
---- Request erstellen 
--Time Extension period from config
--Validation Exception : Invalid project ID 'KFL_PRODUCTION'. Project IDs must contain 6-63 lowercase letters, digits, or dashes. Some project IDs also include domain name separated by a colon. IDs must start with a letter and may not end with a dash.
INSERT INTO kfl_production_dbp_msi_data.ts_aad_request_workflow (aad_request_id, mandant_id, dwh_created_tmsp, creation_reason_comment_txt, wup_id, creator_user_id, request_type_id, hashed_cashier_id, request_status_type_id, fraud_value_gross_local_val, wrg_id, expiration_tmsp, scenario_id, scenario_hit_receipts_cnt, request_reason_type_id, first_approver_user_id)
(SELECT CAST(v_aad_request_id + 1 AS INTEGER) AS aad_request_id, p_mandant_id AS mandant_id, CAST(CURRENT_TIMESTAMP() AS DATETIME) AS dwh_created_tmsp, p_creation_reason_comment_txt AS creation_reason_comment_txt, p_wup_id AS wup_id, p_creator_user_id AS creator_user_id, 1 AS request_type_id, p_hashed_cashier_id AS hashed_cashier_id, 1 AS request_status_type_id, p_fraud_value_gross_local_val AS fraud_value_gross_local_val, p_wrg_id AS wrg_id, CAST(CURRENT_TIMESTAMP() + INTERVAL 1 DAY * CAST(v_period AS INTEGER) AS DATETIME) AS expiration_tmsp, p_scenario_id AS scenario_id, p_scenario_hit_receipts_cnt AS scenario_hit_receipts_cnt, p_request_reason_type_id AS request_reason_type_id, p_first_approver_user_id AS first_approver_user_id);

-- Bons zu Request hinzufügen 
insert into kfl_production_dbp_msi_data.ts_aad_request_receipt_zu (bon_id, bon_dat, wup_id, mandant_id, aad_request_id)
  select distinct
      bon_id,
      bon_dat,
      wup_id,
      mandant_id,
      v_aad_request_id + 1
    from
      kfl_production_dbp_view.v_aad_scenario_hit
    where mandant_id = p_mandant_id
     and wup_id = p_wup_id
     and hashed_cashier_id = p_hashed_cashier_id
     and bon_id in(
       SELECT value
        FROM UNNEST(SPLIT(p_concat_bon_ids, ',')) AS value
    )
     and scenario_id = p_scenario_id
;


COMMIT TRANSACTION;
SET out_param  =  'Antrag-Zeiterweiterung angelegt';
SELECT out_param;
RETURN;
END;
END;
