CREATE OR REPLACE VIEW ldl_dig_fe_mstr_lidldigital.v_fact_coupon_validation_no_gc_lc AS WITH COL_GROUPED AS (SELECT MAX(cust_order_dt
    ) AS cust_order_dt,
   cust_order_sid,
   prod_variant_sid
  FROM ldl_dig_lec_share.v_fact_customer_order_line
  GROUP BY cust_order_sid,
   prod_variant_sid) (SELECT FACT_CP.coupon_validation_nr,
   IFNULL(FACT_CP.cust_order_sid, -1) AS cust_order_sid,
   IFNULL(FACT_CP.prod_variant_sid, -1) AS prod_variant_sid,
   IFNULL(FACT_CP.coupon_id, '-1') AS coupon_id,
    CASE
    WHEN FACT_CP.coupon_cd = ''
    THEN '-1'
    ELSE IFNULL(FACT_CP.coupon_cd, '-1')
    END AS coupon_cd,
    CASE
    WHEN FACT_CP.coupon_promo_cd = ''
    THEN '-1'
    ELSE IFNULL(FACT_CP.coupon_promo_cd, '-1')
    END AS coupon_promo_cd,
    CASE
    WHEN FACT_CP.profit_loss_reason_cd = ''
    THEN '-1'
    ELSE IFNULL(FACT_CP.profit_loss_reason_cd, '-1')
    END AS profit_loss_reason_cd,
    CASE
    WHEN FACT_CP.curr_cd = ''
    THEN '-1'
    ELSE IFNULL(FACT_CP.curr_cd, '-1')
    END AS curr_cd,
    CASE
    WHEN FACT_CP.wshop_cd = ''
    THEN '-1'
    ELSE IFNULL(FACT_CP.wshop_cd, '-1')
    END AS wshop_cd,
   FACT_CP.prod_qty,
   CAST(PARSE_TIMESTAMP('%c%z', FORMAT_TIMESTAMP('%c%z', CAST(FACT_CP.coupon_validation_tmsp AS TIMESTAMP), 'Europe/Berlin')) AS DATETIME)
   AS coupon_validation_tmsp,
   FACT_CP.coupon_ship_gross_local_val,
    FACT_CP.coupon_ship_gross_local_val / FACT_CER.exchange_rate AS coupon_ship_gross_eur_val,
   FACT_CP.coupon_item_gross_local_val,
    FACT_CP.coupon_item_gross_local_val / FACT_CER.exchange_rate AS coupon_item_gross_eur_val,
   FACT_CP.coupon_pos_gross_local_val,
    FACT_CP.coupon_pos_gross_local_val / FACT_CER.exchange_rate AS coupon_pos_gross_eur_val
  FROM ldl_dig_lec_share.v_fact_coupon_validation AS FACT_CP
   INNER JOIN COL_GROUPED AS FACT_COL ON FACT_CP.cust_order_sid = FACT_COL.cust_order_sid AND FACT_CP.prod_variant_sid =
     FACT_COL.prod_variant_sid
   INNER JOIN ldl_dig_lec_share.v_fact_currency_exchange_rate AS FACT_CER ON FACT_CP.curr_cd = FACT_CER.from_curr_cd AND
      FACT_COL.cust_order_dt BETWEEN FACT_CER.active_from_dt AND FACT_CER.active_to_dt AND FACT_CER.to_curr_cd = 'EUR'
   INNER JOIN ldl_dig_lec_share.v_dim_currency_exchange_rate_type AS DIM_CERT ON FACT_CER.curr_exchange_rate_type_cd =
     DIM_CERT.curr_exchange_rate_type_cd AND DIM_CERT.is_general_used_fg);