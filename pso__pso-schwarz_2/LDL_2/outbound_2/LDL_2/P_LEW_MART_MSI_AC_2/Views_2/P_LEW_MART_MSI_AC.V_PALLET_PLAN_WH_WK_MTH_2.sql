CREATE OR REPLACE VIEW ldl_p_lew_mart_msi_ac.v_pallet_plan_wh_wk_mth_2 (client_id, wh_id, aspect_id, currency_iso_cd, byr
, cy_month, cy_week_partial_week_id, cy_month_sequence, record_type, pallet_plan_rcv_cum_mth, pallet_plan_time_cum_mth,
pallet_plan_rcv_cum_yr, pallet_plan_time_cum_yr) AS SELECT *
FROM ldl_p_lew_mart_msi.v_pallet_plan_wh_wk_mth_2;