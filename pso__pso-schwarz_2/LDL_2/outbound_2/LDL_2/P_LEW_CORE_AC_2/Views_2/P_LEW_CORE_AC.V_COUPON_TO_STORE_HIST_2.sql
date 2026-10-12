CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_coupon_to_store_hist_2 (client_id, coupon_sid, loc_sid_store, loyalty_prog_cd,
coupon_relation_type_cd, deleted_fg, dwh_valid_from, dwh_valid_to, dwh_load_id, dwh_created, dwh_updated) AS SELECT
 client_id,
 coupon_sid,
 loc_sid_store,
 loyalty_prog_cd,
 coupon_relation_type_cd,
 deleted_fg,
 dwh_valid_from,
 dwh_valid_to,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_core.t_coupon_to_store_hist_2;