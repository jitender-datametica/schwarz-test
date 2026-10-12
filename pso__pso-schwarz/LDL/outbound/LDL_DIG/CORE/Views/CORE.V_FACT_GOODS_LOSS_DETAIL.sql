CREATE OR REPLACE VIEW ldl_dig_core.v_fact_goods_loss_detail (goods_loss_origin_type_cd
OPTIONS(description='\"PC\" for price chage,\"CV\" for coupon validation'), business_event_type_cd
OPTIONS(description='\"O\" for orders,\"R\" for returns'), cust_order_sid
OPTIONS(description='The unique identifier (surrogate key) for customer order'), document_nr
OPTIONS(description='The original order number or return order number from the source system'), prod_variant_sid
OPTIONS(description='Unique identifier (surrogate key) of the ordered/returned product'), prod_variant_nr
OPTIONS(description='The original number of the ordered/returned product'), wshop_cd
OPTIONS(description='The unique code for the Lidl webshop, where an order can be placed by a customer. The webshop is defined per political country.'),
event_date
OPTIONS(description='For Orders this is order_perform_dt (when delivery started). For Returns this is order_return_dt'),
cust_order_dt OPTIONS(description='The date when order was made'), curr_cd
OPTIONS(description='Currency code in which order has been payed'), delivery_src_type_cd
OPTIONS(description='The code for source location of product FROM where it is delivered i.e. FROM supplier or warehouse directly'),
profit_loss_reason_cd OPTIONS(description='The reason code associated with this profit loss event'), tax_class_cd
OPTIONS(description='The code identifying the tax class'), tax_class_pct
OPTIONS(description='What percent of the gross amount is the tax'), coupon_cd
OPTIONS(description='Code of the promotional coupon'), prod_qty
OPTIONS(description='Quantity of a particular product ordered'), tgt_price_gross_local_val
OPTIONS(description='The target price at which the product was intended to be sold, taxes included (in local currency)'),
actual_price_gross_local_val
OPTIONS(description='The actual price at which the product was sold, taxes included (in local currency)'),
coupon_pos_gross_local_val OPTIONS(description='Coupon value for product discount. Tax included (in local currency)'),
tgt_price_net_local_val
OPTIONS(description='The target price at which the product was intended to be sold, without taxes (in local currency)'),
actual_price_net_local_val
OPTIONS(description='The actual price at which the product was sold, without taxes (in local currency)'),
ivp_price_net_local_val
OPTIONS(description='Cost-of-Goods-sold, short: CoGs. Needed for calc of margin (= revenue - cogs ) (in local currency)'),
orig_loss_net_local_val
OPTIONS(description='For Price Change Losses this is the difference BETWEEN target price AND actual price. For coupon validation this is coupon value for product discount.Tax excluded (in local currency)'),
loss_net_local_val
OPTIONS(description='Same as ORIG_LOSS_NET_LOCAL_VAL but replaced by 0 if the ORIG_LOSS_NET_EUR_VAL value is higher than -0.035 and lower than 0.035, under the assumption it is a rounding issue - Only for Modul P'),
loss_split_coeff
OPTIONS(description='Coefficient how total loss amount is split BETWEEN TRANSFER_MARGIN_NET_LOCAL_VAL AND CORRECTION_COGS_NET_LOCAL_VAL'),
transfer_margin_net_local_val
OPTIONS(description='This amount is a loss that will be used to reduce the earnings AND thus affecting the margin (in local currency)'),
correction_cogs_net_local_val
OPTIONS(description='Correction value for the cost of goods sold. It is added to actual cost of goods sold to icrease losses AND thus affecting margin (in local currency)'),
tgt_price_net_eur_val
OPTIONS(description='The target price at which the product was intended to be sold, without taxes (in euro)'),
actual_price_net_eur_val OPTIONS(description='The actual price at which the product was sold, without taxes (in euro)'),
ivp_price_net_eur_val
OPTIONS(description='Cost-of-Goods-sold, short: CoGs. Needed for calc of margin (= revenue - cogs, in euro)'),
orig_loss_net_eur_val
OPTIONS(description='Coefficient how total loss amount is split BETWEEN TRANSFER_MARGIN_NET_LOCAL_VAL AND CORRECTION_COGS_NET_LOCAL_VAL (in euro)'),
loss_net_eur_val
OPTIONS(description='Same as LOSS_NET_EUR_VAL but replaced by 0 if the value is higher than -0.035 and lower than 0.035, under the assumption it is a rounding issue - Only for Modul P'),
transfer_margin_net_eur_val
OPTIONS(description='This amount is a loss that will be used to reduce the earnings AND thus affecting the margin (in euro)'),
correction_cogs_net_eur_val
OPTIONS(description='Correction value for the cost of goods sold. It is added to actual cost of goods sold to icrease losses AND thus affecting margin (in euro)'),
quality_check_cd
OPTIONS(description='Code indication data quality in a row. 0-fine, 1-error with target price, 2-error with IVP price'))
OPTIONS(DESCRIPTION = `ONE ROW FOR ALL ORDERS AND RETURNS AT [ORDER;PRODUCTVARIANT] LEVEL, PLUS ONE ROW FOR EVERY COUPON VALIDATION AT [ORDER;PRODUCTVARIANT;COUPONCODE] LEVEL. THE COLUMNS SHOW WHAT (IF ANY) IS THE LOSS AMOUNT FOR EACH OF THESE EVENTS`)
AS WITH PRICING_CONDITION AS (SELECT wshop_cd,
   prod_variant_sid,
   price_type_cd,
   active_from_tmsp,
   active_to_tmsp,
   active_from_dt,
    CASE
    WHEN active_to_dt = (LEAD(active_from_dt) OVER (PARTITION BY wshop_cd, CAST(prod_variant_sid AS STRING),
         price_type_cd ORDER BY active_from_tmsp IS NULL, active_from_tmsp))
    THEN DATE_ADD(active_to_dt, INTERVAL - 1 DAY)
    ELSE active_to_dt
    END AS active_to_dt,
   unit_price_gross_local_val,
   price_change_reason_cd
  FROM (SELECT wshop_cd,
     prod_variant_sid,
     price_type_cd,
     active_from_tmsp,
     active_to_tmsp,
     DATE(active_from_tmsp) AS active_from_dt,
     DATE(active_to_tmsp) AS active_to_dt,
     price_val AS unit_price_gross_local_val,
     price_change_reason_cd,
     ROW_NUMBER() OVER (PARTITION BY wshop_cd, CAST(prod_variant_sid AS STRING), price_type_cd, DATE(active_from_tmsp)
      ORDER BY active_from_tmsp IS NULL DESC, active_from_tmsp DESC) AS rn
    FROM ldl_dig_core.t_fact_product_pricing_condition AS PPS
    WHERE price_type_cd = 'ZVP' AND price_change_reason_cd = '130'
     OR price_type_cd = 'VKP' AND price_change_reason_cd IN ('112', '113', '114', '115', '116', '120')
     OR price_type_cd = 'AKP'
    QUALIFY (ROW_NUMBER() OVER (PARTITION BY wshop_cd, CAST(prod_variant_sid AS STRING), price_type_cd, DATE(active_from_tmsp
           ) ORDER BY active_from_tmsp IS NULL DESC, active_from_tmsp DESC)) = 1) AS t1), FIRST_VKP AS (SELECT wshop_cd
   ,
   prod_variant_sid,
   vkp_price_gross_local_val AS unit_vkp_price_gross_local_val
  FROM ldl_dig_core.t_fact_product_price_sale_ivp_gld_vkp
  WHERE first_valid_price_fg) (SELECT *
  FROM (SELECT t13.goods_loss_origin_type_cd,
      t13.business_event_type_cd,
      t13.cust_order_sid,
      t13.document_nr,
      t13.prod_variant_sid,
      t13.prod_variant_nr,
      t13.wshop_cd,
      t13.event_date,
      t13.cust_order_dt,
      t13.curr_cd,
      t13.delivery_src_type_cd,
      t13.profit_loss_reason_cd,
      t13.tax_class_cd,
      t13.tax_class_pct,
      SUBSTR(CAST(t13.coupon_cd AS STRING), 1, 50) AS coupon_cd,
      t13.prod_qty,
      t13.tgt_price_gross_local_val,
      t13.actual_price_gross_local_val,
      CAST(t13.coupon_pos_gross_local_val AS BIGNUMERIC) AS coupon_pos_gross_local_val,
      t13.tgt_price_net_local_val,
      t13.actual_price_net_local_val,
      t13.ivp_price_net_local_val,
      t13.loss_net_local_val AS orig_loss_net_local_val,
       CASE
       WHEN t13.loss_net_eur_val = 0
       THEN 0
       ELSE t13.loss_net_local_val
       END AS loss_net_local_val,
      t13.loss_split_coeff,
       CASE
       WHEN t13.loss_net_eur_val = 0
       THEN 0
       ELSE t13.transfer_margin_net_local_val
       END AS transfer_margin_net_local_val,
       CASE
       WHEN t13.loss_net_eur_val = 0
       THEN 0
       ELSE t13.correction_cogs_net_local_val
       END AS correction_cogs_net_local_val,
      t13.tgt_price_net_eur_val,
      t13.actual_price_net_eur_val,
      t13.ivp_price_net_eur_val,
      t13.orig_loss_net_eur_val,
      t13.loss_net_eur_val,
       CASE
       WHEN t13.loss_net_eur_val = 0
       THEN 0
       ELSE t13.transfer_margin_net_eur_val
       END AS transfer_margin_net_eur_val,
       CASE
       WHEN t13.loss_net_eur_val = 0
       THEN 0
       ELSE t13.correction_cogs_net_eur_val
       END AS correction_cogs_net_eur_val,
      t13.quality_check_cd
     FROM (SELECT 'PC' AS goods_loss_origin_type_cd,
        WOR.business_event_type_cd,
        WOR.cust_order_sid,
        WOR.document_nr,
        WOR.prod_variant_sid,
        WOR.prod_variant_nr,
        WOR.wshop_cd,
        WOR.event_date,
        WOR.cust_order_dt,
        WOR.curr_cd,
        WOR.delivery_src_type_cd,
        COALESCE(akp.price_change_reason_cd, vkp.price_change_reason_cd, '113') AS profit_loss_reason_cd,
        TC.tax_class_cd,
        TC.tax_class_pct,
        NULL AS coupon_cd,
        WOR.prod_qty,
        COALESCE(zvp.unit_price_gross_local_val * WOR.prod_qty, first_vkp.unit_vkp_price_gross_local_val * WOR.prod_qty
         , WOR.prod_price_gross_local_val) AS tgt_price_gross_local_val,
        COALESCE(akp.unit_price_gross_local_val * WOR.prod_qty, vkp.unit_price_gross_local_val * WOR.prod_qty, WOR.prod_price_gross_local_val
         ) AS actual_price_gross_local_val,
        NULL AS coupon_pos_gross_local_val,
         COALESCE(zvp.unit_price_gross_local_val * WOR.prod_qty, first_vkp.unit_vkp_price_gross_local_val * WOR.prod_qty
           , WOR.prod_price_gross_local_val) / (1 + TC.tax_class_pct) AS tgt_price_net_local_val,
         COALESCE(akp.unit_price_gross_local_val * WOR.prod_qty, vkp.unit_price_gross_local_val * WOR.prod_qty, WOR.prod_price_gross_local_val
          ) / (1 + TC.tax_class_pct) AS actual_price_net_local_val,
         WOR.ivp_price_net_eur_val * EXR.exchange_rate AS ivp_price_net_local_val,
          COALESCE(akp.unit_price_gross_local_val * WOR.prod_qty, vkp.unit_price_gross_local_val * WOR.prod_qty, WOR.prod_price_gross_local_val
           ) / (1 + TC.tax_class_pct) - COALESCE(zvp.unit_price_gross_local_val * WOR.prod_qty, first_vkp.unit_vkp_price_gross_local_val
             * WOR.prod_qty, WOR.prod_price_gross_local_val) / (1 + TC.tax_class_pct) AS loss_net_local_val,
         CASE
         WHEN COALESCE(zvp.unit_price_gross_local_val * WOR.prod_qty, first_vkp.unit_vkp_price_gross_local_val * WOR.prod_qty
             , WOR.prod_price_gross_local_val) / (1 + TC.tax_class_pct) <> 0
         THEN (COALESCE(zvp.unit_price_gross_local_val * WOR.prod_qty, first_vkp.unit_vkp_price_gross_local_val * WOR.prod_qty
               , WOR.prod_price_gross_local_val) / (1 + TC.tax_class_pct) - WOR.ivp_price_net_eur_val * EXR.exchange_rate
             ) / (COALESCE(zvp.unit_price_gross_local_val * WOR.prod_qty, first_vkp.unit_vkp_price_gross_local_val * WOR
              .prod_qty, WOR.prod_price_gross_local_val) / (1 + TC.tax_class_pct))
         ELSE NULL
         END AS loss_split_coeff,
          - 1 * (COALESCE(akp.unit_price_gross_local_val * WOR.prod_qty, vkp.unit_price_gross_local_val * WOR.prod_qty,
              WOR.prod_price_gross_local_val) / (1 + TC.tax_class_pct) - COALESCE(zvp.unit_price_gross_local_val * WOR.prod_qty
               , first_vkp.unit_vkp_price_gross_local_val * WOR.prod_qty, WOR.prod_price_gross_local_val) / (1 + TC.tax_class_pct
               )) * CASE
          WHEN COALESCE(zvp.unit_price_gross_local_val * WOR.prod_qty, first_vkp.unit_vkp_price_gross_local_val * WOR.prod_qty
              , WOR.prod_price_gross_local_val) / (1 + TC.tax_class_pct) <> 0
          THEN (COALESCE(zvp.unit_price_gross_local_val * WOR.prod_qty, first_vkp.unit_vkp_price_gross_local_val * WOR.prod_qty
                , WOR.prod_price_gross_local_val) / (1 + TC.tax_class_pct) - WOR.ivp_price_net_eur_val * EXR.exchange_rate
              ) / (COALESCE(zvp.unit_price_gross_local_val * WOR.prod_qty, first_vkp.unit_vkp_price_gross_local_val *
               WOR.prod_qty, WOR.prod_price_gross_local_val) / (1 + TC.tax_class_pct))
          ELSE NULL
          END AS transfer_margin_net_local_val,
          - 1 * (COALESCE(akp.unit_price_gross_local_val * WOR.prod_qty, vkp.unit_price_gross_local_val * WOR.prod_qty,
              WOR.prod_price_gross_local_val) / (1 + TC.tax_class_pct) - COALESCE(zvp.unit_price_gross_local_val * WOR.prod_qty
               , first_vkp.unit_vkp_price_gross_local_val * WOR.prod_qty, WOR.prod_price_gross_local_val) / (1 + TC.tax_class_pct
               )) * (1 - CASE
            WHEN COALESCE(zvp.unit_price_gross_local_val * WOR.prod_qty, first_vkp.unit_vkp_price_gross_local_val * WOR
                .prod_qty, WOR.prod_price_gross_local_val) / (1 + TC.tax_class_pct) <> 0
            THEN (COALESCE(zvp.unit_price_gross_local_val * WOR.prod_qty, first_vkp.unit_vkp_price_gross_local_val * WOR
                  .prod_qty, WOR.prod_price_gross_local_val) / (1 + TC.tax_class_pct) - WOR.ivp_price_net_eur_val * EXR
                .exchange_rate) / (COALESCE(zvp.unit_price_gross_local_val * WOR.prod_qty, first_vkp.unit_vkp_price_gross_local_val
                  * WOR.prod_qty, WOR.prod_price_gross_local_val) / (1 + TC.tax_class_pct))
            ELSE NULL
            END) AS correction_cogs_net_local_val,
          COALESCE(zvp.unit_price_gross_local_val * WOR.prod_qty, first_vkp.unit_vkp_price_gross_local_val * WOR.prod_qty
            , WOR.prod_price_gross_local_val) / EXR.exchange_rate / (1 + TC.tax_class_pct) AS tgt_price_net_eur_val,
          COALESCE(akp.unit_price_gross_local_val * WOR.prod_qty, vkp.unit_price_gross_local_val * WOR.prod_qty, WOR.prod_price_gross_local_val
           ) / EXR.exchange_rate / (1 + TC.tax_class_pct) AS actual_price_net_eur_val,
        WOR.ivp_price_net_eur_val,
           COALESCE(akp.unit_price_gross_local_val * WOR.prod_qty, vkp.unit_price_gross_local_val * WOR.prod_qty, WOR.prod_price_gross_local_val
            ) / EXR.exchange_rate / (1 + TC.tax_class_pct) - COALESCE(zvp.unit_price_gross_local_val * WOR.prod_qty,
             first_vkp.unit_vkp_price_gross_local_val * WOR.prod_qty, WOR.prod_price_gross_local_val) / EXR.exchange_rate
            / (1 + TC.tax_class_pct) AS orig_loss_net_eur_val,
         CASE
         WHEN COALESCE(akp.unit_price_gross_local_val * WOR.prod_qty, vkp.unit_price_gross_local_val * WOR.prod_qty, WOR
               .prod_price_gross_local_val) / EXR.exchange_rate / (1 + TC.tax_class_pct) - COALESCE(zvp.unit_price_gross_local_val
                 * WOR.prod_qty, first_vkp.unit_vkp_price_gross_local_val * WOR.prod_qty, WOR.prod_price_gross_local_val
               ) / EXR.exchange_rate / (1 + TC.tax_class_pct) > - 0.035 AND COALESCE(akp.unit_price_gross_local_val *
                WOR.prod_qty, vkp.unit_price_gross_local_val * WOR.prod_qty, WOR.prod_price_gross_local_val) / EXR.exchange_rate
               / (1 + TC.tax_class_pct) - COALESCE(zvp.unit_price_gross_local_val * WOR.prod_qty, first_vkp.unit_vkp_price_gross_local_val
                 * WOR.prod_qty, WOR.prod_price_gross_local_val) / EXR.exchange_rate / (1 + TC.tax_class_pct) < 0.035
         THEN 0
         ELSE COALESCE(akp.unit_price_gross_local_val * WOR.prod_qty, vkp.unit_price_gross_local_val * WOR.prod_qty, WOR
             .prod_price_gross_local_val) / EXR.exchange_rate / (1 + TC.tax_class_pct) - COALESCE(zvp.unit_price_gross_local_val
               * WOR.prod_qty, first_vkp.unit_vkp_price_gross_local_val * WOR.prod_qty, WOR.prod_price_gross_local_val)
            / EXR.exchange_rate / (1 + TC.tax_class_pct)
         END AS loss_net_eur_val,
          - 1 * CASE
           WHEN COALESCE(akp.unit_price_gross_local_val * WOR.prod_qty, vkp.unit_price_gross_local_val * WOR.prod_qty,
                 WOR.prod_price_gross_local_val) / EXR.exchange_rate / (1 + TC.tax_class_pct) - COALESCE(zvp.unit_price_gross_local_val
                   * WOR.prod_qty, first_vkp.unit_vkp_price_gross_local_val * WOR.prod_qty, WOR.prod_price_gross_local_val
                 ) / EXR.exchange_rate / (1 + TC.tax_class_pct) > - 0.035 AND COALESCE(akp.unit_price_gross_local_val *
                  WOR.prod_qty, vkp.unit_price_gross_local_val * WOR.prod_qty, WOR.prod_price_gross_local_val) / EXR.exchange_rate
                 / (1 + TC.tax_class_pct) - COALESCE(zvp.unit_price_gross_local_val * WOR.prod_qty, first_vkp.unit_vkp_price_gross_local_val
                   * WOR.prod_qty, WOR.prod_price_gross_local_val) / EXR.exchange_rate / (1 + TC.tax_class_pct) < 0.035
           THEN 0
           ELSE COALESCE(akp.unit_price_gross_local_val * WOR.prod_qty, vkp.unit_price_gross_local_val * WOR.prod_qty,
               WOR.prod_price_gross_local_val) / EXR.exchange_rate / (1 + TC.tax_class_pct) - COALESCE(zvp.unit_price_gross_local_val
                 * WOR.prod_qty, first_vkp.unit_vkp_price_gross_local_val * WOR.prod_qty, WOR.prod_price_gross_local_val
               ) / EXR.exchange_rate / (1 + TC.tax_class_pct)
           END * CASE
          WHEN COALESCE(zvp.unit_price_gross_local_val * WOR.prod_qty, first_vkp.unit_vkp_price_gross_local_val * WOR.prod_qty
              , WOR.prod_price_gross_local_val) / (1 + TC.tax_class_pct) <> 0
          THEN (COALESCE(zvp.unit_price_gross_local_val * WOR.prod_qty, first_vkp.unit_vkp_price_gross_local_val * WOR.prod_qty
                , WOR.prod_price_gross_local_val) / (1 + TC.tax_class_pct) - WOR.ivp_price_net_eur_val * EXR.exchange_rate
              ) / (COALESCE(zvp.unit_price_gross_local_val * WOR.prod_qty, first_vkp.unit_vkp_price_gross_local_val *
               WOR.prod_qty, WOR.prod_price_gross_local_val) / (1 + TC.tax_class_pct))
          ELSE NULL
          END AS transfer_margin_net_eur_val,
          - 1 * CASE
           WHEN COALESCE(akp.unit_price_gross_local_val * WOR.prod_qty, vkp.unit_price_gross_local_val * WOR.prod_qty,
                 WOR.prod_price_gross_local_val) / EXR.exchange_rate / (1 + TC.tax_class_pct) - COALESCE(zvp.unit_price_gross_local_val
                   * WOR.prod_qty, first_vkp.unit_vkp_price_gross_local_val * WOR.prod_qty, WOR.prod_price_gross_local_val
                 ) / EXR.exchange_rate / (1 + TC.tax_class_pct) > - 0.035 AND COALESCE(akp.unit_price_gross_local_val *
                  WOR.prod_qty, vkp.unit_price_gross_local_val * WOR.prod_qty, WOR.prod_price_gross_local_val) / EXR.exchange_rate
                 / (1 + TC.tax_class_pct) - COALESCE(zvp.unit_price_gross_local_val * WOR.prod_qty, first_vkp.unit_vkp_price_gross_local_val
                   * WOR.prod_qty, WOR.prod_price_gross_local_val) / EXR.exchange_rate / (1 + TC.tax_class_pct) < 0.035
           THEN 0
           ELSE COALESCE(akp.unit_price_gross_local_val * WOR.prod_qty, vkp.unit_price_gross_local_val * WOR.prod_qty,
               WOR.prod_price_gross_local_val) / EXR.exchange_rate / (1 + TC.tax_class_pct) - COALESCE(zvp.unit_price_gross_local_val
                 * WOR.prod_qty, first_vkp.unit_vkp_price_gross_local_val * WOR.prod_qty, WOR.prod_price_gross_local_val
               ) / EXR.exchange_rate / (1 + TC.tax_class_pct)
           END * (1 - CASE
            WHEN COALESCE(zvp.unit_price_gross_local_val * WOR.prod_qty, first_vkp.unit_vkp_price_gross_local_val * WOR
                .prod_qty, WOR.prod_price_gross_local_val) / (1 + TC.tax_class_pct) <> 0
            THEN (COALESCE(zvp.unit_price_gross_local_val * WOR.prod_qty, first_vkp.unit_vkp_price_gross_local_val * WOR
                  .prod_qty, WOR.prod_price_gross_local_val) / (1 + TC.tax_class_pct) - WOR.ivp_price_net_eur_val * EXR
                .exchange_rate) / (COALESCE(zvp.unit_price_gross_local_val * WOR.prod_qty, first_vkp.unit_vkp_price_gross_local_val
                  * WOR.prod_qty, WOR.prod_price_gross_local_val) / (1 + TC.tax_class_pct))
            ELSE NULL
            END) AS correction_cogs_net_eur_val,
        0 AS quality_check_cd
       FROM ldl_dig_core.v_goods_order_and_return AS WOR
        LEFT JOIN ldl_dig_core.t_fact_currency_exchange_rate AS EXR ON WOR.curr_cd = EXR.from_curr_cd AND WOR.event_date
            BETWEEN EXR.active_from_dt AND EXR.active_to_dt AND EXR.to_curr_cd = 'EUR' AND EXR.curr_exchange_rate_type_cd
           = 'R'
        LEFT JOIN ldl_dig_core.t_dim_tax_class AS TC ON WOR.tax_class_cd = TC.tax_class_cd AND WOR.cust_order_dt BETWEEN
           TC.active_from_dt AND TC.active_to_dt AND WOR.wshop_cd = TC.wshop_cd
        LEFT JOIN PRICING_CONDITION AS zvp ON WOR.prod_variant_sid = zvp.prod_variant_sid AND WOR.cust_order_dt BETWEEN
            zvp.active_from_dt AND zvp.active_to_dt AND WOR.wshop_cd = zvp.wshop_cd AND zvp.price_type_cd = 'ZVP'
        LEFT JOIN PRICING_CONDITION AS vkp ON WOR.prod_variant_sid = vkp.prod_variant_sid AND WOR.cust_order_dt BETWEEN
            vkp.active_from_dt AND vkp.active_to_dt AND WOR.wshop_cd = vkp.wshop_cd AND vkp.price_type_cd = 'VKP'
        LEFT JOIN PRICING_CONDITION AS akp ON WOR.prod_variant_sid = akp.prod_variant_sid AND WOR.cust_order_dt BETWEEN
            akp.active_from_dt AND akp.active_to_dt AND WOR.wshop_cd = akp.wshop_cd AND akp.price_type_cd = 'AKP'
        LEFT JOIN FIRST_VKP AS first_vkp ON WOR.prod_variant_sid = first_vkp.prod_variant_sid AND WOR.wshop_cd =
          first_vkp.wshop_cd) AS t13
     UNION ALL
     SELECT 'CV' AS goods_loss_origin_type_cd,
      WOR.business_event_type_cd,
      WOR.cust_order_sid,
      WOR.document_nr,
      WOR.prod_variant_sid,
      WOR.prod_variant_nr,
      WOR.wshop_cd,
      WOR.event_date,
      WOR.cust_order_dt,
      WOR.curr_cd,
      WOR.delivery_src_type_cd,
      CV.profit_loss_reason_cd,
      TC.tax_class_cd,
      TC.tax_class_pct,
      CV.coupon_cd,
      WOR.prod_qty,
      COALESCE(zvp.unit_price_gross_local_val * WOR.prod_qty, first_vkp.unit_vkp_price_gross_local_val * WOR.prod_qty,
       WOR.prod_price_gross_local_val) AS tgt_price_gross_local_val,
      WOR.order_prod_price_gross_local_val AS actual_price_gross_local_val,
       CV.coupon_item_gross_local_val * WOR.prod_qty AS coupon_pos_gross_local_val,
       COALESCE(zvp.unit_price_gross_local_val * WOR.prod_qty, first_vkp.unit_vkp_price_gross_local_val * WOR.prod_qty,
        WOR.prod_price_gross_local_val) / (1 + TC.tax_class_pct) AS tgt_price_net_local_val,
       WOR.order_prod_price_gross_local_val / (1 + TC.tax_class_pct) AS actual_price_net_local_val,
       WOR.ivp_price_net_eur_val * EXR.exchange_rate AS ivp_price_net_local_val,
         - 1 * CV.coupon_item_gross_local_val * WOR.prod_qty / (1 + TC.tax_class_pct) AS orig_loss_net_local_val,
         - 1 * CV.coupon_item_gross_local_val * WOR.prod_qty / (1 + TC.tax_class_pct) AS loss_net_local_val,
       CASE
       WHEN COALESCE(zvp.unit_price_gross_local_val * WOR.prod_qty, first_vkp.unit_vkp_price_gross_local_val * WOR.prod_qty
           , WOR.prod_price_gross_local_val) / (1 + TC.tax_class_pct) <> 0
       THEN (COALESCE(zvp.unit_price_gross_local_val * WOR.prod_qty, first_vkp.unit_vkp_price_gross_local_val * WOR.prod_qty
             , WOR.prod_price_gross_local_val) / (1 + TC.tax_class_pct) - WOR.ivp_price_net_eur_val * EXR.exchange_rate
         ) / (COALESCE(zvp.unit_price_gross_local_val * WOR.prod_qty, first_vkp.unit_vkp_price_gross_local_val * WOR.prod_qty
            , WOR.prod_price_gross_local_val) / (1 + TC.tax_class_pct))
       ELSE NULL
       END AS loss_split_coeff,
        - 1 * (- 1 * CV.coupon_item_gross_local_val * WOR.prod_qty / (1 + TC.tax_class_pct)) * CASE
        WHEN COALESCE(zvp.unit_price_gross_local_val * WOR.prod_qty, first_vkp.unit_vkp_price_gross_local_val * WOR.prod_qty
            , WOR.prod_price_gross_local_val) / (1 + TC.tax_class_pct) <> 0
        THEN (COALESCE(zvp.unit_price_gross_local_val * WOR.prod_qty, first_vkp.unit_vkp_price_gross_local_val * WOR.prod_qty
              , WOR.prod_price_gross_local_val) / (1 + TC.tax_class_pct) - WOR.ivp_price_net_eur_val * EXR.exchange_rate
            ) / (COALESCE(zvp.unit_price_gross_local_val * WOR.prod_qty, first_vkp.unit_vkp_price_gross_local_val * WOR
             .prod_qty, WOR.prod_price_gross_local_val) / (1 + TC.tax_class_pct))
        ELSE NULL
        END AS transfer_margin_net_local_val,
        - 1 * (- 1 * CV.coupon_item_gross_local_val * WOR.prod_qty / (1 + TC.tax_class_pct)) * (1 - CASE
          WHEN COALESCE(zvp.unit_price_gross_local_val * WOR.prod_qty, first_vkp.unit_vkp_price_gross_local_val * WOR.prod_qty
              , WOR.prod_price_gross_local_val) / (1 + TC.tax_class_pct) <> 0
          THEN (COALESCE(zvp.unit_price_gross_local_val * WOR.prod_qty, first_vkp.unit_vkp_price_gross_local_val * WOR.prod_qty
                , WOR.prod_price_gross_local_val) / (1 + TC.tax_class_pct) - WOR.ivp_price_net_eur_val * EXR.exchange_rate
              ) / (COALESCE(zvp.unit_price_gross_local_val * WOR.prod_qty, first_vkp.unit_vkp_price_gross_local_val *
               WOR.prod_qty, WOR.prod_price_gross_local_val) / (1 + TC.tax_class_pct))
          ELSE NULL
          END) AS correction_cogs_net_local_val,
        COALESCE(zvp.unit_price_gross_local_val * WOR.prod_qty, first_vkp.unit_vkp_price_gross_local_val * WOR.prod_qty
         , WOR.prod_price_gross_local_val) / EXR.exchange_rate / (1 + TC.tax_class_pct) AS tgt_price_net_eur_val,
        WOR.order_prod_price_gross_local_val / EXR.exchange_rate / (1 + TC.tax_class_pct) AS actual_price_net_eur_val,
      WOR.ivp_price_net_eur_val,
          - 1 * CV.coupon_item_gross_local_val * WOR.prod_qty / (1 + TC.tax_class_pct) / EXR.exchange_rate AS
      orig_loss_net_eur_val,
          - 1 * CV.coupon_item_gross_local_val * WOR.prod_qty / (1 + TC.tax_class_pct) / EXR.exchange_rate AS
      loss_net_eur_val,
        - 1 * (- 1 * CV.coupon_item_gross_local_val * WOR.prod_qty / (1 + TC.tax_class_pct) / EXR.exchange_rate) * CASE
        WHEN COALESCE(zvp.unit_price_gross_local_val * WOR.prod_qty, first_vkp.unit_vkp_price_gross_local_val * WOR.prod_qty
            , WOR.prod_price_gross_local_val) / (1 + TC.tax_class_pct) <> 0
        THEN (COALESCE(zvp.unit_price_gross_local_val * WOR.prod_qty, first_vkp.unit_vkp_price_gross_local_val * WOR.prod_qty
              , WOR.prod_price_gross_local_val) / (1 + TC.tax_class_pct) - WOR.ivp_price_net_eur_val * EXR.exchange_rate
            ) / (COALESCE(zvp.unit_price_gross_local_val * WOR.prod_qty, first_vkp.unit_vkp_price_gross_local_val * WOR
             .prod_qty, WOR.prod_price_gross_local_val) / (1 + TC.tax_class_pct))
        ELSE NULL
        END AS transfer_margin_net_eur_val,
        - 1 * (- 1 * CV.coupon_item_gross_local_val * WOR.prod_qty / (1 + TC.tax_class_pct) / EXR.exchange_rate) * (1 -
          CASE
          WHEN COALESCE(zvp.unit_price_gross_local_val * WOR.prod_qty, first_vkp.unit_vkp_price_gross_local_val * WOR.prod_qty
              , WOR.prod_price_gross_local_val) / (1 + TC.tax_class_pct) <> 0
          THEN (COALESCE(zvp.unit_price_gross_local_val * WOR.prod_qty, first_vkp.unit_vkp_price_gross_local_val * WOR.prod_qty
                , WOR.prod_price_gross_local_val) / (1 + TC.tax_class_pct) - WOR.ivp_price_net_eur_val * EXR.exchange_rate
              ) / (COALESCE(zvp.unit_price_gross_local_val * WOR.prod_qty, first_vkp.unit_vkp_price_gross_local_val *
               WOR.prod_qty, WOR.prod_price_gross_local_val) / (1 + TC.tax_class_pct))
          ELSE NULL
          END) AS correction_cogs_net_eur_val,
       CASE
       WHEN WOR.business_event_type_cd = 'R' AND COALESCE(zvp.unit_price_gross_local_val * WOR.prod_qty, first_vkp.unit_vkp_price_gross_local_val
             * WOR.prod_qty, WOR.prod_price_gross_local_val) >= 0 OR WOR.business_event_type_cd = 'O' AND COALESCE(zvp.unit_price_gross_local_val
             * WOR.prod_qty, first_vkp.unit_vkp_price_gross_local_val * WOR.prod_qty, WOR.prod_price_gross_local_val) <=
          0
       THEN 1
       WHEN WOR.business_event_type_cd = 'R' AND WOR.ivp_price_net_eur_val >= 0 OR WOR.business_event_type_cd = 'O' AND
          WOR.ivp_price_net_eur_val <= 0
       THEN 2
       ELSE 0
       END AS quality_check_cd
     FROM ldl_dig_core.v_goods_order_and_return AS WOR
      INNER JOIN ldl_dig_core.t_fact_coupon_validation AS CV ON WOR.cust_order_sid = CV.cust_order_sid AND WOR.prod_variant_sid
         = CV.prod_variant_sid
      LEFT JOIN ldl_dig_core.t_fact_currency_exchange_rate AS EXR ON WOR.curr_cd = EXR.from_curr_cd AND WOR.event_date
          BETWEEN EXR.active_from_dt AND EXR.active_to_dt AND EXR.to_curr_cd = 'EUR' AND EXR.curr_exchange_rate_type_cd
        = 'R'
      LEFT JOIN ldl_dig_core.t_dim_tax_class AS TC ON WOR.tax_class_cd = TC.tax_class_cd AND WOR.cust_order_dt BETWEEN
         TC.active_from_dt AND TC.active_to_dt AND WOR.wshop_cd = TC.wshop_cd
      LEFT JOIN PRICING_CONDITION AS zvp ON WOR.prod_variant_sid = zvp.prod_variant_sid AND WOR.cust_order_dt BETWEEN
          zvp.active_from_dt AND zvp.active_to_dt AND WOR.wshop_cd = zvp.wshop_cd AND zvp.price_type_cd = 'ZVP'
      LEFT JOIN PRICING_CONDITION AS vkp ON WOR.prod_variant_sid = vkp.prod_variant_sid AND WOR.cust_order_dt BETWEEN
          vkp.active_from_dt AND vkp.active_to_dt AND WOR.wshop_cd = vkp.wshop_cd AND vkp.price_type_cd = 'VKP'
      LEFT JOIN PRICING_CONDITION AS akp ON WOR.prod_variant_sid = akp.prod_variant_sid AND WOR.cust_order_dt BETWEEN
          akp.active_from_dt AND akp.active_to_dt AND WOR.wshop_cd = akp.wshop_cd AND akp.price_type_cd = 'AKP'
      LEFT JOIN FIRST_VKP AS first_vkp ON WOR.prod_variant_sid = first_vkp.prod_variant_sid AND WOR.wshop_cd = first_vkp
        .wshop_cd
     WHERE CV.coupon_pos_gross_local_val <> 0));