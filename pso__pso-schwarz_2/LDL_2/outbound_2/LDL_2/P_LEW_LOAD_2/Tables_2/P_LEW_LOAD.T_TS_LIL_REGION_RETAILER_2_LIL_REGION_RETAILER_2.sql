CREATE TABLE IF NOT EXISTS ldl_p_lew_load.t_ts_lil_region_retailer_2_lil_region_retailer_2 (
record_id STRING(1000) COLLATE 'und:ci',
client_id BIGNUMERIC(38),
region_sid BIGNUMERIC(38),
retailer_sid BIGNUMERIC(38),
rtl_id BIGNUMERIC(38),
region_rtl_desc_de STRING(100) COLLATE 'und:ci',
region_rtl_desc_en STRING(100) COLLATE 'und:ci',
rtl_lvl BIGNUMERIC(38),
active_fg BIGNUMERIC(38),
dwh_load_id BIGNUMERIC(38),
dwh_created DATETIME,
dwh_updated DATETIME,
dwh_mapping_dt DATE,
error_fg BIGNUMERIC(38),
error_descr STRING(1000) COLLATE 'und:ci',
filename STRING(1000) COLLATE 'und:ci',
hist_row_no BIGNUMERIC(38)
);