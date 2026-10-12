create or replace view KFL_PRODUCTION.DBP_VIEW.V_AAD_CASHIER_ID_MAPPING_1(
	HASHED_CASHIER_ID,
	MANDANT_ID,
	WUP_ID,
	KASSIERER_NR,
	HASH_GENERATION_DT
) as 
    SELECT 
        hashed_cashier_id,
        mandant_id,
        wup_id,
        kassierer_nr,
        hash_generation_dt

FROM DBP_DATA.AAD_CASHIER_ID_MAPPING_1 ;