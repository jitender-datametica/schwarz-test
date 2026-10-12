CREATE OR REPLACE PROCEDURE DBP_MACRO.SP_AAD_UPS_CASEMANAGEMENT  
(
		 p_aad_request_id NUMBER(38,0)
		,p_mandant_id NUMBER(38,0)
        ,p_creator_user_id VARCHAR(255)
        ,p_criminal_complain_fg NUMBER(38,0)
        ,p_taken_measure_comment_txt VARCHAR(255)
        ,p_loss_amount_gross_local_val NUMBER(18,4) 
        ,p_request_status_type_id NUMBER(38,0)
        ,p_casemanagement_vorhanden_fg NUMBER(38,0)
)
RETURNS VARCHAR
LANGUAGE SQL
AS
$$
BEGIN

IF  (:p_casemanagement_vorhanden_fg = 0 ) THEN 
  
    -- Zusammenfassung erstellen 
	INSERT INTO DBP_MSI_DATA.TS_AAD_REQUEST_WORKFLOW_1
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
        ,expiration_tmsp
        ,scenario_id
        ,scenario_hit_receipts_cnt
        ,request_reason_type_id
        ,comment_txt
        ,first_approver_user_id
        ,second_approver_user_id
        ,approve_by_council_fg
        ,criminal_complain_fg
        ,taken_measure_comment_txt
        ,loss_amount_gross_local_val
        
    )
	WITH t_letzter_Eintrag AS (
    SELECT AAD_REQUEST_ID, MAX(DWH_CREATED_TMSP) AS letzter_Eintrag
    FROM DBP_MSI_DATA.ts_AAD_REQUEST_WORKFLOW_1 
    WHERE aad_request_id = :p_aad_request_id AND mandant_id = :p_mandant_id
    GROUP BY AAD_REQUEST_ID
    ) 
	SELECT 
        v01.aad_request_id
        ,v01.mandant_id
        ,CURRENT_TIMESTAMP()
        ,v01.creation_reason_comment_txt
        ,v01.wup_id
        ,:p_creator_user_id
        ,0
        ,v01.hashed_cashier_id
        ,:p_request_status_type_id
        ,v01.fraud_value_gross_local_val
        ,v01.wrg_id
        ,v01.expiration_tmsp
        ,v01.scenario_id
        ,v01.scenario_hit_receipts_cnt
        ,0
        ,v01.comment_txt
        ,v01.first_approver_user_id
        ,v01.second_approver_user_id
        ,v01.approve_by_council_fg
        ,:p_criminal_complain_fg
        ,:p_taken_measure_comment_txt
        ,:p_loss_amount_gross_local_val
    FROM dbp_msi_data.TS_AAD_REQUEST_WORKFLOW_1 v01
    JOIN t_letzter_Eintrag v02
    ON v01.aad_request_id = v02.aad_request_id
    AND v01.DWH_CREATED_TMSP = v02.letzter_Eintrag 
    WHERE v01.aad_request_id = :p_aad_request_id AND v01.mandant_id = :p_mandant_id
    AND v01.request_status_type_id = 4 ; -- Status_1 dass die Entschuesselung durch ist
ELSE 
     -- Neue Zeile 
	INSERT INTO DBP_MSI_DATA.TS_AAD_REQUEST_WORKFLOW_1
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
        ,expiration_tmsp
        ,scenario_id
        ,scenario_hit_receipts_cnt
        ,request_reason_type_id
        ,comment_txt
        ,first_approver_user_id
        ,second_approver_user_id
        ,approve_by_council_fg
        ,criminal_complain_fg
        ,taken_measure_comment_txt
        ,loss_amount_gross_local_val
    )
	WITH t_letzter_Eintrag AS (
    SELECT AAD_REQUEST_ID, MAX(DWH_CREATED_TMSP) AS letzter_Eintrag 
    FROM DBP_MSI_DATA.ts_AAD_REQUEST_WORKFLOW_1 
    WHERE aad_request_id = :p_aad_request_id AND mandant_id = :p_mandant_id
    GROUP BY AAD_REQUEST_ID
    ) 
	SELECT 
        v01.aad_request_id
        ,v01.mandant_id
        ,CURRENT_TIMESTAMP()
        ,v01.creation_reason_comment_txt
        ,v01.wup_id
        ,:p_creator_user_id
        ,v01.request_type_id
        ,v01.hashed_cashier_id
        ,v01.request_status_type_id
        ,v01.fraud_value_gross_local_val
        ,v01.wrg_id
        ,v01.expiration_tmsp
        ,v01.scenario_id
        ,v01.scenario_hit_receipts_cnt
        ,v01.request_reason_type_id
        ,v01.comment_txt
        ,v01.first_approver_user_id
        ,v01.second_approver_user_id
        ,v01.approve_by_council_fg
        ,:p_criminal_complain_fg
        ,:p_taken_measure_comment_txt
        ,:p_loss_amount_gross_local_val
    FROM dbp_msi_data.TS_AAD_REQUEST_WORKFLOW_1 v01
    JOIN t_letzter_Eintrag v02
    ON v01.aad_request_id = v02.aad_request_id
    AND v01.DWH_CREATED_TMSP = v02.letzter_Eintrag 
    WHERE v01.aad_request_id = :p_aad_request_id AND v01.mandant_id = :p_mandant_id
    AND v01.request_type_id = 0 ; -- Status_1 dass der Antrag schon abgeschlossen ist.
END IF ;
COMMIT;
	
RETURN 'Casemangement Zusammenfassung angelegt';

END;
$$;