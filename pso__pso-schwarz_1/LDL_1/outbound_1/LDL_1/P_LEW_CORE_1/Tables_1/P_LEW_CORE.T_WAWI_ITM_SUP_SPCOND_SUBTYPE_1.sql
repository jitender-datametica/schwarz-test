CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_wawi_itm_sup_spcond_subtype_1 (
client_id BIGNUMERIC(38,0) NOT NULL,
spcond_subtype_id BIGNUMERIC(38,0) NOT NULL,
dat_rec_start DATE NOT NULL,
dat_rec_end DATE NOT NULL,
spcond_subtype_desc STRING(150) COLLATE 'und:ci',
language_id BIGNUMERIC(38,0) NOT NULL,
load_id BIGNUMERIC(38,0) NOT NULL
);