CREATE OR REPLACE VIEW ldl_p_lew_mart_pit_onprem.v_pit_apt_base_client_promotionperiod_item_denorm_2 (client_id,
adv_week_id, item_sid, item_description, adv_period_id, promotion_start_dt, promotion_end_dt, action_type_id,
advert_theme_sid, advert_theme, item_list_type_id, item_list_type, sortiment_fg, retail_price_old, retail_price_new,
same_apt_price_fg, promotion_truncated_fg, promotion_deleted_fg, promotion_excluded_fg) AS SELECT APT.client_id,
 APT.adv_week_id,
 APT.item_sid,
 ITMCD.item_description,
 APT.adv_period_id,
 APT.promotion_start_dt,
 APT.promotion_end_dt,
 ITMCD.action_type_id,
 APT.advert_theme_sid,
 THEME.advert_theme,
 APT.item_list_type_id,
 LTYPE.item_list_type,
 APT.sortiment_fg,
 APT.retail_price_old,
 APT.retail_price_new,
 APT.same_apt_price_fg,
 APT.promotion_truncated_fg,
 APT.promotion_deleted_fg,
 APT.promotion_excluded_fg
FROM ldl_p_lew_mart_pit_onprem.t_pit_apt_base_client_promotionperiod_item_2 AS APT
 LEFT JOIN ldl_p_lew_mart_pit_onprem.t_pit_apt_advert_theme_client_2 AS THEME ON APT.client_id = THEME.client_id AND APT.advert_theme_sid
    = THEME.advert_theme_sid
 LEFT JOIN ldl_p_lew_mart_pit_onprem.t_pit_apt_item_list_type_2 AS LTYPE ON APT.item_list_type_id = LTYPE.item_list_type_id
  
 LEFT JOIN ldl_p_lew_mart_pit_onprem.t_pit_item_client_day_2 AS ITMCD ON APT.client_id = ITMCD.client_id AND APT.promotion_start_dt
     = ITMCD.dwh_cal_dt AND APT.item_sid = ITMCD.item_sid;