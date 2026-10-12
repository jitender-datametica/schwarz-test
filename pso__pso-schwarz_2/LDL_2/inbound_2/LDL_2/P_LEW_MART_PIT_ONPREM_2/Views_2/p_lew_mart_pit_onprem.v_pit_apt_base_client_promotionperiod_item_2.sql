CREATE OR REPLACE VIEW P_LEW_MART_PIT_ONPREM.V_PIT_APT_BASE_CLIENT_PROMOTIONPERIOD_ITEM_2
AS
SELECT
  client_id
, adv_week_id
, item_sid
, adv_period_id
, promotion_start_dt
, promotion_end_dt
, promotion_end_dt_created_fg
, promotion_end_dt_truncated_fg
, promotion_period_orig_days
, advert_theme_sid
, item_list_type_id
, sortiment_fg
, retail_price_old
, retail_price_new
, same_apt_price_fg
, promotion_truncated_fg
, promotion_deleted_fg
, promotion_excluded_fg
FROM p_lew_mart_pit_onprem.t_pit_apt_base_client_promotionperiod_item_2;