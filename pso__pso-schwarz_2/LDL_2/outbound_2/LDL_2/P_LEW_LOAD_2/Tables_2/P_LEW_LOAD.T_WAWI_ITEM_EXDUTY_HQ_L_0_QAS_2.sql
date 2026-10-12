CREATE TABLE IF NOT EXISTS ldl_p_lew_load.t_wawi_item_exduty_hq_l_0_qas_2 (
country_iso_cd STRING(3) COLLATE 'und:ci' NOT NULL,
wh_id_hq STRING(3) COLLATE 'und:ci' NOT NULL,
dat_valid_from DATE NOT NULL,
dat_valid_until DATE NOT NULL,
item_nr_long STRING(18) COLLATE 'und:ci' NOT NULL,
orig_item_nr INTEGER NOT NULL,
case_size BIGNUMERIC(38,0) NOT NULL,
main_exduty BIGNUMERIC(38,0) NOT NULL,
sub_exduty BIGNUMERIC(38,0) NOT NULL,
pct_exc_duty NUMERIC(5,3),
dat_dayend DATE,
load_id BIGNUMERIC(38,0),
dc_server_id BIGNUMERIC(38,0) NOT NULL,
bic_zmlila STRING(20),
extraction_ts DATETIME,
record_id INTEGER,
source_system STRING(20) COLLATE 'und:ci'
);