CREATE TABLE IF NOT EXISTS ldl_p_lew_load.t_tcache_storage_fes (
client_id BIGNUMERIC(38,0) NOT NULL,
loc_sid_wh BIGNUMERIC(38,0) NOT NULL,
src_orig_wh_nr BIGNUMERIC(38,0) NOT NULL,
dat_formdate DATE,
loc_sid_store BIGNUMERIC(38,0) NOT NULL,
src_orig_store_nr BIGNUMERIC(38,0) NOT NULL,
item_sid BIGNUMERIC(38,0) NOT NULL,
src_orig_item_nr INTEGER NOT NULL,
pallet_id INTEGER,
qty_storage_room NUMERIC(18,4),
qty_sales_area NUMERIC(18,4),
price NUMERIC(18,4),
dat_dayend DATE,
dwh_load_id BIGNUMERIC(38,0) NOT NULL,
dwh_cal_dt DATE,
dwh_created DATETIME NOT NULL,
dwh_updated DATETIME NOT NULL
);