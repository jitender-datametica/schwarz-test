CREATE OR REPLACE PROCEDURE dbp_macro.sp_aad_update_workflow_metrics(p_aad_request_id INT64, p_mandant_id INT64, p_scenario_hit_receipts_cnt INT64, p_fraud_value_gross_local_val NUMERIC, OUT return_value STRING)
  BEGIN
    UPDATE kfl_production_dbp_msi_data.ts_aad_request_workflow SET scenario_hit_receipts_cnt = p_scenario_hit_receipts_cnt, fraud_value_gross_local_val = p_fraud_value_gross_local_val WHERE ts_aad_request_workflow.aad_request_id = p_aad_request_id
     AND ts_aad_request_workflow.mandant_id = p_mandant_id;
    SET return_value = concat('Successfully updated all records for request ID: ', CAST(p_aad_request_id as STRING));
    RETURN;
  END;
