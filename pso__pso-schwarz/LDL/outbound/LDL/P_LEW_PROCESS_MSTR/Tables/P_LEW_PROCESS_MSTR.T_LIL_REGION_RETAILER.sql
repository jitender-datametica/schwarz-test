CREATE TABLE IF NOT EXISTS ldl_p_lew_process_mstr.t_lil_region_retailer (
client_id BIGNUMERIC(38,0) NOT NULL,
region_sid BIGNUMERIC(38,0) NOT NULL,
retailer_sid BIGNUMERIC(38,0),
rtl_id BIGNUMERIC(38,0) NOT NULL,
region_rtl_desc_de STRING(100) COLLATE 'und:ci',
region_rtl_desc_en STRING(100) COLLATE 'und:ci',
rtl_lvl BIGNUMERIC(38,0) NOT NULL,
active_fg BIGNUMERIC(38,0),
dwh_load_id BIGNUMERIC(38,0) NOT NULL,
dwh_created TIMESTAMP NOT NULL,
dwh_updated TIMESTAMP NOT NULL,
td_insert TIMESTAMP,
td_update TIMESTAMP
) CLUSTER BY client_id;