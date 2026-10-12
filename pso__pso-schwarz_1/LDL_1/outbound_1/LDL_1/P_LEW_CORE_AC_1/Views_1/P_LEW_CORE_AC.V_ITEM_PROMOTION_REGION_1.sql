CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_item_promotion_region_1 (client_id, item_sid, promotion_dt, region_cd,
deleted_fg, dwh_load_id, dwh_created, dwh_updated) AS SELECT client_id,
 item_sid,
 promotion_dt,
 region_cd,
 deleted_fg,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_core.t_item_promotion_region_1;