CREATE TABLE IF NOT EXISTS ldl_p_lew_load.t_qv_all_perms_subitemgroup (
client_id BIGNUMERIC NOT NULL,
move_to_store_id BIGNUMERIC NOT NULL,
store_id BIGNUMERIC NOT NULL,
wh_id BIGNUMERIC,
aspect_id BIGNUMERIC NOT NULL,
dat_formdate DATE NOT NULL,
currency_iso_cd STRING(3) COLLATE 'und:ci' NOT NULL,
rate_currency_exchange NUMERIC(18,4) NOT NULL,
subitemgroup_id BIGNUMERIC NOT NULL,
itemgroup_int_id BIGNUMERIC NOT NULL,
dwh_load_id BIGNUMERIC NOT NULL,
dwh_created DATETIME NOT NULL,
dwh_updated DATETIME NOT NULL
) OPTIONS(description='QuickView load table');