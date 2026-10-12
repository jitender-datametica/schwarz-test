CREATE TABLE IF NOT EXISTS ldl_p_lew_load.t_wawi_discounts_hq_l_0_1 (
country_iso_cd STRING(3) COLLATE 'und:ci' NOT NULL,
wh_id_hq STRING(3) COLLATE 'und:ci' NOT NULL,
discount_nr_wawi BIGNUMERIC(38) NOT NULL,
dat_valid_from DATE NOT NULL,
dat_valid_until DATE NOT NULL,
discount_desc STRING(50) COLLATE 'und:ci' NOT NULL,
discount_type_id BIGNUMERIC(38) NOT NULL,
discount_booking_type_id BIGNUMERIC(38) NOT NULL,
dat_last_export DATETIME,
dat_storno DATETIME,
dat_dayend DATE NOT NULL,
load_id BIGNUMERIC(38) NOT NULL,
dc_server_id BIGNUMERIC(38) NOT NULL,
bic_zmlila STRING(20),
extraction_ts DATETIME,
record_id INTEGER,
source_system STRING(20) COLLATE 'und:ci'
);