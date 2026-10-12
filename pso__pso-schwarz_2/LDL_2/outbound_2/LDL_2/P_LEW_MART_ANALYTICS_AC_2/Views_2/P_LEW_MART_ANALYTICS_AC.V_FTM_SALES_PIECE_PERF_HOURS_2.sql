CREATE OR REPLACE VIEW ldl_p_lew_mart_analytics_ac.v_ftm_sales_piece_perf_hours_2 (client_id, country_code, dat_formdate,
cy_week, store_id, orig_store_nr, work_time_total_hr, piece_performance) AS SELECT *
FROM ldl_p_lew_mart_analytics.v_ftm_sales_piece_perf_hours_2;