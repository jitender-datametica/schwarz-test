CREATE OR REPLACE  PROCEDURE    dbp_macro.sp_aad_ups_casemanagement(
      IN p_aad_request_id INT64,
      IN p_mandant_id INT64,
      IN p_creator_user_id STRING,
      IN p_criminal_complain_fg INT64,
      IN p_taken_measure_comment_txt STRING,
      IN p_loss_amount_gross_local_val NUMERIC,
      IN p_request_status_type_id INT64,
      IN p_casemanagement_vorhanden_fg INT64,
      OUT out_param STRING)
      BEGIN
        BEGIN TRANSACTION;

IF p_casemanagement_vorhanden_fg = 0
  THEN
    BEGIN
      -- Zusammenfassung erstellen
      INSERT INTO dbp_msi_data.ts_aad_request_workflow(
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
        approve_by_council_fg,
        criminal_complain_fg,
        taken_measure_comment_txt,
        loss_amount_gross_local_val)
        WITH
          T_LETZTER_EINTRAG AS (
              SELECT aad_request_id, MAX(dwh_created_tmsp) AS letzter_eintrag
              FROM dbp_msi_data.ts_aad_request_workflow
              WHERE
                aad_request_id = p_aad_request_id AND mandant_id = p_mandant_id
              GROUP BY aad_request_id
            )
              (
                SELECT
                  V01.aad_request_id,
                  V01.mandant_id,
                  CAST(CURRENT_TIMESTAMP() AS DATETIME),
                  V01.creation_reason_comment_txt,
                  V01.wup_id,
                  p_creator_user_id,
                  0,
                  V01.hashed_cashier_id,
                  p_request_status_type_id,
                  V01.fraud_value_gross_local_val,
                  V01.wrg_id,
                  V01.expiration_tmsp,
                  V01.scenario_id,
                  V01.scenario_hit_receipts_cnt,
                  0,
                  V01.comment_txt,
                  V01.first_approver_user_id,
                  V01.second_approver_user_id,
                  V01.approve_by_council_fg,
                  p_criminal_complain_fg,
                  p_taken_measure_comment_txt,
                  p_loss_amount_gross_local_val
                FROM dbp_msi_data.ts_aad_request_workflow AS V01
                INNER JOIN T_LETZTER_EINTRAG AS v02
                  ON
                    V01.aad_request_id = v02.aad_request_id
                    AND V01.dwh_created_tmsp = v02.letzter_eintrag
                WHERE
                  V01.aad_request_id = p_aad_request_id
                  AND V01.mandant_id = p_mandant_id
                  AND V01.request_status_type_id = 4
              );

-- Status dass die Entschuesselung durch ist
END;

ELSE
  BEGIN
    -- Neue Zeile
    INSERT INTO dbp_msi_data.ts_aad_request_workflow(
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
      approve_by_council_fg,
      criminal_complain_fg,
      taken_measure_comment_txt,
      loss_amount_gross_local_val)
      WITH
        T_LETZTER_EINTRAG AS (
            SELECT aad_request_id, MAX(dwh_created_tmsp) AS letzter_eintrag
            FROM dbp_msi_data.ts_aad_request_workflow
            WHERE
              aad_request_id = p_aad_request_id AND mandant_id = p_mandant_id
            GROUP BY aad_request_id
          )
            (
              SELECT
                V01.aad_request_id,
                V01.mandant_id,
                CAST(CURRENT_TIMESTAMP() AS DATETIME),
                V01.creation_reason_comment_txt,
                V01.wup_id,
                p_creator_user_id,
                V01.request_type_id,
                V01.hashed_cashier_id,
                V01.request_status_type_id,
                V01.fraud_value_gross_local_val,
                V01.wrg_id,
                V01.expiration_tmsp,
                V01.scenario_id,
                V01.scenario_hit_receipts_cnt,
                V01.request_reason_type_id,
                V01.comment_txt,
                V01.first_approver_user_id,
                V01.second_approver_user_id,
                V01.approve_by_council_fg,
                p_criminal_complain_fg,
                p_taken_measure_comment_txt,
                p_loss_amount_gross_local_val
              FROM dbp_msi_data.ts_aad_request_workflow AS V01
              INNER JOIN T_LETZTER_EINTRAG AS v02
                ON
                  V01.aad_request_id = v02.aad_request_id
                  AND V01.dwh_created_tmsp = v02.letzter_eintrag
              WHERE
                V01.aad_request_id = p_aad_request_id
                AND V01.mandant_id = p_mandant_id
                AND V01.request_type_id = 0
            );

-- Status dass der Antrag schon abgeschlossen ist.
END;
END IF;

COMMIT TRANSACTION;

SET out_param = 'Casemangement Zusammenfassung angelegt';

SELECT out_param;

RETURN;

END;
