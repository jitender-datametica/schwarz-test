CREATE TABLE IF NOT EXISTS ldl_p_lew_load.t_tf_lil_region_retailer_2_lil_region_retailer_2 (
client_id BIGNUMERIC(38) NOT NULL,
lidl_country STRING(40) NOT NULL,
lil_region_retailer_src_region_cd STRING(250) NOT NULL,
lil_region_retailer_src_retailer_cd STRING(250) NOT NULL,
src_region_cd STRING(200) NOT NULL,
src_retailer_cd STRING(200) NOT NULL,
rtl_id BIGNUMERIC(38) NOT NULL,
region_rtl_desc_de STRING(100) COLLATE 'und:ci',
region_rtl_desc_en STRING(100) COLLATE 'und:ci',
rtl_lvl BIGNUMERIC(38) NOT NULL,
active_fg BIGNUMERIC(38),
extraction_dt DATE,
dwh_mapping_dt DATE NOT NULL,
tf_error_fg INTEGER,
record_id STRING(300) NOT NULL,
filename STRING(1000) NOT NULL
);