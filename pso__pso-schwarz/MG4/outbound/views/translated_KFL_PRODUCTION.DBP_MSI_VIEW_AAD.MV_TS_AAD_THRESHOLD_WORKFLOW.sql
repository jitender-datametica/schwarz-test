-- 30.06.2023 staeblern initale Erstellung
 CREATE OR REPLACE VIEW dbp_msi_view_aad.mv_ts_aad_threshold_workflow AS WITH
 t_threshold_verlauf AS (SELECT threshold_request_id,
   dwh_created_tmsp,
   RANK() OVER (PARTITION BY threshold_request_id ORDER BY dwh_created_tmsp IS NULL DESC, dwh_created_tmsp DESC) AS
   threshold_verlauf
  FROM kfl_production_dbp_msi_data.ts_aad_threshold_workflow) (SELECT v01.mandant_id,
   v01.region_id,
   v01.scenario_id,
   v01.scenario_metric_id,
   v01.threshold_request_id,
   v01.scenario_metric_threshold_init_val,
   v01.scenario_metric_user_val,
   v01.creator_user_id,
   v01.creation_reason_comment_txt,
   v01.request_status_type_id,
   v01.approver_comment_txt,
   v01.expiration_tmsp,
   v01.dwh_created_tmsp,
    CASE
    WHEN v01.request_status_type_id -- Genehmigt
 = 6
    THEN 1 -- abgelehnt

    WHEN v01.request_status_type_id = 7
    THEN 0 -- SONST

    ELSE NULL
    END AS genehmigt_flag,
   v02.threshold_verlauf,
    CASE
    WHEN v01.request_status_type_id = 5 AND v02.threshold_verlauf = 1
    THEN 1
    ELSE 0
    END AS offener_antrag_flag
  FROM kfl_production_dbp_msi_data.ts_aad_threshold_workflow AS v01
   INNER JOIN t_threshold_verlauf AS v02 ON v01.threshold_request_id = v02.threshold_request_id AND v01.dwh_created_tmsp
      = v02.dwh_created_tmsp);