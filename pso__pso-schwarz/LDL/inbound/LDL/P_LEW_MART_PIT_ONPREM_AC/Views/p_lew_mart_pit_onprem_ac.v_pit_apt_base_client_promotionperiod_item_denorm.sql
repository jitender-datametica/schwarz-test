CREATE OR REPLACE VIEW P_LEW_MART_PIT_ONPREM_AC.V_PIT_APT_BASE_CLIENT_PROMOTIONPERIOD_ITEM_DENORM
(
     client_id

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
Bcp.client_id                 AS client_id
,Bcp.adv_week_id               AS adv_week_id
,Bcp.item_sid                  AS item_sid
,Bcp.item_description          AS item_description
,Bcp.adv_period_id             AS adv_period_id
,Bcp.promotion_start_dt        AS promotion_start_dt
,Bcp.promotion_end_dt          AS promotion_end_dt
,Bcp.action_type_id            AS action_type_id
,Bcp.advert_theme_sid          AS advert_theme_sid
,Bcp.advert_theme              AS advert_theme
,Bcp.item_list_type_id         AS item_list_type_id
,Bcp.item_list_type            AS item_list_type
,Bcp.sortiment_fg              AS sortiment_fg
,Bcp.retail_price_old          AS retail_price_old
,Bcp.retail_price_new          AS retail_price_new
,Bcp.same_apt_price_fg         AS same_apt_price_fg
,Bcp.promotion_truncated_fg    AS promotion_truncated_fg
,Bcp.promotion_deleted_fg      AS promotion_deleted_fg
,Bcp.promotion_excluded_fg     AS promotion_excluded_fg
FROM p_lew_mart_pit_onprem.v_pit_apt_base_client_promotionperiod_item_denorm        AS Bcp
);