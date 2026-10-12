CREATE OR REPLACE VIEW P_LEW_MART_PIT_ONPREM.V_PIT_APT_BASE_CLIENT_PROMOTIONPERIOD_ITEM_DENORM

      (
           client_id
,          adv_week_id
,          item_sid
,          item_description
,          adv_period_id
,          promotion_start_dt
,          promotion_end_dt
,          action_type_id             --    based on promotion_start_dt
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
   Apt.client_id                 AS client_id
,   Apt.adv_week_id               AS adv_week_id
,   Apt.item_sid                  AS item_sid
,   ItmCd.item_Description        AS item_description
,   Apt.adv_period_id             AS adv_period_id
,   Apt.promotion_start_dt        AS promotion_start_dt
,   Apt.promotion_end_dt          AS promotion_end_dt
,   ItmCd.action_type_id          AS action_type_id
,   Apt.advert_theme_sid          AS advert_theme_sid
,   Theme.advert_theme            AS advert_theme
,   Apt.item_list_type_id         AS item_list_type_id
,   LType.item_list_type          AS item_list_type
,   Apt.sortiment_fg              AS sortiment_fg
,   Apt.retail_price_old          AS retail_price_old
,   Apt.retail_price_new          AS retail_price_new
,   Apt.same_apt_price_fg         AS same_apt_price_fg
,   Apt.promotion_truncated_fg    AS promotion_truncated_fg
,   Apt.promotion_deleted_fg      AS promotion_deleted_fg
,   Apt.promotion_excluded_fg     AS promotion_excluded_fg
   FROM p_lew_mart_pit_onprem.t_pit_apt_base_client_promotionperiod_item        Apt
   LEFT OUTER JOIN    --  inner join should do
   p_lew_mart_pit_onprem.t_pit_apt_advert_theme_client                     Theme
   ON
   Apt.client_id           =    Theme.client_id
  AND
   Apt.advert_theme_sid    =    Theme.advert_theme_sid
   LEFT OUTER JOIN    --  inner join should do
   p_lew_mart_pit_onprem.t_pit_apt_item_list_type                          LType
   ON
   Apt.item_list_type_id    =    LType.item_list_type_id
   LEFT OUTER JOIN    --  in case the item was not actually sold during those days (especially Sunday AND Holidays) - now includes apt so innner join should do
   p_lew_mart_pit_onprem.t_pit_item_client_day                            ItmCd
   ON
   Apt.client_id             =    ItmCd.client_id
  AND
   Apt.promotion_start_dt    =    ItmCd.dwh_cal_dt
  AND
   Apt.item_sid              =    ItmCd.item_sid
);