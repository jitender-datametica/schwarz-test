CREATE OR REPLACE VIEW P_LEW_MART_PIT_ONPREM.V_PIT_APT_BASE_CLIENT_DAY_ITEM_1

(
  client_id
, dwh_cal_dt
, adv_week_id
, item_sid
, adv_period_id
, promotion_start_dt
, promotion_end_dt
, advert_theme_sid
, item_list_type_id
, sortiment_fg
, retail_price_old
, retail_price_new
, same_apt_price_fg
, promotion_truncated_fg
, promotion_deleted_fg
, promotion_excluded_fg
)
AS
   (SELECT
   Apt.client_id                 AS client_id
,   Cal.cal_dt                    AS dwh_cal_dt
,   Apt.adv_week_id               AS adv_week_id
,   Apt.item_sid                  AS item_sid
,   Apt.adv_period_id             AS adv_period_id
,   Apt.promotion_start_dt        AS promotion_start_dt
,   Apt.promotion_end_dt          AS promotion_end_dt
,   Apt.advert_theme_sid          AS advert_theme_sid
,   Apt.item_list_type_id         AS item_list_type_id
,   Apt.sortiment_fg              AS sortiment_fg
,   Apt.retail_price_old          AS retail_price_old
,   Apt.retail_price_new          AS retail_price_new
,   Apt.same_apt_price_fg         AS same_apt_price_fg
,   Apt.promotion_truncated_fg    AS promotion_truncated_fg
,   Apt.promotion_deleted_fg      AS promotion_deleted_fg
,   Apt.promotion_excluded_fg     AS promotion_excluded_fg
   FROM 
    p_lew_mart_pit_onprem.t_pit_apt_base_client_promotionperiod_item_1  Apt

    -- ##Check  
    INNER JOIN p_lew_bil_ac.v_dim_cal_day_1                             Cal
        ON Cal.cal_dt BETWEEN Apt.promotion_start_dt AND Apt.promotion_end_dt
   );