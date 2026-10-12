CREATE OR REPLACE VIEW ldl_dig_fe_mstr_lidldigital.v_fact_product_price_warehouse_no_gc_lc_1 AS SELECT IFNULL(FACT_PPW.wh_sid
  , -1) AS wh_sid,
 IFNULL(FACT_PPW.prod_variant_sid, -1) AS prod_variant_sid,
  CASE
  WHEN FACT_PPW.price_type_cd = ''
  THEN '-1'
  ELSE IFNULL(FACT_PPW.price_type_cd, '-1')
  END AS price_type_cd,
  CASE
  WHEN FACT_PPW.price_group_cd = ''
  THEN '-1'
  ELSE IFNULL(FACT_PPW.price_group_cd, '-1')
  END AS price_group_cd,
  CASE
  WHEN FACT_PPW.curr_cd = ''
  THEN '-1'
  ELSE IFNULL(FACT_PPW.curr_cd, '-1')
  END AS curr_cd,
  FACT_PPW.price_val / FACT_CER.exchange_rate AS price_eur_val,
 FACT_PPW.price_val AS price_local_val,
  CASE
  WHEN FACT_PPW.wh_cd = ''
  THEN '-1'
  ELSE IFNULL(FACT_PPW.wh_cd, '-1')
  END AS wh_cd,
 FACT_PPW.prod_variant_nr,
 FACT_PPW.is_substitution_price_fg
FROM ldl_dig_lec_share.v_fact_product_price_warehouse_1 AS FACT_PPW
 INNER JOIN ldl_dig_lec_share.v_fact_currency_exchange_rate_1 AS FACT_CER ON FACT_PPW.curr_cd = FACT_CER.from_curr_cd AND
   FACT_CER.active_fg AND FACT_CER.to_curr_cd = 'EUR'
 INNER JOIN ldl_dig_lec_share.v_dim_currency_exchange_rate_type_1 AS DIM_CERT ON FACT_CER.curr_exchange_rate_type_cd =
   DIM_CERT.curr_exchange_rate_type_cd AND DIM_CERT.is_general_used_fg
WHERE FACT_PPW.dwh_valid_fg;