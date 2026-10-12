CREATE TABLE IF NOT EXISTS ldl_p_lew_load.t_wawi_discounts_hq_l_2 (
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
file_name STRING(100) COLLATE 'und:ci' NOT NULL,
timestamp_fn DATETIME NOT NULL,
dat_dayend DATE NOT NULL,
load_id BIGNUMERIC(38) NOT NULL
);