CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_coupon_promotion_2 (client_id, coupon_promo_sid, src_coupon_promo_nr,
dwh_load_id, dwh_created, dwh_updated) AS SELECT client_id,
 coupon_promo_sid,
 src_coupon_promo_nr,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_core.t_coupon_promotion_2;