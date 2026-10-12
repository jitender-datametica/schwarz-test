CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_map_sales_to_lidlplus_coupon (client_id, coupon_sid, ejr_discount_id,
dwh_load_id, dwh_created, dwh_updated) AS SELECT client_id,
 coupon_sid,
 ejr_discount_id,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_core.t_map_sales_to_lidlplus_coupon;