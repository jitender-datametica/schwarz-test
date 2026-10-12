CREATE TABLE IF NOT EXISTS ldl_p_lew_load.t_wawi_item_wh_ref_dis_unt_999_2 (
client_id BIGNUMERIC(38) NOT NULL,
dispo_unit_id BIGNUMERIC(38) NOT NULL,
dispo_unit_desc STRING(35) COLLATE 'und:ci' NOT NULL,
language_id BIGNUMERIC(38) NOT NULL,
dat_rec_start DATE NOT NULL,
dat_rec_end DATE NOT NULL,
load_id BIGNUMERIC(38) NOT NULL
);