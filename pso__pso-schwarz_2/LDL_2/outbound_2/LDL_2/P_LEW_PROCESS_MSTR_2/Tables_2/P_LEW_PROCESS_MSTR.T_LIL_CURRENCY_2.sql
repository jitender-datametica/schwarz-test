CREATE TABLE IF NOT EXISTS ldl_p_lew_process_mstr.t_lil_currency_2 (
currency_iso_cd STRING(160) NOT NULL,
currency_desc STRING(800) NOT NULL,
currency_srt_cd BIGNUMERIC(38,0),
dwh_load_id BIGNUMERIC(38,0) NOT NULL,
dwh_created TIMESTAMP NOT NULL,
dwh_updated TIMESTAMP NOT NULL,
td_insert TIMESTAMP,
td_update TIMESTAMP
);