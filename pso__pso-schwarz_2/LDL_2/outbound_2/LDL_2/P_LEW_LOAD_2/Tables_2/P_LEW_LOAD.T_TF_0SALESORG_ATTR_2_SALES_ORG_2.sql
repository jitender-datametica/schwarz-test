CREATE TABLE IF NOT EXISTS ldl_p_lew_load.t_tf_0salesorg_attr_2_sales_org_2 (
client_id BIGNUMERIC(38),
lidl_country STRING(40),
salesorg_attr_vkorg STRING(8),
src_vkorg STRING(20),
sales_org_name STRING(100) COLLATE 'und:ci',
src_bukrs STRING(40),
extraction_dt DATE,
dwh_mapping_dt DATE,
tf_error_fg INTEGER,
record_id INTEGER,
filename STRING(1000)
);