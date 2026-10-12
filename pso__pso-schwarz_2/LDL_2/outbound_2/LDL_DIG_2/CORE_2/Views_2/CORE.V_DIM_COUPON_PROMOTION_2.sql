CREATE OR REPLACE VIEW ldl_dig_core.v_dim_coupon_promotion_2 (coupon_promo_cd, coupon_promo_name)
OPTIONS(DESCRIPTION = `A VIEW THAT CONTAINS ALL DISTINCT VALUES FOR COUPON PROMOTION CODE AND NAME FROM T_DIM_COUPON_2`)
AS SELECT DISTINCT coupon_promo_cd,
 coupon_promo_name
FROM ldl_dig_core.t_dim_coupon_2;