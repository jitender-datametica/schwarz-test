 CREATE OR REPLACE PROCEDURE DBP_MACRO.SP_AAD_INS_REQUEST_RECEIPT_ZU  
(
		 p_aad_request_id NUMBER(38,0)
		, p_mandant_id NUMBER(38,0)
		,p_wup_id NUMBER(38,0)
		,p_hashed_cashier_id VARCHAR(250)
        ,p_bon_id VARCHAR(250)
        ,p_flag NUMBER(38,0)
)
RETURNS VARCHAR
LANGUAGE SQL
AS
$$
BEGIN

IF (:p_flag = 1) THEN 
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
        :p_aad_request_id
    FROM dbp_view.v_aad_scenario_hit_2	
    WHERE mandant_id = :p_mandant_id
    AND WUP_ID = :p_wup_id
    AND hashed_cashier_id = :p_hashed_cashier_id
    and BON_ID = :p_bon_id
    ;
END IF;
COMMIT;

RETURN 'Bons wurden hinzugefuegt';

END;
$$;