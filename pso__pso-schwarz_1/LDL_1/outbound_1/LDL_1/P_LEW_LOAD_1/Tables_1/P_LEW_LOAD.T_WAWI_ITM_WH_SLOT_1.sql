CREATE TABLE IF NOT EXISTS ldl_p_lew_load.t_wawi_itm_wh_slot_1 (
client_id BIGNUMERIC(38) NOT NULL,
wh_id BIGNUMERIC(38) NOT NULL,
item_id BIGNUMERIC(38) NOT NULL,
dat_rec_start DATE NOT NULL,
dat_rec_end DATE NOT NULL,
wh_slot_case BIGNUMERIC(38),
wh_location_nr_case BIGNUMERIC(38),
wh_slot_pallet BIGNUMERIC(38),
wh_location_nr_pallet BIGNUMERIC(38),
wh_location_nr_dd BIGNUMERIC(38),
wh_slot_dd BIGNUMERIC(38),
inv_case_fg BIGNUMERIC(38),
inv_euro_fg BIGNUMERIC(38),
inv_dd_fg BIGNUMERIC(38),
load_id BIGNUMERIC(38) NOT NULL,
load_ts DATETIME
);