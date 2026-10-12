CREATE OR REPLACE VIEW P_LEW_MART_PIT_ONPREM_AC.V_PIT_APT_BASE_CLIENT_DAY_ITEM_DENORM
(
     client_id

,          dwh_cal_dt

,          adv_week_id

,          item_sid

,          item_description

,          adv_period_id

,          promotion_start_dt

,          promotion_end_dt

,          action_type_id

,          advert_theme_sid

,          advert_theme

,          item_list_type_id

,          item_list_type

,          sortiment_fg

,          retail_price_old

,          retail_price_new

,          same_apt_price_fg

,          promotion_truncated_fg

,          promotion_deleted_fg

,          promotion_excluded_fg
)
AS
(SELECT
Bcd.client_id                 AS client_id
,Bcd.dwh_cal_dt                AS dwh_cal_dt
,Bcd.adv_week_id               AS adv_week_id
,Bcd.item_sid                  AS item_sid
,Bcd.item_description          AS item_description
,Bcd.adv_period_id             AS adv_period_id
,Bcd.promotion_start_dt        AS promotion_start_dt
,Bcd.promotion_end_dt          AS promotion_end_dt
,Bcd.action_type_id            AS action_type_id
,Bcd.advert_theme_sid          AS advert_theme_sid
,Bcd.advert_theme              AS advert_theme
,Bcd.item_list_type_id         AS item_list_type_id
,Bcd.item_list_type            AS item_list_type
,Bcd.sortiment_fg              AS sortiment_fg
,Bcd.retail_price_old          AS retail_price_old
,Bcd.retail_price_new          AS retail_price_new
,Bcd.same_apt_price_fg         AS same_apt_price_fg
,Bcd.promotion_truncated_fg    AS promotion_truncated_fg
,Bcd.promotion_deleted_fg      AS promotion_deleted_fg
,Bcd.promotion_excluded_fg     AS promotion_excluded_fg
FROM p_lew_mart_pit_onprem.v_pit_apt_base_client_day_item_denorm        AS Bcd
);