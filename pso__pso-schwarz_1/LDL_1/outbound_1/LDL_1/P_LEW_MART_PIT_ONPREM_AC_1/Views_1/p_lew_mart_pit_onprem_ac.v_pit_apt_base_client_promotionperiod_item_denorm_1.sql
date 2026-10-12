CREATE OR REPLACE VIEW ldl_p_lew_mart_pit_onprem_ac.v_pit_apt_base_client_promotionperiod_item_denorm_1 (client_id,
adv_week_id, item_sid, item_description, adv_period_id, promotion_start_dt, promotion_end_dt, action_type_id,
advert_theme_sid, advert_theme, item_list_type_id, item_list_type, sortiment_fg, retail_price_old, retail_price_new,
same_apt_price_fg, promotion_truncated_fg, promotion_deleted_fg, promotion_excluded_fg) AS SELECT *
FROM ldl_p_lew_mart_pit_onprem.v_pit_apt_base_client_promotionperiod_item_denorm_1 AS BCP;