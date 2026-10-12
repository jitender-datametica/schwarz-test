CREATE OR REPLACE VIEW ldl_dig_fe_mstr_lidldigital.v_dim_travel_booking_coupon_1 AS SELECT trav_booking_coupon_cd,
 trav_booking_coupon_descr
FROM ldl_dig_lec_share.v_dim_travel_booking_coupon_1
UNION ALL
SELECT '-1' AS dm__operand0,
 '' AS dm__operand1;