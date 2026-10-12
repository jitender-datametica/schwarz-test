CREATE OR REPLACE VIEW DBP_VIEW.V_AAD_CASHIER_ID_MAPPING_1 AS 
    SELECT 
        hashed_cashier_id,
        mandant_id,
        wup_id,
        kassierer_nr,
        hash_generation_dt

FROM DBP_DATA.AAD_CASHIER_ID_MAPPING_1 ;