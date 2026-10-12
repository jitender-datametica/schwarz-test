CREATE OR REPLACE PROCEDURE DBP_MACRO.SP_AAD_INS_CASHIER_DECYRPTION_REQUEST
(
     p_aad_request_id NUMBER(38,0)
	,p_mandant_id NUMBER(38,0)
    ,p_creator_user_id VARCHAR(250)
    ,p_request_reason_type_id NUMBER(38,0)
    ,p_comment_txt VARCHAR(250)
    ,p_second_approver_user_id VARCHAR(250)
    ,p_scenario_hit_receipts_cnt NUMBER(38,0)
    ,p_fraud_value_gross_local_val NUMBER(18,4)

)
RETURNS VARCHAR
LANGUAGE SQL
AS
$$

DECLARE 
	v_period NUMBER;
	v_max_request_status NUMBER;
BEGIN


    --########### Check if the time extension for the request have been approved or are still alived ######################
	SELECT MAX(request_status_type_id) INTO :v_max_request_status
	FROM DBP_MSI_DATA.TS_AAD_REQUEST_WORKFLOW_2
    WHERE
		aad_request_id = :p_aad_request_id;
      
	 --########### decryption request only if the time_extension approved (request_status_type_id=2) ######################
	IF(:v_max_request_status = 2) THEN
		--########### Get the period extension for the given mandant_id###################################
		SELECT DISTINCT
		config_val
        INTO :v_period
    	FROM 		
    		DBp_DATa.AAD_ENGINE_CONFIG_2
        WHERE 
    		mandant_id = :p_mandant_id
    	AND
    		config_id = 2; 

		--##########ADD new Row for History: Copy time extension request  ################################ 
		 INSERT INTO DBP_MSI_DATA.TS_AAD_REQUEST_WORKFLOW_2
             (AAD_REQUEST_ID,
             MANDANT_ID,
             DWH_CREATED_TMSP,
             CREATION_REASON_COMMENT_TXT,
             WUP_ID,
             CREATOR_USER_ID,
             REQUEST_TYPE_ID,
             HASHED_CASHIER_ID,
             REQUEST_STATUS_TYPE_ID,
             FRAUD_VALUE_GROSS_LOCAL_VAL,
             WRG_ID,
             EXPIRATION_TMSP,
             SCENARIO_ID,
             SCENARIO_HIT_RECEIPTS_CNT,
             REQUEST_REASON_TYPE_ID, 
             FIRST_APPROVER_USER_ID,
             SECOND_APPROVER_USER_ID
             
             
             )
		  SELECT
				:p_aad_request_id
			  , :p_mandant_id
			  , CURRENT_TIMESTAMP
			  , :p_comment_txt
			  , wup_id
			  , :p_creator_user_id
			  , 2
			  , hashed_cashier_id
			  , 3
			  , :p_fraud_value_gross_local_val
			  , wrg_id
			  , DATEADD(DAY, :v_period, CURRENT_TIMESTAMP)                      -- request ongoing
			  , scenario_id
			  , :p_scenario_hit_receipts_cnt
			  , :p_request_reason_type_id
			  , first_approver_user_id
			  , :p_second_approver_user_id
			  
		  FROM DBP_MSI_DATA.TS_AAD_REQUEST_WORKFLOW_2
		  WHERE 
			  aad_request_id = :p_aad_request_id
		  AND
			  request_type_id = 1                         -- time extension
		  AND 
			  request_status_type_id = 2;
	    COMMIT;		  
	END IF;  

    
	
    RETURN 'Bedienerentschluesselungsantrag wurde angelegt';

END;
$$;