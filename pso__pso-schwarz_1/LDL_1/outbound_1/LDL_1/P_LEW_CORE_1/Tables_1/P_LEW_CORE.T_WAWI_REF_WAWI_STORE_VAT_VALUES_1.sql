CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_wawi_ref_wawi_store_vat_values_1 (
client_id BIGNUMERIC(38,0) NOT NULL,
st_loc_sid BIGNUMERIC(38,0) NOT NULL,
vat_id BIGNUMERIC(38,0) NOT NULL,
country_cd STRING(3) COLLATE 'und:ci' NOT NULL,
dat_rec_start DATE NOT NULL,
store_vat_id BIGNUMERIC(38,0),
pct_vat NUMERIC(4,2) NOT NULL,
store_pct_vat NUMERIC(4,2),
dat_rec_end DATE NOT NULL,
dat_modification DATE NOT NULL,
dat_dayend DATE NOT NULL,
load_id BIGNUMERIC(38,0) NOT NULL
);