CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_wawi_ref_correlation_buyer_name_1 (
manager_desc STRING(100) COLLATE 'und:ci' NOT NULL,
manager_login STRING(50) COLLATE 'und:ci' NOT NULL,
buyer_desc STRING(100) COLLATE 'und:ci' NOT NULL,
buyer_short_desc STRING(30) COLLATE 'und:ci' NOT NULL,
buyer_login STRING(50) COLLATE 'und:ci',
timestamp_fn DATETIME NOT NULL,
dat_dayend DATE NOT NULL,
load_id BIGNUMERIC(38,0) NOT NULL
);