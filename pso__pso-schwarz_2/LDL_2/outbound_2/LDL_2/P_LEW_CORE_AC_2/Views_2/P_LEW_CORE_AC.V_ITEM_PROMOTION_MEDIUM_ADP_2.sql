CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_item_promotion_medium_adp_2 (client_id, item_sid, promotion_dt,
advertising_medium_cd, advertising_medium_pos, deleted_fg, dwh_load_id, dwh_created, dwh_updated) AS SELECT client_id,
 item_sid,
 promotion_dt,
 advertising_medium_cd,
 advertising_medium_pos,
 deleted_fg,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_core.t_item_promotion_medium_adp_2;