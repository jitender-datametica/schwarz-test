create table if not exists SZD_PRODUCTION.etl.ts_etl_rvm_deact_status_2 (
	rvm_sid number(38,0),
	inserted_tmsp timestamp_ntz(9),
	transaction_status varchar(16777216),
	transaction_tmsp timestamp_ntz(9),
	dwh_created_tmsp timestamp_ntz(9),
	dwh_updated_tmsp timestamp_ntz(9)
);