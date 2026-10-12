CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_ref_coupon_promotion_type_2 (coupon_promo_type_sid, coupon_promo_type_descr,
dwh_load_id, dwh_created, dwh_updated) AS SELECT coupon_promo_type_sid,
 coupon_promo_type_descr,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_core.t_ref_coupon_promotion_type_2;