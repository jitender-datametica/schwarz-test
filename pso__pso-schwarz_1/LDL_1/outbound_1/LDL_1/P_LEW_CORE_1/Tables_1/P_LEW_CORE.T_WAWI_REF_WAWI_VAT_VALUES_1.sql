CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_wawi_ref_wawi_vat_values_1 (
client_id BIGNUMERIC(38,0) NOT NULL,
vat_id BIGNUMERIC(38,0) NOT NULL,
country_cd STRING(3) COLLATE 'und:ci' NOT NULL,
dat_valid_from DATE NOT NULL,
dat_valid_until DATE NOT NULL,
dat_rec_start DATE NOT NULL,
dat_rec_end DATE NOT NULL,
vat_cat_id BIGNUMERIC(38,0),
pct_vat NUMERIC(4,2) NOT NULL,
vat_desc STRING(60) COLLATE 'und:ci',
fin_account_no BIGNUMERIC(38,0),
fin_account_remarks BIGNUMERIC(38,0),
suppl_fin_cd_nat STRING(5) COLLATE 'und:ci',
suppl_fin_cd_eu STRING(5) COLLATE 'und:ci',
suppl_fin_cd_non_eu STRING(5) COLLATE 'und:ci',
dat_dayend DATE NOT NULL,
load_id BIGNUMERIC(38,0) NOT NULL
);