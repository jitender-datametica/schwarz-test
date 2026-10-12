CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_location_hist_2 (client_id, loc_sid, loc_type_cd, loc_nr, loc_name,
loc_status_cd, wh_active_fg, closed_fg, test_store_fg, dummy_store_fg, template_store_fg, sales_wh_fg, delivery_wh_fg,
expansion_wh_fg, balance_sheet_wh_fg, owner_wh_fg, country_wh_fg, opening_dt, real_opening_dt, closing_dt, addr_sid,
global_location_nr, legal_entity_name, vat_ident_nr, loc_sid_sales_wh, loc_sid_delivery_wh, loc_sid_expansion_wh,
loc_sid_balance_sheet_wh, loc_sid_owner_wh, loc_sid_country_wh, loc_sid_successor, cost_center_nr, store_lang_cd,
default_order_unit_fg, default_min_order_unit_fg, order_buying_list_seq, sales_org_sid, pur_org_sid, bus_cal_cd,
customer_district_cd, region_cd, archive_fg, demand_plan_active_fg, distribution_channel_cd, assessment_area_cd,
division_cd, mon_opening_tm, mon_closing_tm, mon_break_start_tm, mon_break_end_tm, tue_opening_tm, tue_closing_tm,
tue_break_start_tm, tue_break_end_tm, wed_opening_tm, wed_closing_tm, wed_break_start_tm, wed_break_end_tm,
thu_opening_tm, thu_closing_tm, thu_break_start_tm, thu_break_end_tm, fri_opening_tm, fri_closing_tm, fri_break_start_tm
, fri_break_end_tm, sat_opening_tm, sat_closing_tm, sat_break_start_tm, sat_break_end_tm, sun_opening_tm, sun_closing_tm
, sun_break_start_tm, sun_break_end_tm, open_on_holidays_fg, opening_hours_per_week_cnt, opening_hours_txt, deleted_fg,
dwh_valid_from, dwh_valid_to, dwh_load_id, dwh_created, dwh_updated) AS SELECT *
FROM ldl_p_lew_core.t_location_hist_2 AS V;