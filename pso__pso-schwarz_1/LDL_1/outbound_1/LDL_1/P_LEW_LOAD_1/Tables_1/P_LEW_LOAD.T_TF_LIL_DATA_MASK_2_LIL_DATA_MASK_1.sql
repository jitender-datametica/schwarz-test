CREATE TABLE IF NOT EXISTS ldl_p_lew_load.t_tf_lil_data_mask_2_lil_data_mask_1 (
client_id BIGNUMERIC(38) NOT NULL,
lidl_country STRING(40) NOT NULL,
lil_data_mask_src_region_cd STRING(250) NOT NULL,
lil_data_mask_src_period_cd STRING(250) NOT NULL,
lil_data_mask_src_assort_parent_cat_cd STRING(250) NOT NULL,
lil_data_mask_interface_name STRING(250) NOT NULL,
src_region_cd STRING(40) NOT NULL,
src_period_cd STRING(40) NOT NULL,
src_assort_parent_cat_cd STRING(100) COLLATE 'und:ci' NOT NULL,
interface_name STRING(20) COLLATE 'und:ci' NOT NULL,
mask_data_fg BIGNUMERIC(38) NOT NULL,
extraction_dt DATE,
dwh_mapping_dt DATE NOT NULL,
tf_error_fg INTEGER,
record_id STRING(300) NOT NULL,
filename STRING(1000) NOT NULL
);