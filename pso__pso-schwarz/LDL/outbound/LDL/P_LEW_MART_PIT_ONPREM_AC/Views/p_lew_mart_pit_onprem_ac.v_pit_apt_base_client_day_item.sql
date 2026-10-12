CREATE OR REPLACE VIEW ldl_p_lew_mart_pit_onprem_ac.v_pit_apt_base_client_day_item (client_id, dwh_cal_dt, adv_week_id,
item_sid, adv_period_id, promotion_start_dt, promotion_end_dt, advert_theme_sid, item_list_type_id, sortiment_fg,
retail_price_old, retail_price_new, same_apt_price_fg, promotion_truncated_fg, promotion_deleted_fg,
promotion_excluded_fg) AS SELECT *
FROM ldl_p_lew_mart_pit_onprem.v_pit_apt_base_client_day_item AS BCDI;