CREATE OR REPLACE  PROCEDURE    dbp_macro.sp_aad_ups_cashier_decyrption_2_approver(
      IN p_aad_request_id INT64,
      IN p_genehmight_flag INT64,
      IN p_mandant_id INT64,
      IN p_comment_txt STRING,
      IN p_request_type_id INT64,
      IN p_approver_id STRING,
      IN p_BR_flag INT64,
      OUT out_param STRING)
      BEGIN
        DECLARE v_period INT64;

BEGIN
  -- Wenn genehmigt:
  BEGIN TRANSACTION;

IF p_genehmight_flag = 1
  THEN
    BEGIN
SET
  v_period = (
    SELECT DISTINCT config_val
    FROM dbp_data.aad_engine_config_2
    WHERE mandant_id = p_mandant_id AND config_id = 2
  );

-- Wennn es genehmigt wurden ist vom zweiten Approver
-- muss das Gueltig bis vom Zeitraumerweiterung auch erneut gesetzt werden
UPDATE dbp_msi_data.ts_aad_request_workflow_2
SET
  expiration_tmsp = CAST(
    CURRENT_TIMESTAMP() + INTERVAL 1 DAY * v_period AS DATETIME)
WHERE
  aad_request_id = p_aad_request_id
  AND request_type_id = 1
  AND request_status_type_id = 2;

END;

ELSE SET v_period = 0;

END IF;

-- Neue Zeile Kopieren des Antragsder Genehmigung erste Genehmiger
-- Bedienerentschluesselung
INSERT INTO dbp_msi_data.ts_aad_request_workflow_2
  (
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
    approve_by_council_fg)
    (
      SELECT
        p_aad_request_id,
        p_mandant_id,
        CAST(CURRENT_TIMESTAMP() AS DATETIME),
        creation_reason_comment_txt,
        wup_id,
        creator_user_id,
        p_request_type_id,
        hashed_cashier_id,
        CASE
          WHEN p_genehmight_flag = 1 AND p_request_type_id = 2 THEN 4
          WHEN p_genehmight_flag = 0 AND p_request_type_id = 2 THEN 7
          ELSE request_status_type_id
          END,
        fraud_value_gross_local_val,
        wrg_id,
        CAST(CURRENT_TIMESTAMP() + INTERVAL 1 DAY * v_period AS DATETIME)
          AS day_v_period,
        scenario_id,
        scenario_hit_receipts_cnt,
        request_reason_type_id,
        CASE
          WHEN p_comment_txt <> ''
            THEN comment_txt || ' 2.Genehmiger Kommentar:' || p_comment_txt
          ELSE comment_txt
          END,
        first_approver_user_id,
        p_approver_id,
        p_BR_flag
      FROM dbp_msi_data.ts_aad_request_workflow_2
      WHERE
        aad_request_id = p_aad_request_id
        AND request_type_id = p_request_type_id
        AND request_status_type_id = 12
    );

-- Genehmigung des ersten Genehmiger Gueltig bis auf heute setzen
-- vom ersten genehmigt
UPDATE dbp_msi_data.ts_aad_request_workflow_2
SET
  expiration_tmsp = CAST(CURRENT_TIMESTAMP() AS DATETIME)
WHERE
  aad_request_id = p_aad_request_id
  AND request_type_id = p_request_type_id
  AND request_status_type_id = 12;

COMMIT TRANSACTION;

SET out_param = 'Antrag vom zweiten Approver bearbeitet';

SELECT out_param;

RETURN;

END;
END;
