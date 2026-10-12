CREATE OR REPLACE TABLE ldl_production_p_lew_core.t_wawi_itm_item_skey_2 (
client_id INTEGER NOT NULL,
item_sid INTEGER NOT NULL,
dat_rec_start DATE NOT NULL,
dat_rec_end DATE NOT NULL,
orig_item_nr INTEGER NOT NULL,
old_orig_item_nr INTEGER,
case_size INTEGER NOT NULL,
reused_nr INTEGER,
dat_deleted DATE DEFAULT CAST('9999-12-31' AS DATE) NOT NULL,
deleted_rmi_fg INTEGER DEFAULT 0 NOT NULL,
load_id INTEGER NOT NULL
);