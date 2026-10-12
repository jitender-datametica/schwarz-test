CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_pos_discount (client_id, discount_sid, src_discount_nr, src_posart,
src_discount_pct, discount_descr, first_appearance_dt, lidlplus_coupon_pattern_fg, dwh_load_id, dwh_created, dwh_updated
) AS SELECT client_id,
 discount_sid,
 src_discount_nr,
 src_posart,
 src_discount_pct,
 discount_descr,
 first_appearance_dt,
 lidlplus_coupon_pattern_fg,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_core.t_pos_discount;