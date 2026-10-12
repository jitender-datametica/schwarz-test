CREATE OR REPLACE  PROCEDURE    dbp_macro.sp_aad_ins_ts_aad_threshold_workflow(
      IN p_mandant_id INT64,
      IN p_scenario_id INT64,
      IN p_scenario_metric_id INT64,
      IN p_user_id STRING,
      IN p_scenario_metric_user_val INT64,
      IN p_creation_reason_comment_txt STRING,
      IN p_SCENARIO_METRIC_THRESHOLD_INIT_VAL INT64,
      IN p_region INT64,
      OUT out_param STRING)
      BEGIN
        DECLARE v_threshold_request_id INT64;

BEGIN
  BEGIN TRANSACTION;

-- ermittlung der Antragsid
SET v_threshold_request_id = (
  SELECT COALESCE(MAX(threshold_request_id), 0)
  FROM dbp_msi_data.ts_aad_threshold_workflow
);

INSERT INTO dbp_msi_data.ts_aad_threshold_workflow
  (
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
    expiration_tmsp)
    (
      SELECT
        v_threshold_request_id + 1 AS threshold_request_id,
        CAST(CURRENT_TIMESTAMP() AS DATETIME) AS dwh_created_tmsp,
        p_mandant_id AS mandant_id,
        p_region AS region_id,
        p_scenario_id AS scenario_id,
        p_scenario_metric_id AS scenario_metric_id,
        p_user_id AS creator_user_id,
        p_SCENARIO_METRIC_THRESHOLD_INIT_VAL
          AS scenario_metric_threshold_init_val,
        p_scenario_metric_user_val AS scenario_metric_user_val,
        5 AS request_status_type_id,
        p_creation_reason_comment_txt AS creation_reason_comment_txt,
        CAST(CURRENT_TIMESTAMP() + INTERVAL 14 DAY AS DATETIME)
          AS expiration_tmsp
    );

COMMIT TRANSACTION;

SET out_param = 'Schwellwert Antrag angelegt';

SELECT out_param;

RETURN;

END;
END;
