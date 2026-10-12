CREATE TABLE IF NOT EXISTS ldl_p_lew_load.t_wawi_item_renum_trig_2 (
orig_list_nr BIGNUMERIC(38) NOT NULL,
country_iso_cd STRING(3) COLLATE 'und:ci' NOT NULL,
client_id BIGNUMERIC(38) NOT NULL,
dat_dayend DATE NOT NULL
);