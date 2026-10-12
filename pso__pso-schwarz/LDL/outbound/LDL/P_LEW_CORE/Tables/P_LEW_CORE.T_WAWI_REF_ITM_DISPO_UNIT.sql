CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_wawi_ref_itm_dispo_unit (
client_id BIGNUMERIC(38,0) NOT NULL,
dispo_unit_id BIGNUMERIC(38,0) NOT NULL,
dispo_unit_desc STRING(35) COLLATE 'und:ci' NOT NULL,
language_id BIGNUMERIC(38,0) NOT NULL,
dat_rec_start DATE NOT NULL,
dat_rec_end DATE NOT NULL,
load_id BIGNUMERIC(38,0) NOT NULL
);