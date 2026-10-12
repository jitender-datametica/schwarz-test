create or replace view KFL_PRODUCTION.DBP_VIEW.V_AAD_SCENARIO_HIT_1(
	SCENARIO_ID,
	BON_ID,
	BON_DAT,
	WUP_ID,
	MANDANT_ID,
	WRG_ID,
	BON_NR,
	BON_BOOKING,
	KASSE_NR,
	HASHED_CASHIER_ID,
	FRAUD_VALUE_GROSS_LOCAL_VAL,
	DWH_CREATED_TMSP,
	DWH_UPDATED_TMSP
) as 
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