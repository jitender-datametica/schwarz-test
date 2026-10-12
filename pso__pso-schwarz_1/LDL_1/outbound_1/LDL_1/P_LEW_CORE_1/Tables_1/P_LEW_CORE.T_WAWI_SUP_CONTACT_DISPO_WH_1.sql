CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_wawi_sup_contact_dispo_wh_1 (
client_id BIGNUMERIC(38,0) NOT NULL,
wh_loc_sid BIGNUMERIC(38,0) NOT NULL,
sup_sid BIGNUMERIC(38,0) NOT NULL,
dat_rec_start DATE NOT NULL,
dat_rec_end DATE NOT NULL,
dispo_info STRING(254) COLLATE 'und:ci',
fax STRING(35) COLLATE 'und:ci',
phone STRING(50) COLLATE 'und:ci',
name_cont_person STRING(35) COLLATE 'und:ci',
fax_contact_fg BIGNUMERIC(38,0),
load_id BIGNUMERIC(38,0) NOT NULL
);