CREATE OR REPLACE VIEW P_LEW_MART_PIT_ONPREM.V_PIT_APT_MEDIUM_CLIENT_PROMOTIONPERIOD_ITEM
(
  client_id
, adv_week_id
, item_sid
, adv_period_id
, promotion_start_dt
, promotion_end_dt
, advert_medium_sid
, anl_advert_medium_sid
, advert_medium
, advert_medium_group_sid
, advert_medium_group
, advert_medium_ignore_fg
, advert_medium_delete_fg
, medium_deleted_fg
)
AS
(SELECT
Med.client_id
,Med.adv_week_id
,Med.item_sid
,Med.adv_period_id
,Med.promotion_start_dt
,Med.promotion_end_dt
,Med.advert_medium_sid
,Med.anl_advert_medium_sid
,Med.advert_medium
,Med.advert_medium_group_sid
,Med.advert_medium_group
,Med.advert_medium_ignore_fg
,Med.advert_medium_delete_fg
,Med.medium_deleted_fg
FROM p_lew_mart_pit_onprem.t_pit_apt_medium_client_promotionperiod_item AS Med
);