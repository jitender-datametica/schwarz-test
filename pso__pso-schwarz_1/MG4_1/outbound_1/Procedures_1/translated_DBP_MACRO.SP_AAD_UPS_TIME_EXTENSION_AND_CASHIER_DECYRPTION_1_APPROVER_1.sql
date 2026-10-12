CREATE OR REPLACE PROCEDURE kfl_production_dbp_macro.sp_aad_ups_time_extension_and_cashier_decyrption_1_approver(IN p_aad_request_id INT64, 
    IN p_genehmight_flag INT64, 
    IN p_mandant_id INT64, 
    IN p_comment_txt STRING, 
    IN p_request_type_id INT64, 
    IN p_approver_id STRING, 
    OUT out_param STRING
)

BEGIN
    DECLARE  v_period BIGNUMERIC;
    BEGIN
        -- Wenn genehmigt: 

        IF p_genehmight_flag = 1 AND p_request_type_id = 1 THEN
            BEGIN
            -- Wenn Zeitraumerweiterung genehmigt wird 
            SET v_period  =  (SELECT DISTINCT config_val FROM kfl_production_dbp_data.aad_engine_config_1
                                WHERE mandant_id = p_mandant_id AND config_id = 1);
            -- bei ablehnen & erste Genehmigung Bediener wird das heutige Datum verwenden 
            END;
         ELSE SET v_period  =  0;
        END IF;

            ---Neuer Status_1 neuer Eintrag in die Tabelle 
            -- Zeiterweiterung
            -- Bedienerentschluesselung 
            --  Bedienernetschluesselung genehmigt wird Gueltig bis vom Antrag uebernommen 
            --Validation Exception : Unrecognized name: default_value at [2:146]
            INSERT INTO kfl_production_dbp_msi_data.ts_aad_request_workflow_1 (aad_request_id, 
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
                second_approver_user_id)
              (SELECT p_aad_request_id, 
               p_mandant_id, 
               CAST(CURRENT_TIMESTAMP() AS DATETIME), 
               creation_reason_comment_txt, 
               wup_id, 
               creator_user_id, 
               p_request_type_id, 
               hashed_cashier_id, 
               CASE WHEN p_genehmight_flag = 1 AND p_request_type_id = 1 THEN 2 
                    WHEN p_genehmight_flag = 1 AND p_request_type_id = 2 THEN 12 ELSE 7 END, 
               fraud_value_gross_local_val, 
               wrg_id, 
               CAST(CASE WHEN p_genehmight_flag = 1 AND p_request_type_id = 2 THEN CAST(expiration_tmsp AS TIMESTAMP) 
                    ELSE CURRENT_TIMESTAMP() + INTERVAL 1 DAY * CAST(v_period AS INTEGER) END AS DATETIME), 
               scenario_id, 
               scenario_hit_receipts_cnt, 
               request_reason_type_id, 
               p_comment_txt, 
               p_approver_id, 
               second_approver_user_id
              FROM kfl_production_dbp_msi_data.ts_aad_request_workflow_1
              WHERE aad_request_id = p_aad_request_id AND request_type_id = p_request_type_id);

              -- Antraege wird das Gueltig bis abgeaendert auf den heutigen Tag_1 
              UPDATE kfl_production_dbp_msi_data.ts_aad_request_workflow_1 
              SET expiration_tmsp = CAST(CURRENT_TIMESTAMP() AS DATETIME)
              WHERE aad_request_id = p_aad_request_id 
              AND request_type_id = p_request_type_id 
              AND request_status_type_id IN (1, 3);
              --   Antragstellungsid Zeiterweiterung / Bedienerentschluesselung            
            COMMIT TRANSACTION;
        SET out_param  =  'Antrag vom ersten Approver bearbeitet';
        SELECT out_param;
        RETURN;
    END;
END;
