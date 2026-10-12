CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_wawi_itm_pp_item_1 (
client_id BIGNUMERIC(38,0) NOT NULL,
wh_loc_sid_pp BIGNUMERIC(38,0) NOT NULL,
orig_item_nr_pp BIGNUMERIC(38,0) NOT NULL,
case_size_pp BIGNUMERIC(38,0) NOT NULL,
item_sid BIGNUMERIC(38,0) NOT NULL,
dat_sys DATE NOT NULL,
timestamp_from_pp DATETIME NOT NULL,
timestamp_until_pp DATETIME NOT NULL,
picking_area_nr_pp BIGNUMERIC(38,0) NOT NULL,
end_cd_pp STRING(20) COLLATE 'und:ci',
item_status_pp STRING(20) COLLATE 'und:ci' NOT NULL,
load_id BIGNUMERIC(38,0) NOT NULL
) CLUSTER BY dat_sys;