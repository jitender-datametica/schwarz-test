CREATE OR REPLACE VIEW ldl_p_lew_mart_msi_ac.v_pallet_rcv_wh_day_spot_1 (client_id, wh_id, aspect_id, currency_iso_cd,
business_yr, month_id, week_id, cy_partial_week, dat_calendar, cy_month_sequence, last_cwd_fg, last_cmd_fg, record_type
, dup_fg, pallet_rcv, pallet_time, p1y_cwd_pallet_rcv, p1y_cwd_pallet_time, p1y_cmd_pallet_rcv, p1y_cmd_pallet_time) AS
SELECT *
FROM ldl_p_lew_mart_msi.v_pallet_rcv_wh_day_spot_1;