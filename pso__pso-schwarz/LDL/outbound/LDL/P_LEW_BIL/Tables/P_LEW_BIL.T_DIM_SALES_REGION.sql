CREATE TABLE IF NOT EXISTS ldl_p_lew_bil.t_dim_sales_region (
client_id BIGNUMERIC(38,0) NOT NULL,
sales_region_sid BIGNUMERIC(38,0) NOT NULL,
sales_region_manager_nr STRING(20) COLLATE 'und:ci',
sales_region_manager_name STRING(100),
lidl_country_cd STRING(20) COLLATE 'und:ci' NOT NULL,
lidl_country_name STRING(100) NOT NULL,
country_grp_sid BIGNUMERIC(38,0) NOT NULL,
country_grp_manager_name STRING(100),
dwh_load_id BIGNUMERIC(38,0) NOT NULL,
dwh_created DATETIME NOT NULL,
dwh_updated DATETIME NOT NULL
) CLUSTER BY client_id;