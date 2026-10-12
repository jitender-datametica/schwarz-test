CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_wawi_ref_vat_1 (
client_id BIGNUMERIC(38,0) NOT NULL,
vat_id BIGNUMERIC(38,0) NOT NULL,
dat_rec_start DATE NOT NULL,
dat_rec_end DATE NOT NULL,
vat_desc STRING(60) COLLATE 'und:ci',
pct_vat NUMERIC(18,4),
language_id BIGNUMERIC(38,0) NOT NULL,
load_id BIGNUMERIC(38,0) NOT NULL
);