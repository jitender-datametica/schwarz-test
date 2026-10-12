CREATE OR REPLACE PROCEDURE dbp_macro.sp_aad_ins_request_receipt_zu(IN p_aad_request_id INT64, IN p_mandant_id INT64, IN p_wup_id INT64, IN p_hashed_cashier_id STRING, IN p_bon_id STRING, IN p_flag INT64, OUT out_param STRING)
BEGIN
BEGIN TRANSACTION;

IF p_flag = 1 THEN
    BEGIN
    -- Bons zu Request hinzufügen 
    INSERT INTO dbp_msi_data.ts_aad_request_receipt_zu (bon_id, bon_dat, wup_id, mandant_id, aad_request_id)
(SELECT DISTINCT bon_id, bon_dat, wup_id, mandant_id, p_aad_request_id
    FROM dbp_view.v_aad_scenario_hit
    WHERE mandant_id = p_mandant_id AND wup_id = p_wup_id AND hashed_cashier_id = p_hashed_cashier_id AND bon_id = p_bon_id);
    END;
END IF;

COMMIT TRANSACTION;
SET out_param  =  'Bons wurden hinzugefuegt';
SELECT out_param;
RETURN;
END;


