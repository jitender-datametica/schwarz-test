CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_aad.mv_ts_aad_threshold_workflow_1 AS WITH T_THRESHOLD_VERLAUF AS (SELECT
   threshold_request_id,
   dwh_created_tmsp,
   RANK() OVER (PARTITION BY CAST(threshold_request_id AS STRING) ORDER BY dwh_created_tmsp IS NULL DESC,
      dwh_created_tmsp DESC) AS threshold_verlauf
  FROM kfl_production_dbp_msi_data.ts_aad_threshold_workflow_1) (SELECT V01.mandant_id,
   V01.region_id,
   V01.scenario_id,
   V01.scenario_metric_id,
   V01.threshold_request_id,
   V01.scenario_metric_threshold_init_val,
   V01.scenario_metric_user_val,
   V01.creator_user_id,
   V01.creation_reason_comment_txt,
   V01.request_status_type_id,
   V01.approver_comment_txt,
   V01.expiration_tmsp,
   V01.dwh_created_tmsp,
    CASE
    WHEN V01.request_status_type_id = 6
    THEN 1
    WHEN V01.request_status_type_id = 7
    THEN 0
    ELSE NULL
    END AS genehmigt_flag,
   v02.threshold_verlauf,
    CASE
    WHEN V01.request_status_type_id = 5 AND v02.threshold_verlauf = 1
    THEN 1
    ELSE 0
    END AS offener_antrag_flag
  FROM kfl_production_dbp_msi_data.ts_aad_threshold_workflow_1 AS V01
   INNER JOIN T_THRESHOLD_VERLAUF AS v02 ON V01.threshold_request_id = v02.threshold_request_id AND V01.dwh_created_tmsp
      = v02.dwh_created_tmsp);