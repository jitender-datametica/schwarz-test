CREATE OR REPLACE VIEW ldl_fe_mstr_toolbox_spiegel.v_storage_test_result_parameter_2 (storage_test_exec_sid, orig_store_nr
, store_desc, end_week, end_week_display, analysis_start_week, analysis_start_week_display, analysis_end_week,
analysis_end_week_display, sales_area, top_measure_1, top_measure_2, top_measure_3, top_measure_4, top_measure_5,
reconstruction_week, excluded_week, excluded_week_header, test_week_cnt, reconstruction_week_status, kw_aggregate_until
) AS SELECT *
FROM ldl_fe_mstr_toolbox_spiegel.t_storage_test_result_parameter_2;