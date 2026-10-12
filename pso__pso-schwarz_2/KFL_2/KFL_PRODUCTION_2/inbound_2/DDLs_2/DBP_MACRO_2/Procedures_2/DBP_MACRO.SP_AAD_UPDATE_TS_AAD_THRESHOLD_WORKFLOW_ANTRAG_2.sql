CREATE OR REPLACE PROCEDURE DBP_MACRO.SP_AAD_UPDATE_TS_AAD_THRESHOLD_WORKFLOW_ANTRAG
(
	p_mandant_id NUMBER(38,0)
	,p_scenario_id NUMBER(38,0)
	,p_scenario_metric_id NUMBER(38,0)
	,p_user_id VARCHAR(100)
	,p_threshold_request_id NUMBER (38,0)
    ,p_approver_comment_txt VARCHAR
    ,p_genehmigt_flag NUMBER (38,0)
)
RETURNS VARCHAR
LANGUAGE SQL
AS
$$
BEGIN
-- Zuerst puefen, ob es sich um ein Ablehnen handelt
-- Wenn es sich um eine_2 Ablehnung handelt und Begruendung NULL ist wird nichts gemacht 
IF (:p_genehmigt_flag = 1 OR (:p_genehmigt_flag = 0 AND :p_approver_comment_txt IS NOT NULL)) THEN 
-- Neue Zeile muss angelegt werden wegen der Historisierung 
    INSERT INTO DBP_MSI_DATA.ts_aad_threshold_workflow_2 
        (THRESHOLD_REQUEST_ID,
        DWH_CREATED_TMSP,
        MANDANT_ID,
        REGION_ID,
        SCENARIO_ID,
        SCENARIO_METRIC_ID,
        CREATOR_USER_ID,
        SCENARIO_METRIC_THRESHOLD_INIT_VAL,
        SCENARIO_METRIC_USER_VAL,
        REQUEST_STATUS_TYPE_ID,
        CREATION_REASON_COMMENT_TXT,
        APPROVER_COMMENT_TXT,
        EXPIRATION_TMSP
        )
    SELECT THRESHOLD_REQUEST_ID,
            CURRENT_TIMESTAMP(),
            MANDANT_ID,
            REGION_ID,
            SCENARIO_ID,
            SCENARIO_METRIC_ID,
            CREATOR_USER_ID,
            SCENARIO_METRIC_THRESHOLD_INIT_VAL,
            SCENARIO_METRIC_USER_VAL,
            CASE :p_genehmigt_flag 
                -- wenn genehmigt wird Status_id = 6
                WHEN 1 THEN 6 
                -- wenn abgelehnt wird Status_id = 7
                WHEN 0 THEN 7 
                -- sonst bleibt eigentlich die Status_id 5 
                ELSE 5 END AS REQUEST_STATUS_TYPE_ID,
            CREATION_REASON_COMMENT_TXT,
            CASE WHEN :P_approver_comment_txt IS NOT NULL THEN 
            :p_user_id || ' ' || :P_approver_comment_txt
            ELSE 
            :p_user_id
            END 
            AS APPROVER_COMMENT_TXT,
            -- Setzen des Gültig bis Datum 
            CASE WHEN :P_genehmigt_flag = 1 THEN NULL  ELSE CURRENT_TIMESTAMP() END AS EXPIRATION_TMSP

    FROM DBP_MSI_DATA.ts_aad_threshold_workflow_2
    WHERE THRESHOLD_REQUEST_ID = :p_threshold_request_id
        AND MANDANT_ID = :P_MANDANT_ID
        AND SCENARIO_ID = :P_SCENARIO_ID
        AND SCENARIO_METRIC_ID = :P_SCENARIO_METRIC_ID;
       
    -- Gueltig bis Zeitstempel wird auf Heute gesetzt 
    UPDATE DBP_MSI_DATA.ts_aad_threshold_workflow_2
    SET EXPIRATION_TMSP = CURRENT_TIMESTAMP()
    WHERE THRESHOLD_REQUEST_ID = :p_threshold_request_id
        AND MANDANT_ID = :P_MANDANT_ID
        AND SCENARIO_ID = :P_SCENARIO_ID
        AND SCENARIO_METRIC_ID = :P_SCENARIO_METRIC_ID
        AND REQUEST_STATUS_TYPE_ID = 5;
    

    COMMIT;
END IF;		
    RETURN 'Schwellwert Antrag wurde bearbeitet';

END;
$$;