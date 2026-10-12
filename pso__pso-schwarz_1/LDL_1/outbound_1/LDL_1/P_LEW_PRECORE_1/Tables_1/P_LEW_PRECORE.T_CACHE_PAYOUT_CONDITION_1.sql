CREATE TABLE IF NOT EXISTS ldl_p_lew_precore.t_cache_payout_condition_1 (
client_id BIGNUMERIC(38,0),
payout_cond_sid BIGNUMERIC(38,0),
acc_type STRING(100),
acc_sub_type STRING(100),
nln BIGNUMERIC(38,0),
nan BIGNUMERIC(38,0),
item_group_no BIGNUMERIC(38,0),
item_family STRING(10),
valid_from DATE,
valid_to DATE,
currency_iso_cd STRING(10),
cond_value STRING(100),
extraction_dt DATE,
dwh_load_id BIGNUMERIC(38,0) NOT NULL,
dwh_created DATETIME NOT NULL,
dwh_updated DATETIME NOT NULL
);