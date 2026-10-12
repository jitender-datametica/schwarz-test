CREATE OR REPLACE VIEW DBP_VIEW.V_AAD_SCENARIO_HIT_1 AS 
    SELECT 
        scenario_id,
        bon_id,
        bon_dat,
        wup_id,
        mandant_id,
        wrg_id,
        bon_nr,
        bon_booking,
        kasse_nr,
        hashed_cashier_id,
        fraud_value_gross_local_val,
        dwh_created_tmsp,
        dwh_updated_tmsp

FROM DBP_DATA.AAD_SCENARIO_HIT_1 ;