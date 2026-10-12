CREATE TABLE IF NOT EXISTS ldl_p_lew_load.t_wawi_pricegrp_hq_l_1 (
country_iso_cd STRING(3) COLLATE 'und:ci' NOT NULL,
wh_id_hq STRING(3) COLLATE 'und:ci' NOT NULL,
wh_id BIGNUMERIC(38) NOT NULL,
pricegroup_id INTEGER NOT NULL,
pricegroup_desc STRING(30) COLLATE 'und:ci' NOT NULL,
priority INTEGER NOT NULL,
orig_store_nr FLOAT64 NOT NULL,
dat_valid_from DATE NOT NULL,
dat_valid_until DATE NOT NULL,
dat_dayend DATE,
load_id BIGNUMERIC(38) NOT NULL,
client_id BIGNUMERIC(38)
);