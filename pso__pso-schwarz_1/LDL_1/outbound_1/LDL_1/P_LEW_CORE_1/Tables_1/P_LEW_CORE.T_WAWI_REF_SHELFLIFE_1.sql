CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_wawi_ref_shelflife_1 (
client_id BIGNUMERIC(38,0) NOT NULL,
shelflife_id BIGNUMERIC(38,0) NOT NULL,
shelflife_short_desc STRING(35) COLLATE 'und:ci',
shelflife_desc STRING(50) COLLATE 'und:ci',
language_id BIGNUMERIC(38,0) NOT NULL,
dat_rec_start DATE NOT NULL,
dat_rec_end DATE NOT NULL,
factor_period BIGNUMERIC(38,0),
load_id BIGNUMERIC(38,0) NOT NULL
);