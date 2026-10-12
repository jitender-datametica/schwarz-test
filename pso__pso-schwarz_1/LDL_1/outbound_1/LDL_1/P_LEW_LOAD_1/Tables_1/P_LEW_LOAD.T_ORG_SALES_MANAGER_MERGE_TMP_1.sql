CREATE TABLE IF NOT EXISTS ldl_p_lew_load.t_org_sales_manager_merge_tmp_1 (
aspect_id BIGNUMERIC(38) NOT NULL,
client_id BIGNUMERIC(38) NOT NULL,
wh_loc_sid BIGNUMERIC(38) NOT NULL,
wh_loc_sid_exp BIGNUMERIC(38) NOT NULL,
sales_manager_id BIGNUMERIC(38) NOT NULL,
account_manager_id BIGNUMERIC(38),
sales_manager_name STRING(50) COLLATE 'und:ci'
);