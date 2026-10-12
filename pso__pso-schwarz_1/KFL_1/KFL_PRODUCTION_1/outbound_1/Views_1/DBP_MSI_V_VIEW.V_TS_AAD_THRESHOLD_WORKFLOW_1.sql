CREATE OR REPLACE VIEW kfl_production_dbp_msi_v_view.v_ts_aad_threshold_workflow_1 AS SELECT threshold_request_id,
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
FROM kfl_production_dbp_msi_data.ts_aad_threshold_workflow_1;