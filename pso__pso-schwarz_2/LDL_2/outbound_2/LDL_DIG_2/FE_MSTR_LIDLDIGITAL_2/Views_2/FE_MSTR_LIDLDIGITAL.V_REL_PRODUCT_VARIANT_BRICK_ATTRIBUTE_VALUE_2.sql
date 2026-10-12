CREATE OR REPLACE VIEW ldl_dig_fe_mstr_lidldigital.v_rel_product_variant_brick_attribute_value_2 AS SELECT IFNULL(DIM_PV.prod_variant_sid
  , -1) AS prod_variant_sid,
  CASE
  WHEN DIM_PBA.attr_cd = ''
  THEN '-1'
  ELSE IFNULL(DIM_PBA.attr_cd, '-1')
  END AS attr_cd,
 DIM_PBA.attr_descr,
  CASE
  WHEN REL_PROD_BRICK.value_cd = ''
  THEN '-1'
  ELSE IFNULL(REL_PROD_BRICK.value_cd, '-1')
  END AS value_cd,
 REL_PROD_BRICK.value_descr
FROM ldl_dig_lec_share.v_dim_product_variant_2 AS DIM_PV
 LEFT JOIN ldl_dig_lec_share.v_rel_brick_code_attribute_2 AS DIM_PBA ON DIM_PV.prod_brick_cd = DIM_PBA.prod_brick_cd
 LEFT JOIN ldl_dig_lec_share.v_rel_product_variant_brick_attribute_value_2 AS REL_PROD_BRICK ON DIM_PBA.prod_brick_cd =
     REL_PROD_BRICK.prod_brick_cd AND DIM_PBA.attr_cd = REL_PROD_BRICK.attr_cd AND DIM_PV.prod_variant_sid =
    REL_PROD_BRICK.prod_variant_sid AND REL_PROD_BRICK.dwh_valid_fg
WHERE DIM_PV.dwh_valid_fg;