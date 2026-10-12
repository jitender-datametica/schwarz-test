CREATE TABLE IF NOT EXISTS ldl_p_lew_load.t_wawi_pricegrp_hq_999_1 (
client_id BIGNUMERIC(38) NOT NULL,
pricegroup_id INTEGER NOT NULL,
wh_loc_sid BIGNUMERIC(38) NOT NULL,
st_loc_sid BIGNUMERIC(38) NOT NULL,
dat_valid_from DATE NOT NULL,
dat_valid_until DATE NOT NULL,
pricegroup_desc STRING(50) COLLATE 'und:ci' NOT NULL,
priority INTEGER NOT NULL,
language_id BIGNUMERIC(38) NOT NULL,
load_id BIGNUMERIC(38) NOT NULL
);