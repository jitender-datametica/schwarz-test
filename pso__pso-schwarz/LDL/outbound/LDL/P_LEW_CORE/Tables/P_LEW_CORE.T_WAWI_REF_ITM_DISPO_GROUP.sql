CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_wawi_ref_itm_dispo_group (
client_id BIGNUMERIC(38,0) NOT NULL,
dispo_group_id BIGNUMERIC(38,0) NOT NULL,
dat_rec_end DATE NOT NULL,
dat_rec_start DATE NOT NULL,
dispo_group_desc STRING(35) COLLATE 'und:ci' NOT NULL,
language_id BIGNUMERIC(38,0) NOT NULL,
load_id BIGNUMERIC(38,0) NOT NULL
);