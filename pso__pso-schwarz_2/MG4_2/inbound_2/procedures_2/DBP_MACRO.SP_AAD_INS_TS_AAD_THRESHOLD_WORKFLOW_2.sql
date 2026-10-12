CREATE OR REPLACE PROCEDURE DBP_MACRO.SP_AAD_INS_TS_AAD_THRESHOLD_WORKFLOW
(
	p_mandant_id NUMBER(38,0)
	,p_scenario_id NUMBER(38,0)
	,p_scenario_metric_id NUMBER(38,0)
	,p_user_id VARCHAR(100)
	,p_scenario_metric_user_val NUMBER (38,0)
    ,p_creation_reason_comment_txt VARCHAR
    ,p_SCENARIO_METRIC_THRESHOLD_INIT_VAL NUMBER (38,0)
    ,p_region NUMBER (38,0)
)
RETURNS VARCHAR
LANGUAGE SQL
AS
$$
DECLARE 
	v_threshold_request_id NUMBER;

BEGIN
    -- ermittlung der Antragsid 
    SELECT COALESCE(MAX(threshold_request_id),0) INTO :v_threshold_request_id
    FROM DBP_MSI_DATA.ts_aad_threshold_workflow_2;

    INSERT INTO DBP_MSI_DATA.ts_aad_threshold_workflow_2(
                THRESHOLD_REQUEST_ID
                ,DWH_CREATED_TMSP
                ,MANDANT_ID
                ,SCENARIO_ID
                ,SCENARIO_METRIC_ID
                ,CREATOR_USER_ID
                ,SCENARIO_METRIC_USER_VAL
                ,CREATION_REASON_COMMENT_TXT
                ,REGION_ID
                ,REQUEST_STATUS_TYPE_ID
                ,SCENARIO_METRIC_THRESHOLD_INIT_VAL
                ,EXPIRATION_TMSP
                )
    VALUES (
            :v_threshold_request_id+1
            ,CURRENT_TIMESTAMP
            ,:P_MANDANT_ID
            ,:P_SCENARIO_ID
            ,:P_SCENARIO_METRIC_ID
            ,:p_user_id
            ,:P_SCENARIO_METRIC_USER_VAL
            ,:P_CREATION_REASON_COMMENT_TXT
            ,:P_REGION
            ,5
            ,:p_SCENARIO_METRIC_THRESHOLD_INIT_VAL
            , DATEADD(DAY, 14, CURRENT_TIMESTAMP)
    
    );

    COMMIT;
	
    RETURN 'Schwellwert Antrag angelegt';

END;
$$;