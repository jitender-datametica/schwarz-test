CREATE OR REPLACE VIEW ldl_dig_fe_mstr_lidldigital.v_dim_coupon_promotion_1 (coupon_promo_cd, coupon_promo_name) AS SELECT
 *
FROM ldl_dig_lec_share.v_dim_coupon_promotion_core_view_1
UNION ALL
SELECT '-1',
 '';