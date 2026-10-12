CREATE TABLE IF NOT EXISTS ldl_p_lew_load.t_wawi_supp_wh_t_2 (
client_id BIGNUMERIC(38) NOT NULL,
wh_loc_sid BIGNUMERIC(38) NOT NULL,
sup_sid BIGNUMERIC(38) NOT NULL,
dat_rec_start DATE NOT NULL,
dat_rec_end DATE NOT NULL,
dispo_info STRING(254) COLLATE 'und:ci',
fax STRING(35) COLLATE 'und:ci',
phone STRING(50) COLLATE 'und:ci',
name_cont_person STRING(35) COLLATE 'und:ci',
fax_contact_fg BIGNUMERIC(38),
load_id BIGNUMERIC(38) NOT NULL
);