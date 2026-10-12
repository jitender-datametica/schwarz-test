CREATE OR REPLACE TABLE ldl_production_p_lew_core.t_wawi_itm_item_desc_2 (
client_id INTEGER NOT NULL,
item_sid INTEGER NOT NULL,
dat_rec_start DATE NOT NULL,
dat_rec_end DATE NOT NULL,
item_desc STRING(100) COLLATE 'und:ci',
orig_item_nr INTEGER,
language_id INTEGER NOT NULL,
load_id INTEGER NOT NULL
);