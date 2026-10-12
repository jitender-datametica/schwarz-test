CREATE OR REPLACE TABLE ldl_p_lew_mart_lead.t_itm_orig_item (
client_id INTEGER NOT NULL,
orig_item_nr INTEGER NOT NULL,
dat_valid_from DATE NOT NULL,
orig_item_nr_int INTEGER,
item_fam_grp_sid INTEGER,
item_familygroup_id INTEGER,
sub_item_grp_sid INTEGER,
subitemgroup_id INTEGER,
dwh_updated DATETIME NOT NULL
);