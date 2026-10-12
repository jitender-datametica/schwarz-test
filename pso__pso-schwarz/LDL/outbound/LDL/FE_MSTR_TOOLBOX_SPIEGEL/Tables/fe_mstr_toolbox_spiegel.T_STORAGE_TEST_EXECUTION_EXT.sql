CREATE TABLE IF NOT EXISTS ldl_fe_mstr_toolbox_spiegel.t_storage_test_execution_ext (
client_id BIGNUMERIC(38,0),
storage_test_exec_sid BIGNUMERIC(38,0),
storage_test_exec_name STRING(100),
end_week BIGNUMERIC(38,0),
display_end_week STRING(16777216),
dur_week_cnt BIGNUMERIC(38,0),
min_training_day_cnt BIGNUMERIC(38,0),
spread_pct BIGNUMERIC(38,5),
test_name STRING(16777216),
test_week_duration STRING(16777216),
test_status STRING(13),
filter_display_end_week STRING(16777216)
);