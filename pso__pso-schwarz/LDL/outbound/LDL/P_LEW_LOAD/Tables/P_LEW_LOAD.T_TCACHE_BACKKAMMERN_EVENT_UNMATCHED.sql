CREATE TABLE IF NOT EXISTS ldl_p_lew_load.t_tcache_backkammern_event_unmatched (
client_id BIGNUMERIC(38,0),
cs_db_ovenid BIGNUMERIC,
cs_manufacturer STRING(200),
cs_country STRING(200),
ts BIGNUMERIC,
cs_timezone STRING(200),
cs_event_unified STRING(200),
cs_send_data BIGNUMERIC,
cs_baking_program_number BIGNUMERIC,
extraction_dt DATE,
dwh_load_id BIGNUMERIC(38,0),
dwh_created DATETIME,
dwh_updated DATETIME
);