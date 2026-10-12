CREATE TABLE IF NOT EXISTS ldl_p_lew_load.t_wawi_stock_con_c_tmp (
err_release BIGNUMERIC(38) DEFAULT 0,
release_user STRING(30) COLLATE 'und:ci',
err_date DATE DEFAULT CURRENT_DATE NOT NULL,
err_cd BIGNUMERIC(38),
country_iso_cd STRING(3) COLLATE 'und:ci' NOT NULL,
wh_id STRING(3) COLLATE 'und:ci' NOT NULL,
itm_consgr_id BIGNUMERIC(38) NOT NULL,
itm_consgr_desc STRING(35) COLLATE 'und:ci',
dat_modification DATE,
orig_item_nr INTEGER NOT NULL,
item_desc STRING(35) COLLATE 'und:ci',
subitemgroup_id BIGNUMERIC(38),
price_retail_cons NUMERIC(18,4),
dat_dayend DATE,
file_name STRING(100) COLLATE 'und:ci',
timestamp_fn DATETIME NOT NULL,
load_id BIGNUMERIC(38) NOT NULL
);