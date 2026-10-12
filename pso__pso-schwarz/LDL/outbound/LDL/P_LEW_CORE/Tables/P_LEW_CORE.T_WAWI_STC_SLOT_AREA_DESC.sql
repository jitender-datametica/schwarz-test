CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_wawi_stc_slot_area_desc (
client_id BIGNUMERIC(38,0) NOT NULL,
wh_loc_sid BIGNUMERIC(38,0) NOT NULL,
stc_slot_area INTEGER NOT NULL,
language_id BIGNUMERIC(38,0) NOT NULL,
dat_rec_start DATE NOT NULL,
dat_rec_end DATE NOT NULL,
stc_slot_name STRING(35) COLLATE 'und:ci' NOT NULL,
stc_slot_short_name STRING(35) COLLATE 'und:ci',
load_id BIGNUMERIC(38,0) NOT NULL
);