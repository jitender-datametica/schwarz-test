CREATE TABLE IF NOT EXISTS ldl_fe_mstr_toolbox_spiegel.t_client_storage_test_result_parameter_list (
client_id BIGNUMERIC(38,0),
storage_test_exec_sid BIGNUMERIC(38,0),
orig_store_nr BIGNUMERIC(38,0),
reconstructin_week_list STRING(16777216),
excluded_week_list STRING(16777216)
);