CREATE OR REPLACE PROCEDURE DBP_MACRO.SP_AAD_UPS_CASEMANAGEMENT_BON  
(
		 p_aad_request_id NUMBER(38,0)
		,p_mandant_id NUMBER(38,0)
        ,p_creator_user_id VARCHAR(255)
)
RETURNS VARCHAR
LANGUAGE SQL
AS
$$

BEGIN
   
    -- Neue Zeile erstellen 
	INSERT INTO DBP_MSI_DATA.TS_AAD_REQUEST_WORKFLOW
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
    FROM DBP_MSI_DATA.ts_AAD_REQUEST_WORKFLOW 
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
        ,SUM(v03.fraud_value_gross_local_val) AS fraud_value_gross_local_val
        ,v01.wrg_id
        ,v01.expiration_tmsp
        ,v01.scenario_id
        ,COUNT(v02.bon_id) AS scenario_hit_receipts_cnt
        ,v01.request_reason_type_id
        ,v01.comment_txt
        ,v01.first_approver_user_id
        ,v01.second_approver_user_id
        ,v01.approve_by_council_fg
        ,v01.CRIMINAL_COMPLAIN_FG
        ,v01.taken_measure_comment_txt
        ,v01.loss_amount_gross_local_val
    FROM dbp_msi_data.TS_AAD_REQUEST_WORKFLOW v01
    JOIN t_letzter_Eintrag v001
    ON v01.aad_request_id = v001.aad_request_id
    AND v01.DWH_CREATED_TMSP = v001.letzter_Eintrag 
    JOIN DBP_MSI_DATA.TS_AAD_REQUEST_RECEIPT_ZU v02
    ON v01.aad_request_id = v02.aad_request_id -- Bons zu erhalten 
    AND v01.mandant_id = v02.mandant_id
    JOIN dbp_view.v_aad_scenario_hit v03 -- Schadensumme zu erhalten
    ON v02.bon_id = v03.bon_id
    AND v02.mandant_id = v03.mandant_id
    AND v02.bon_dat = v03.bon_dat
    WHERE v01.aad_request_id = :p_aad_request_id AND v01.mandant_id = :p_mandant_id
    AND  (v01.request_status_type_id = 4 OR v01.request_type_id = 0) -- Entschluesslung genehmigt oder Zusammenfassung 
    GROUP BY v01.aad_request_id
        ,v01.mandant_id
        ,v01.creation_reason_comment_txt
        ,v01.wup_id
        ,v01.dwh_created_tmsp
        ,v01.request_type_id
        ,v01.hashed_cashier_id
        ,v01.request_status_type_id
        ,v01.wrg_id
        ,v01.expiration_tmsp
        ,v01.scenario_id
        ,v01.request_reason_type_id
        ,v01.comment_txt
        ,v01.first_approver_user_id
        ,v01.second_approver_user_id
        ,v01.approve_by_council_fg
        ,v01.criminal_complain_fg
        ,v01.taken_measure_comment_txt
        ,v01.loss_amount_gross_local_val
    ;    

COMMIT;
	
    RETURN 'Casemangement Bons hinzugefügt';

END;
$$;