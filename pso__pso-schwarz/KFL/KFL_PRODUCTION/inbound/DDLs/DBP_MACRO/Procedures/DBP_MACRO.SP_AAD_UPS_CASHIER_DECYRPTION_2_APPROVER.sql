CREATE OR REPLACE PROCEDURE DBP_MACRO.SP_AAD_UPS_CASHIER_DECYRPTION_2_APPROVER(
	  p_aad_request_id NUMBER(38,0)
	, p_genehmight_flag NUMBER(38,0)
	, p_mandant_id NUMBER(38,0)
	, p_comment_txt VARCHAR(250)
    , p_request_type_id NUMBER(38,0)
    , p_approver_id VARCHAR(250)
    , p_BR_flag NUMBER(38,0)
)
RETURNS VARCHAR
LANGUAGE SQL
AS
$$
DECLARE 
	v_period NUMBER;
BEGIN

  -- Wenn genehmigt: 
  IF (:p_genehmight_flag = 1) THEN           
      SELECT DISTINCT
		config_val
        INTO :v_period
    	FROM 		
    		DBp_DATa.AAD_ENGINE_CONFIG
        WHERE 
    		mandant_id = :p_mandant_id
    	AND
    		config_id = 2; 

  -- Wennn es genehmigt wurden ist vom zweiten Approver 
  -- muss das Gueltig bis vom Zeitraumerweiterung auch erneut gesetzt werden   
    UPDATE DBP_MSI_DATA.TS_AAD_REQUEST_WORKFLOW
      SET EXPIRATION_TMSP =  DATEADD(DAY, :v_period, CURRENT_TIMESTAMP) 
      WHERE 
          aad_request_id = :p_aad_request_id 
          AND request_type_id = 1
          AND REQUEST_STATUS_TYPE_ID = 2
          ; 
  ELSE
    v_period:=0;                                     
  END IF;

  -- Neue Zeile Kopieren des Antragsder Genehmigung erste Genehmiger 
    INSERT INTO DBP_MSI_DATA.TS_AAD_REQUEST_WORKFLOW
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
         APPROVE_BY_COUNCIL_FG,
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
          , CASE WHEN :p_genehmight_flag = 1 AND :p_request_type_id = 2 THEN 4 -- Bedienerentschluesselung 
              WHEN :p_genehmight_flag = 0  AND :p_request_type_id = 2 THEN 7
              ELSE REQUEST_STATUS_TYPE_ID END 
          , fraud_value_gross_local_val
          , wrg_id
          , DATEADD(DAY, :v_period, CURRENT_TIMESTAMP)                   
          , scenario_id
          , scenario_hit_receipts_cnt
          , request_reason_type_id
          , FIRST_APPROVER_USER_ID 
          , :p_approver_id
          , :p_br_flag
          , CASE WHEN :p_comment_txt !='' THEN  COMMENT_TXT || ' 2.Genehmiger Kommentar:'||:p_comment_txt ELSE COMMENT_TXT END
      FROM DBP_MSI_DATA.TS_AAD_REQUEST_WORKFLOW
      WHERE 
          aad_request_id = :p_aad_request_id
      AND
          request_type_id = :p_request_type_id    
      AND REQUEST_STATUS_TYPE_ID = 12 ;

    -- Genehmigung des ersten Genehmiger Gueltig bis auf heute setzen 
      UPDATE DBP_MSI_DATA.TS_AAD_REQUEST_WORKFLOW
      SET EXPIRATION_TMSP =  CURRENT_TIMESTAMP 
      WHERE 
          aad_request_id = :p_aad_request_id 
          AND request_type_id = :p_request_type_id
          AND REQUEST_STATUS_TYPE_ID = 12 -- vom ersten genehmigt 
          ;      
    COMMIT;
	
	RETURN 'Antrag vom zweiten Approver bearbeitet';
END;
$$;