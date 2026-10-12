CREATE OR REPLACE VIEW ldl_p_lew_mart_analytics.v_ftm_sales_piece_perf_hours_1 (client_id, country_code, dat_formdate,
cy_week, store_id, orig_store_nr, work_time_total_hr, piece_performance) AS SELECT SDPP.client_id,
 RCTRY.country_iso_cd AS country_code,
 SDPP.dwh_cal_dt AS dat_formdate,
 TAG.cy_week,
 SDPP.loc_sid_store AS store_id,
 SDPP.src_orig_store_nr AS orig_store_nr,
 SDPP.work_time_total_hr,
 SDPP.piece_performance
FROM ldl_p_lew_bil_ac.v_agg_store_day_piece_perf_1 AS SDPP
 INNER JOIN ldl_p_lew_mart_msi_ac.v_cal_calendarday_1 AS TAG_1 ON SDPP.dwh_cal_dt = TAG.dat_calendar
 INNER JOIN ldl_p_lew_mart_msi_ac.v_ref_country_1 AS RCTRY ON SDPP.client_id = RCTRY.country_id
WHERE SDPP.currency_iso_cd = 'EUR';