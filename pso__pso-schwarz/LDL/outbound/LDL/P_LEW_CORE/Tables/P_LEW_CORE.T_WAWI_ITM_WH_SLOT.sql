CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_wawi_itm_wh_slot (
client_id BIGNUMERIC(38,0) NOT NULL,
wh_loc_sid BIGNUMERIC(38,0) NOT NULL,
item_sid BIGNUMERIC(38,0) NOT NULL,
dat_rec_start DATE NOT NULL,
dat_rec_end DATE NOT NULL,
wh_slot_case BIGNUMERIC(38,0),
wh_location_nr_case BIGNUMERIC(38,0),
wh_slot_pallet BIGNUMERIC(38,0),
wh_location_nr_pallet BIGNUMERIC(38,0),
wh_location_nr_dd BIGNUMERIC(38,0),
wh_slot_dd BIGNUMERIC(38,0),
inv_case_fg BIGNUMERIC(38,0),
inv_euro_fg BIGNUMERIC(38,0),
inv_dd_fg BIGNUMERIC(38,0),
load_id BIGNUMERIC(38,0) NOT NULL
);