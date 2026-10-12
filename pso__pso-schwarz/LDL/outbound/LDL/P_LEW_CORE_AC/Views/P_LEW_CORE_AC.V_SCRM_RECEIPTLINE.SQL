CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_scrm_receiptline (client_id, loc_sid, register_id, receipt_id, receiptline_nr
, dwh_cal_dt, coupon_promo_sid, src_coupon_promo_nr, src_discount_nr, dwh_load_id, dwh_created, dwh_updated,
receipt_tmsp, receiptline_voided) AS SELECT client_id,
 loc_sid,
 register_id,
 receipt_id,
 receiptline_nr,
 dwh_cal_dt,
 coupon_promo_sid,
 src_coupon_promo_nr,
 src_discount_nr,
 dwh_load_id,
 dwh_created,
 dwh_updated,
 receipt_tmsp,
 receiptline_voided
FROM ldl_p_lew_core.t_scrm_receiptline;