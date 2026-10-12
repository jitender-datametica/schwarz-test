CREATE OR REPLACE VIEW idq_production_dq_reports.v_dq_rep_ldl_wawi_era_gesellschaft_v2_1 (country_id, calculation_time,
land_1, client_id, item_sid, lidl_country_cd, wh_number, wh_name, item_number_long, item_number_short, item_case_size,
item_descr_nat, item_wg_area, item_wg_number, item_wg_descr_nat, item_family_number, item_family_descr_nat,
item_list_type, item_wh_state, item_pos_lock, item_wh_state_change_date, item_stock_qty_wh, item_stock_qty_stores,
alr_max_valid_until, item_order_wh_exists, item_sales_last_4_weeks, item_sales_last_6_months, item_wh_inventory_date,
item_wh_inventory_qty, item_promotion_date, item_state_change_recommendation) AS SELECT *
FROM idq_production_dq_reports.dq_rep_ldl_wawi_era_gesellschaft_v2_1;