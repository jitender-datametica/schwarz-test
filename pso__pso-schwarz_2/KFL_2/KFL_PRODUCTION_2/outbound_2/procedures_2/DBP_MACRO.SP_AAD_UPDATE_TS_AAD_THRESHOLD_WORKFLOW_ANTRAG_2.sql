CREATE OR REPLACE  PROCEDURE    dbp_macro.sp_aad_update_ts_aad_threshold_workflow_antrag(
      IN p_mandant_id INT64,
      IN p_scenario_id INT64,
      IN p_scenario_metric_id INT64,
      IN p_user_id STRING,
      IN p_threshold_request_id INT64,
      IN p_approver_comment_txt STRING,
      IN p_genehmigt_flag INT64,
      OUT out_param STRING)
      BEGIN
        BEGIN TRANSACTION;
        -- Zuerst puefen, ob es sich um ein Ablehnen handelt
        -- Wenn es sich um eine_2 Ablehnung handelt und Begruendung NULL ist wird nichts gemacht
        IF p_genehmigt_flag = 1
  OR p_genehmigt_flag = 0 AND p_approver_comment_txt IS NOT NULL THEN 
  BEGIN 


-- Neue Zeile muss angelegt werden wegen der Historisierung
-- wenn genehmigt wird Status_id = 6
-- wenn abgelehnt wird Status_id = 7
-- sonst bleibt eigentlich die Status_id 5
-- Setzen des Gültig bis Datum
INSERT INTO dbp_msi_data.ts_aad_threshold_workflow_2
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
    approver_comment_txt,
    expiration_tmsp)
    (
      SELECT
        threshold_request_id,
        CAST(CURRENT_TIMESTAMP() AS DATETIME),
        mandant_id,
        region_id,
        scenario_id,
        scenario_metric_id,
        creator_user_id,
        scenario_metric_threshold_init_val,
        scenario_metric_user_val,
        CASE
          WHEN p_genehmigt_flag = 1 THEN 6
          WHEN p_genehmigt_flag = 0 THEN 7
          ELSE 5
          END AS request_status_type_id,
        creation_reason_comment_txt,
        CASE
          WHEN p_approver_comment_txt IS NOT NULL
            THEN p_user_id || ' ' || p_approver_comment_txt
          ELSE p_user_id
          END AS approver_comment_txt,
        CAST(
          CASE
            WHEN p_genehmigt_flag = 1 THEN NULL
            ELSE CURRENT_TIMESTAMP()
            END AS DATETIME)
          AS expiration_tmsp
      FROM dbp_msi_data.ts_aad_threshold_workflow_2
      WHERE
        threshold_request_id = p_threshold_request_id
        AND mandant_id = p_mandant_id
        AND scenario_id = p_scenario_id
        AND scenario_metric_id = p_scenario_metric_id
    );

-- Gueltig bis Zeitstempel wird auf Heute gesetzt
UPDATE dbp_msi_data.ts_aad_threshold_workflow_2
SET
  expiration_tmsp = CAST(CURRENT_TIMESTAMP() AS DATETIME)
WHERE
  threshold_request_id = p_threshold_request_id
  AND mandant_id = p_mandant_id
  AND scenario_id = p_scenario_id
  AND scenario_metric_id = p_scenario_metric_id
  AND request_status_type_id = 5;

COMMIT TRANSACTION;

END;
END IF;

SET out_param = 'Schwellwert Antrag wurde bearbeitet';

SELECT out_param;

RETURN;

END;
