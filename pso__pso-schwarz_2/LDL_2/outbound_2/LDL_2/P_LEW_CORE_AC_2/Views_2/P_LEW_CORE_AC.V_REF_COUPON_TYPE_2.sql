CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_ref_coupon_type_2 (coupon_type_cd, coupon_type_short_descr, coupon_type_descr,
dwh_load_id, dwh_created, dwh_updated) AS SELECT coupon_type_cd,
 coupon_type_short_descr,
 coupon_type_descr,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_core.t_ref_coupon_type_2;