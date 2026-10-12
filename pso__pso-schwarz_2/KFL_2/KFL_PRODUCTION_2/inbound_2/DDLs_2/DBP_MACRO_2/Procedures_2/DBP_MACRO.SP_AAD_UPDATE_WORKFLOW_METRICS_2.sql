CREATE OR REPLACE PROCEDURE DBP_MACRO.SP_AAD_UPDATE_WORKFLOW_METRICS(
    p_aad_request_id NUMBER(38,0),
    p_mandant_id NUMBER(38,0),
    p_scenario_hit_receipts_cnt NUMBER(38,0),
    p_fraud_value_gross_local_val NUMBER(18,4)
)
RETURNS VARCHAR
LANGUAGE SQL
AS
$$
BEGIN
    -- Aktualizacja wskazanych kolumn dla konkretnego wniosku
    UPDATE DBP_MSI_DATA.TS_AAD_REQUEST_WORKFLOW_2
    SET 
        scenario_hit_receipts_cnt = :p_scenario_hit_receipts_cnt,
        fraud_value_gross_local_val = :p_fraud_value_gross_local_val
    WHERE 
        aad_request_id = :p_aad_request_id
        AND mandant_id = :p_mandant_id;
        
    COMMIT;
    
    RETURN 'Successfully updated all records for request ID: ' || TO_VARCHAR(:p_aad_request_id);
END;
$$;