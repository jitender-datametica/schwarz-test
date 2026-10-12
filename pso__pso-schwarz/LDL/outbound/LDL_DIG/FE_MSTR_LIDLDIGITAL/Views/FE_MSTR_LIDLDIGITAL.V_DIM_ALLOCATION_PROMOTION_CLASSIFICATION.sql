CREATE OR REPLACE VIEW ldl_dig_fe_mstr_lidldigital.v_dim_allocation_promotion_classification AS SELECT
 alloc_promo_class_cd,
 alloc_promo_class_descr
FROM ldl_dig_lec_share.v_dim_allocation_promotion_classification
UNION ALL
SELECT '-1' AS dm__operand0,
 '' AS dm__operand1;