CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_wawi_ref_correlation_orig_item_nr_2 (
orig_item_nr INTEGER NOT NULL,
orig_item_desc STRING(100) COLLATE 'und:ci' NOT NULL,
mis_login STRING(50) COLLATE 'und:ci',
buyer_fg BIGNUMERIC(38,0) NOT NULL,
buyer_short_desc STRING(30) COLLATE 'und:ci' NOT NULL,
timestamp_fn DATETIME NOT NULL,
dat_dayend DATE NOT NULL,
load_id BIGNUMERIC(38,0) NOT NULL
);