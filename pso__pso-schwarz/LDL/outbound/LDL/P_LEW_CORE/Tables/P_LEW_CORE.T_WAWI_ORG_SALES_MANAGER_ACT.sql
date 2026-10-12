CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_wawi_org_sales_manager_act (
client_id BIGNUMERIC(38,0) NOT NULL,
wh_loc_sid BIGNUMERIC(38,0) NOT NULL,
st_loc_sid BIGNUMERIC(38,0) NOT NULL,
sales_manager_id BIGNUMERIC(38,0) NOT NULL,
sales_manager_name STRING(50) COLLATE 'und:ci',
account_manager_id BIGNUMERIC(38,0) NOT NULL
);