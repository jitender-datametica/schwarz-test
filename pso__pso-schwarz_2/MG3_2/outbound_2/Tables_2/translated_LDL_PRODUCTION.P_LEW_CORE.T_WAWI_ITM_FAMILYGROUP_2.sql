CREATE OR REPLACE TABLE ldl_production_p_lew_core.t_wawi_itm_familygroup_2 (
client_id INTEGER NOT NULL,
item_familygroup_id INTEGER NOT NULL,
dat_rec_start DATE NOT NULL,
dat_rec_end DATE NOT NULL,
subitemgroup_id INTEGER NOT NULL,
family_cd INTEGER NOT NULL,
item_family_desc STRING(150) COLLATE 'und:ci' NOT NULL,
item_family_short_desc STRING(35) COLLATE 'und:ci',
language_id INTEGER NOT NULL,
load_id INTEGER NOT NULL
);