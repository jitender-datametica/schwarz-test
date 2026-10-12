CREATE OR REPLACE VIEW ldl_p_lew_mart_pit_onprem.v_pit_apt_medium_client_promotionperiod_item_1 (client_id, adv_week_id,
item_sid, adv_period_id, promotion_start_dt, promotion_end_dt, advert_medium_sid, anl_advert_medium_sid, advert_medium,
advert_medium_group_sid, advert_medium_group, advert_medium_ignore_fg, advert_medium_delete_fg, medium_deleted_fg) AS
SELECT client_id,
 adv_week_id,
 item_sid,
 adv_period_id,
 promotion_start_dt,
 promotion_end_dt,
 advert_medium_sid,
 anl_advert_medium_sid,
 advert_medium,
 advert_medium_group_sid,
 advert_medium_group,
 advert_medium_ignore_fg,
 advert_medium_delete_fg,
 medium_deleted_fg
FROM ldl_p_lew_mart_pit_onprem.t_pit_apt_medium_client_promotionperiod_item_1 AS MED;