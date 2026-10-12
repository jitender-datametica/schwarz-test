CREATE OR REPLACE PROCEDURE DBP_MACRO.SP_AAD_UPS_TIME_EXTENSION_AND_CASHIER_DECYRPTION_1_APPROVER(
      p_aad_request_id NUMBER(38,0)
    , p_genehmight_flag NUMBER(38,0)
    , p_mandant_id NUMBER(38,0)
    , p_comment_txt VARCHAR(250)
    , p_request_type_id NUMBER(38,0)
    , p_approver_id VARCHAR(250)
)
RETURNS VARCHAR
LANGUAGE SQL
AS
$$
DECLARE 
	v_period NUMBER;
BEGIN

  -- Wenn genehmigt: 
  IF (:p_genehmight_flag = 1 AND :p_request_type_id = 1) THEN    -- Wenn Zeitraumerweiterung genehmigt wird 
  
      SELECT DISTINCT
		config_val
        INTO :v_period
    	FROM 		
    		DBp_DATa.AAD_ENGINE_CONFIG_2
        WHERE 
    		mandant_id = :p_mandant_id
    	AND
    		config_id = 1; 
-- bei ablehnen & erste Genehmigung Bediener wird das heutige Datum verwenden 
  ELSE
    v_period:=0;                                 
  END IF;

  ---Neuer Status_2 neuer Eintrag in die Tabelle 
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
             SECOND_APPROVER_USER_ID,
             COMMENT_TXT
             
             )
		  SELECT
				:p_aad_request_id
			  , :p_mandant_id
			  , CURRENT_TIMESTAMP
			  , CREATION_REASON_COMMENT_TXT
			  , wup_id
			  , creator_user_id
			  , :p_request_type_id
			  , hashed_cashier_id
			  , CASE WHEN :p_genehmight_flag = 1 AND :p_request_type_id = 1 THEN 2 -- Zeiterweiterung
                                  WHEN :p_genehmight_flag = 1 AND :p_request_type_id = 2 THEN 12 -- Bedienerentschluesselung 
                                  ELSE 7 END 
			  , fraud_value_gross_local_val
			  , wrg_id
			  , CASE WHEN :p_genehmight_flag = 1 AND :p_request_type_id = 2 THEN EXPIRATION_TMSP --  Bedienernetschluesselung genehmigt wird Gueltig bis vom Antrag uebernommen 
          ELSE DATEADD(DAY, :v_period, CURRENT_TIMESTAMP) END                  
			  , scenario_id
			  , scenario_hit_receipts_cnt
			  , request_reason_type_id
			  , :p_approver_id
			  , SECOND_APPROVER_USER_ID
			  , :p_comment_txt
		  FROM DBP_MSI_DATA.TS_AAD_REQUEST_WORKFLOW_2
		  WHERE 
			  aad_request_id = :p_aad_request_id
		  AND
			  request_type_id = :p_request_type_id                        
		 ;


      -- Antraege wird das Gueltig bis abgeaendert auf den heutigen Tag_2 
      UPDATE DBP_MSI_DATA.TS_AAD_REQUEST_WORKFLOW_2
      SET EXPIRATION_TMSP =  CURRENT_TIMESTAMP 
      WHERE 
          aad_request_id = :p_aad_request_id
          AND request_type_id = :p_request_type_id
          AND REQUEST_STATUS_TYPE_ID IN (1,3);  --   Antragstellungsid Zeiterweiterung / Bedienerentschluesselung            
    COMMIT;
	
	RETURN 'Antrag vom ersten Approver bearbeitet';
END;
$$;