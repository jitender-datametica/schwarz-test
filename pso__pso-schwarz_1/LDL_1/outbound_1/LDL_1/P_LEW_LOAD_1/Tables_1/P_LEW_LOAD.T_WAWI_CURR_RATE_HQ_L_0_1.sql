CREATE TABLE IF NOT EXISTS ldl_p_lew_load.t_wawi_curr_rate_hq_l_0_1 (
country_iso_cd STRING(3) COLLATE 'und:ci' NOT NULL,
wh_id_hq STRING(3) COLLATE 'und:ci' NOT NULL,
currency_nr INTEGER NOT NULL,
dat_valid_from DATE NOT NULL,
unit_currency_exchange NUMERIC(6,2) NOT NULL,
rate_currency_exchange NUMERIC(18,4),
dat_dayend DATE NOT NULL,
load_id BIGNUMERIC(38) NOT NULL,
dc_server_id BIGNUMERIC(38) NOT NULL,
bic_zmlila STRING(20),
extraction_ts DATETIME,
record_id INTEGER,
source_system STRING(20) COLLATE 'und:ci'
);