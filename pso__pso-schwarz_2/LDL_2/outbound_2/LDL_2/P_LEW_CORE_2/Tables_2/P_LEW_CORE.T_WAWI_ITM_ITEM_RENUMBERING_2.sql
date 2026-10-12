CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_wawi_itm_item_renumbering_2 (
orig_list_nr BIGNUMERIC(38,0) NOT NULL,
client_id BIGNUMERIC(38,0) NOT NULL,
item_nr_long INTEGER NOT NULL,
orig_item_nr INTEGER NOT NULL,
sap_item_nr_long INTEGER NOT NULL,
sap_orig_item_nr INTEGER NOT NULL,
item_desc STRING(50) COLLATE 'und:ci',
subitemgroup_id BIGNUMERIC(38,0) NOT NULL,
dat_valid_from DATE NOT NULL,
dat_update DATE,
case_size_detection_fg BIGNUMERIC(38,0),
load_id BIGNUMERIC(38,0) NOT NULL
);