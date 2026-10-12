CREATE TABLE IF NOT EXISTS ldl_p_lew_load.t_wawi_indicator_day_l_2 (
indicator_id BIGNUMERIC(38) NOT NULL,
indicator_type_id BIGNUMERIC(38) NOT NULL,
org_type_id BIGNUMERIC(38) NOT NULL,
country_iso_cd STRING(2) COLLATE 'und:ci' NOT NULL,
org_unit_nr BIGNUMERIC(38),
cy BIGNUMERIC(38) NOT NULL,
dat_formdate DATE NOT NULL,
currency_iso_cd STRING(3) COLLATE 'und:ci',
val_indicator NUMERIC(18,4),
file_name STRING(100) COLLATE 'und:ci' NOT NULL,
timestamp_fn DATETIME NOT NULL,
dat_dayend DATE NOT NULL,
load_id BIGNUMERIC(38) NOT NULL
);