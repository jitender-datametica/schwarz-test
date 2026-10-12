CREATE OR REPLACE VIEW P_LEW_MART_PIT_ONPREM_AC.V_PIT_APT_BASE_CLIENT_DAY_ITEM_1
(
     client_id
,          dwh_cal_dt
,          adv_week_id
,          item_sid
,          adv_period_id
,          promotion_start_dt
,          promotion_end_dt
,          advert_theme_sid
,          item_list_type_id
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
Bcdi.client_id                  AS client_id
,Bcdi.dwh_cal_dt                 AS dwh_cal_dt
,Bcdi.adv_week_id                AS adv_week_id
,Bcdi.item_sid                   AS item_sid
,Bcdi.adv_period_id              AS adv_period_id
,Bcdi.promotion_start_dt         AS promotion_start_dt
,Bcdi.promotion_end_dt           AS promotion_end_dt
,Bcdi.advert_theme_sid           AS advert_theme_sid
,Bcdi.item_list_type_id          AS item_list_type_id
,Bcdi.sortiment_fg               AS sortiment_fg
,Bcdi.retail_price_old           AS retail_price_old
,Bcdi.retail_price_new           AS retail_price_new
,Bcdi.same_apt_price_fg          AS same_apt_price_fg
,Bcdi.promotion_truncated_fg     AS promotion_truncated_fg
,Bcdi.promotion_deleted_fg       AS promotion_deleted_fg
,Bcdi.promotion_excluded_fg      AS promotion_excluded_fg
FROM p_lew_mart_pit_onprem.v_pit_apt_base_client_day_item_1        AS Bcdi
);