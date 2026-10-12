CREATE OR REPLACE PROCEDURE DBP_MACRO.SP_AAD_INS_TIME_EXTENSION_REQUEST  
(
		 --aad_request_id NUMBER(38,0)
		p_mandant_id NUMBER(38,0)
		,p_creation_reason_comment_txt VARCHAR(250)
		,p_wup_id NUMBER(38,0)
		,p_creator_user_id VARCHAR(250)
		,p_hashed_cashier_id VARCHAR(250)
		,p_fraud_value_gross_local_val NUMBER(18,4)
		,p_wrg_id VARCHAR(3)
		,p_scenario_id NUMBER(38,0)
		,p_scenario_hit_receipts_cnt NUMBER(38,0)
		,p_request_reason_type_id NUMBER(38,0)
		,p_first_approver_user_id VARCHAR(250)
        ,p_concat_bon_ids VARCHAR(250)
)
RETURNS VARCHAR
LANGUAGE SQL
AS
$$
DECLARE 
	v_period NUMBER;
    v_aad_request_id NUMBER;
BEGIN
    --########### Get the period extension for the given mandant_id
   -- CALL SP_GET_CONFIG_PERIOD(:mandant_id, 1) INTO :period;
	SELECT DISTINCT
		config_val
    INTO :v_period
	FROM 		
		DBp_DATa.AAD_ENGINE_CONFIG_2
    WHERE 
		mandant_id = :p_mandant_id
	AND
		config_id = 1;
     
    -- REQUEST ID ermitteln 
    SELECT COALESCE(MAX(aad_request_id),0) INTO :v_aad_request_id
    FROM DBP_MSI_DATA.TS_AAD_REQUEST_WORKFLOW_2 ;
    ---- Request erstellen 
	INSERT INTO DBP_MSI_DATA.TS_AAD_REQUEST_WORKFLOW_2
    (
         aad_request_id
        ,mandant_id
        ,dwh_created_tmsp
        ,creation_reason_comment_txt
        ,wup_id
        ,creator_user_id
        ,request_type_id
        ,hashed_cashier_id
        ,request_status_type_id
        ,fraud_value_gross_local_val
        ,wrg_id
        ,scenario_id
        ,scenario_hit_receipts_cnt
        ,request_reason_type_id
        ,first_approver_user_id
        ,expiration_tmsp
    )
	VALUES
	(
		  :v_aad_request_id +1
		, :p_mandant_id
		,  CURRENT_TIMESTAMP
		, :p_creation_reason_comment_txt
		, :p_wup_id
		, :p_creator_user_id
		, 1
		, :p_hashed_cashier_id
		, 1
		, :p_fraud_value_gross_local_val
		, :p_wrg_id
      	, :p_scenario_id
		, :p_scenario_hit_receipts_cnt
		, :p_request_reason_type_id 
		, :p_first_approver_user_id 
		,  DATEADD(DAY, :v_period, CURRENT_TIMESTAMP) --Time Extension period from config

	);
    -- Bons zu Request hinzufügen 
    INSERT INTO DBP_MSI_DATA.TS_AAD_REQUEST_RECEIPT_ZU_2
        (bon_id, 
        bon_dat, 
        wup_id,
        mandant_id,
        aad_request_id
        )
    SELECT DISTINCT Bon_id,
        bon_dat,
        wup_id,
        mandant_id,
        :v_aad_request_id+1
    FROM dbp_view.v_aad_scenario_hit_2	
    WHERE mandant_id = :p_mandant_id
    AND WUP_ID = :p_wup_id
    AND hashed_cashier_id = :p_hashed_cashier_id
    AND BON_ID IN ( SELECT table1.value FROM TABLE(split_to_table(:p_concat_bon_ids, ',')) AS table1 )
    AND SCENARIO_ID = :p_scenario_id
    ;

COMMIT;
	
    RETURN 'Antrag-Zeiterweiterung angelegt';

END;
$$;