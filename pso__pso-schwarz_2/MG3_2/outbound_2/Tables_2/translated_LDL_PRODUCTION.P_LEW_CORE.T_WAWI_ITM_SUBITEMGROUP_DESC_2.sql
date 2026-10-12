CREATE OR REPLACE TABLE ldl_production_p_lew_core.t_wawi_itm_subitemgroup_desc_2 (
client_id INTEGER NOT NULL,
subitemgroup_id INTEGER NOT NULL,
dat_rec_start DATE NOT NULL,
dat_rec_end DATE NOT NULL,
subitemgroup_desc STRING(50) COLLATE 'und:ci',
subitemgroup_short_desc STRING(30) COLLATE 'und:ci',
subitemgroup_sortterm INTEGER,
language_id INTEGER NOT NULL,
load_id INTEGER NOT NULL
);