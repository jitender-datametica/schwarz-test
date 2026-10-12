CREATE TABLE IF NOT EXISTS ldl_fe_mstr_toolbox_spiegel.t_storage_test_result_missing_store (
storage_test_exec_sid BIGNUMERIC(38,0),
storage_test_result_grp_sid BIGNUMERIC(38,0),
storage_test_result_grp_type_cd STRING(50),
test_week BIGNUMERIC(38,0),
reason_descr STRING(250),
user_defined_grp_name STRING(100)
);