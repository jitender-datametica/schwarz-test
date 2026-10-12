CREATE OR REPLACE VIEW ldl_dig_core.v_fact_order_loss_detail_1 (goods_loss_origin_type_cd
OPTIONS(description='PC for price changes, and CV for coupon validation'), cust_order_sid
OPTIONS(description='The unique identifier (surrogate key) for customer order'), cust_order_nr
OPTIONS(description='The original order number or return order number from the source system'), cust_order_pos_nr
OPTIONS(description='The particular position number of an item_1 in an order'), prod_variant_sid
OPTIONS(description='Unique identifier (surrogate key) of the ordered/returned product'), is_bundle_header_fg
OPTIONS(description='Indicates if position represents a bundle header ( null in all the other cases)'),
bundle_header_pos_nr
OPTIONS(description='In case of a line being a composition part of the bundle-header (see bundle header code field), it can be allocated with this field to its header item_1'),
bundle_header_prod_variant_sid
OPTIONS(description='Unique Identifier for the product variant of the bundle header to which this bundle item_1 belongs'),
wshop_cd
OPTIONS(description='The unique code for the Lidl webshop, where an order can be placed by a customer. The webshop is defined per political country_1'),
event_date
OPTIONS(description='For Orders this is order_perform_dt (when delivery started). For Returns this is order_return_dt'),
cust_order_dt OPTIONS(description='The date when order was made'), curr_cd
OPTIONS(description='Currency code in which order has been payed'), cust_sid
OPTIONS(description='Customer who made the order'), delivery_src_type_cd
OPTIONS(description='The code for source location_1 of product FROM where it is delivered i.e. FROM supplier_1 or warehouse directly'),
profit_loss_reason_cd OPTIONS(description='The reason code associated with this profit loss event'), tax_class_cd
OPTIONS(description='The code identifying the tax class'), tax_class_pct
OPTIONS(description='What percent of the gross amount is the tax'), coupon_cd
OPTIONS(description='Code of the promotional coupon'), coupon_promo_cd
OPTIONS(description='A business key that uniquely identifies the promotion campaign to which this coupon belongs.'),
prod_qty OPTIONS(description='Quantity of a particular product ordered'), tgt_price_gross_local_val
OPTIONS(description='The target price at which the product was intended to be sold, taxes included (in local currency)'),
actual_price_gross_local_val
OPTIONS(description='The actual price at which the product was sold, taxes included (in local currency)'),
coupon_pos_gross_local_val OPTIONS(description='Coupon value for product discount. Tax included (in local currency)'),
tgt_price_net_local_val
OPTIONS(description='The target price at which the product was intended to be sold, without taxes (in local currency)'),
actual_price_net_local_val
OPTIONS(description='The actual price at which the product was sold, without taxes (in local currency)'),
ivp_price_net_eur_val
OPTIONS(description='The ivp original unit_1 prices in sales_1 order line in euros for internal margin calculations'),
orig_loss_net_local_val
OPTIONS(description='For Price Change Losses this is the difference BETWEEN target price AND actual price. For coupon validation this is coupon value for product discount.Tax excluded (in local currency)'),
loss_net_local_val
OPTIONS(description='Same as ORIG_LOSS_NET_LOCAL_VAL but replaced by 0 if the ORIG_LOSS_NET_EUR_VAL value is higher than -0.035 and lower than 0.035, under the assumption it is a rounding issue - Only for Modul P'),
delivery_cost_net_local_val
OPTIONS(description='Article specific net delivery cost in local currency. This cost is optional and mostly article dependent. An example is a fridge which has additional delivery costs'),
delivery_paushal_net_local_val
OPTIONS(description='A paushal for delivery costs splitted per every order position in netto and local currency'),
delivery_paushal_coupon_net_local_val
OPTIONS(description='A discount value netto for paushal delivery cost splitted per every order position in local currency'),
add_services_net_local_val
OPTIONS(description='Net Revenue in local currency coming from additional services (delivery_to_point_of_use / assembly). This cost is optional and mostly article dependent.'),
is_replacement_order_fg OPTIONS(description='An indicator showing if the order is a replacement_order or not'))
OPTIONS(DESCRIPTION = `ONE ROW FOR ALL ORDERS AT [ORDER;PRODUCTVARIANT] LEVEL, PLUS ONE ROW FOR EVERY COUPON VALIDATION AT [ORDER;PRODUCTVARIANT;COUPONCODE] LEVEL. THE COLUMNS SHOW WHAT (IF ANY) IS THE LOSS AMOUNT FOR EACH OF THESE EVENTS`)
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
    FROM ldl_dig_core.t_fact_product_pricing_condition_1 AS PPS
    WHERE price_type_cd = 'ZVP' AND price_change_reason_cd = '130'
     OR price_type_cd = 'VKP' AND price_change_reason_cd IN ('112', '113', '114', '115', '116', '120')
     OR price_type_cd = 'AKP'
    QUALIFY (ROW_NUMBER() OVER (PARTITION BY wshop_cd, CAST(prod_variant_sid AS STRING), price_type_cd, DATE(active_from_tmsp
           ) ORDER BY active_from_tmsp IS NULL DESC, active_from_tmsp DESC)) = 1) AS t1_1) (-- in case it is a component take the weighted price in the bundle, and not the one that would have had as single article

  -- in case it is a component take the weighted price in the bundle, and not the one that would have had as single article

  -- check to exclude losses that are inferior to 35cents

  -- older records are part of legacy tables in t_agg_goods_loss_summary_1 directly for WVPA. DBR doesn´t need them.

  -- in case it is a component take the weighted price in the bundle, and not the one that would have had as single article

  -- item_1 price is taken from order line

  -- just needed a number > 0 for the union, every loss is considered here for coupons independently of the value

  SELECT goods_loss_origin_type_cd,
   cust_order_sid,
   cust_order_nr,
   cust_order_pos_nr,
   prod_variant_sid,
   is_bundle_header_fg,
   bundle_header_pos_nr,
   bundle_header_prod_variant_sid,
   wshop_cd,
   event_date,
   cust_order_dt,
   curr_cd,
   cust_sid,
   delivery_src_type_cd,
   profit_loss_reason_cd,
   tax_class_cd,
   tax_class_pct,
   coupon_cd,
   coupon_promo_cd,
   prod_qty,
   tgt_price_gross_local_val,
   actual_price_gross_local_val,
   coupon_pos_gross_local_val,
   tgt_price_net_local_val,
   actual_price_net_local_val,
   ivp_price_net_eur_val
   -- ivp directly in EUR because original value is in EUR (avoid double conversion in following stages)
,
   loss_net_local_val AS orig_loss_net_local_val,
    CASE
    WHEN loss_check = 0
    THEN 0
    ELSE loss_net_local_val
    END AS loss_net_local_val,
   delivery_cost_net_local_val,
   delivery_paushal_net_local_val,
   delivery_paushal_coupon_net_local_val,
   add_services_net_local_val,
   is_replacement_order_fg
  FROM (SELECT 'PC' AS goods_loss_origin_type_cd,
      COL.cust_order_sid,
      COL.cust_order_nr,
      COL.cust_order_pos_nr,
      COL.prod_variant_sid,
      COL.is_bundle_header_fg,
      COL.bundle_header_pos_nr,
      GH.bundle_header_prod_variant_sid,
      COL.wshop_cd,
      COL.cust_order_perform_dt AS event_date,
      COL.cust_order_dt,
      COL.curr_cd,
      COL.cust_sid,
      COL.delivery_src_type_cd,
      COALESCE(akp.price_change_reason_cd, vkp.price_change_reason_cd, '113') AS profit_loss_reason_cd,
      COL.tax_class_cd,
      COALESCE(Z_TC.tax_class_pct, TC.tax_class_pct) AS tax_class_pct,
      CAST(NULL AS STRING) AS coupon_cd,
      CAST(NULL AS STRING) AS coupon_promo_cd,
      COL.prod_qty,
      COALESCE(zvp.unit_price_gross_local_val * COL.prod_qty, FIRST_VKP.vkp_price_gross_local_val * COL.prod_qty, COL.prod_price_gross_local_val
       ) AS tgt_price_gross_local_val_orig,
       CASE
       WHEN GH.is_bundle_component_fg
       THEN (SUM(CASE
           WHEN GH.is_bundle_component_fg = CAST('false' AS BOOL)
           THEN COALESCE(zvp.unit_price_gross_local_val * COL.prod_qty, FIRST_VKP.vkp_price_gross_local_val * COL.prod_qty
             , COL.prod_price_gross_local_val)
           ELSE NULL
           END) OVER (PARTITION BY CAST(COL.cust_order_sid AS STRING), CAST(GH.bundle_header_prod_variant_sid AS STRING)
            RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)) * GH.prod_price_gross_bundle_pct
       ELSE COALESCE(zvp.unit_price_gross_local_val * COL.prod_qty, FIRST_VKP.vkp_price_gross_local_val * COL.prod_qty,
        COL.prod_price_gross_local_val)
       END AS tgt_price_gross_local_val,
      COALESCE(akp.unit_price_gross_local_val * COL.prod_qty, vkp.unit_price_gross_local_val * COL.prod_qty, COL.prod_price_gross_local_val
       ) AS actual_price_gross_local_val_orig,
       CASE
       WHEN GH.is_bundle_component_fg
       THEN (SUM(CASE
           WHEN GH.is_bundle_component_fg = CAST('false' AS BOOL)
           THEN COALESCE(akp.unit_price_gross_local_val * COL.prod_qty, vkp.unit_price_gross_local_val * COL.prod_qty,
            COL.prod_price_gross_local_val)
           ELSE NULL
           END) OVER (PARTITION BY CAST(COL.cust_order_sid AS STRING), CAST(GH.bundle_header_prod_variant_sid AS STRING)
            RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)) * GH.prod_price_gross_bundle_pct
       ELSE COALESCE(akp.unit_price_gross_local_val * COL.prod_qty, vkp.unit_price_gross_local_val * COL.prod_qty, COL.prod_price_gross_local_val
        )
       END AS actual_price_gross_local_val,
      CAST(NULL AS BIGNUMERIC) AS coupon_pos_gross_local_val,
        CASE
        WHEN GH.is_bundle_component_fg
        THEN (SUM(CASE
            WHEN GH.is_bundle_component_fg = CAST('false' AS BOOL)
            THEN COALESCE(zvp.unit_price_gross_local_val * COL.prod_qty, FIRST_VKP.vkp_price_gross_local_val * COL.prod_qty
              , COL.prod_price_gross_local_val)
            ELSE NULL
            END) OVER (PARTITION BY CAST(COL.cust_order_sid AS STRING), CAST(GH.bundle_header_prod_variant_sid AS STRING)
             RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)) * GH.prod_price_gross_bundle_pct
        ELSE COALESCE(zvp.unit_price_gross_local_val * COL.prod_qty, FIRST_VKP.vkp_price_gross_local_val * COL.prod_qty
         , COL.prod_price_gross_local_val)
        END / (1 + COALESCE(Z_TC.tax_class_pct, TC.tax_class_pct)) AS tgt_price_net_local_val,
        CASE
        WHEN GH.is_bundle_component_fg
        THEN (SUM(CASE
            WHEN GH.is_bundle_component_fg = CAST('false' AS BOOL)
            THEN COALESCE(akp.unit_price_gross_local_val * COL.prod_qty, vkp.unit_price_gross_local_val * COL.prod_qty,
             COL.prod_price_gross_local_val)
            ELSE NULL
            END) OVER (PARTITION BY CAST(COL.cust_order_sid AS STRING), CAST(GH.bundle_header_prod_variant_sid AS STRING)
             RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)) * GH.prod_price_gross_bundle_pct
        ELSE COALESCE(akp.unit_price_gross_local_val * COL.prod_qty, vkp.unit_price_gross_local_val * COL.prod_qty, COL
         .prod_price_gross_local_val)
        END / (1 + COALESCE(Z_TC.tax_class_pct, TC.tax_class_pct)) AS actual_price_net_local_val,
       COL.ivp_unit_price_net_eur_val * COL.prod_qty AS ivp_price_net_eur_val,
         CASE
         WHEN GH.is_bundle_component_fg
         THEN (SUM(CASE
             WHEN GH.is_bundle_component_fg = CAST('false' AS BOOL)
             THEN COALESCE(akp.unit_price_gross_local_val * COL.prod_qty, vkp.unit_price_gross_local_val * COL.prod_qty
              , COL.prod_price_gross_local_val)
             ELSE NULL
             END) OVER (PARTITION BY CAST(COL.cust_order_sid AS STRING), CAST(GH.bundle_header_prod_variant_sid AS STRING)
              RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)) * GH.prod_price_gross_bundle_pct
         ELSE COALESCE(akp.unit_price_gross_local_val * COL.prod_qty, vkp.unit_price_gross_local_val * COL.prod_qty, COL
          .prod_price_gross_local_val)
         END / (1 + COALESCE(Z_TC.tax_class_pct, TC.tax_class_pct)) - CASE
         WHEN GH.is_bundle_component_fg
         THEN (SUM(CASE
             WHEN GH.is_bundle_component_fg = CAST('false' AS BOOL)
             THEN COALESCE(zvp.unit_price_gross_local_val * COL.prod_qty, FIRST_VKP.vkp_price_gross_local_val * COL.prod_qty
               , COL.prod_price_gross_local_val)
             ELSE NULL
             END) OVER (PARTITION BY CAST(COL.cust_order_sid AS STRING), CAST(GH.bundle_header_prod_variant_sid AS STRING)
              RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)) * GH.prod_price_gross_bundle_pct
         ELSE COALESCE(zvp.unit_price_gross_local_val * COL.prod_qty, FIRST_VKP.vkp_price_gross_local_val * COL.prod_qty
           , COL.prod_price_gross_local_val)
         END / (1 + COALESCE(Z_TC.tax_class_pct, TC.tax_class_pct)) AS loss_net_local_val,
       CASE
       WHEN ((CASE
              WHEN GH.is_bundle_component_fg
              THEN (SUM(CASE
                  WHEN GH.is_bundle_component_fg = CAST('false' AS BOOL)
                  THEN COALESCE(akp.unit_price_gross_local_val * COL.prod_qty, vkp.unit_price_gross_local_val * COL.prod_qty
                    , COL.prod_price_gross_local_val)
                  ELSE NULL
                  END) OVER (PARTITION BY CAST(COL.cust_order_sid AS STRING), CAST(GH.bundle_header_prod_variant_sid AS STRING)
                   RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)) * GH.prod_price_gross_bundle_pct
              ELSE COALESCE(akp.unit_price_gross_local_val * COL.prod_qty, vkp.unit_price_gross_local_val * COL.prod_qty
                , COL.prod_price_gross_local_val)
              END / (1 + COALESCE(Z_TC.tax_class_pct, TC.tax_class_pct)) - CASE
              WHEN GH.is_bundle_component_fg
              THEN (SUM(CASE
                  WHEN GH.is_bundle_component_fg = CAST('false' AS BOOL)
                  THEN COALESCE(zvp.unit_price_gross_local_val * COL.prod_qty, FIRST_VKP.vkp_price_gross_local_val * COL
                    .prod_qty, COL.prod_price_gross_local_val)
                  ELSE NULL
                  END) OVER (PARTITION BY CAST(COL.cust_order_sid AS STRING), CAST(GH.bundle_header_prod_variant_sid AS STRING)
                   RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)) * GH.prod_price_gross_bundle_pct
              ELSE COALESCE(zvp.unit_price_gross_local_val * COL.prod_qty, FIRST_VKP.vkp_price_gross_local_val * COL.prod_qty
                , COL.prod_price_gross_local_val)
              END / (1 + COALESCE(Z_TC.tax_class_pct, TC.tax_class_pct))) / EXR.exchange_rate) BETWEEN - 0.35 AND 0.35
       THEN 0
       ELSE CASE
          WHEN GH.is_bundle_component_fg
          THEN (SUM(CASE
              WHEN GH.is_bundle_component_fg = CAST('false' AS BOOL)
              THEN COALESCE(akp.unit_price_gross_local_val * COL.prod_qty, vkp.unit_price_gross_local_val * COL.prod_qty
                , COL.prod_price_gross_local_val)
              ELSE NULL
              END) OVER (PARTITION BY CAST(COL.cust_order_sid AS STRING), CAST(GH.bundle_header_prod_variant_sid AS STRING)
               RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)) * GH.prod_price_gross_bundle_pct
          ELSE COALESCE(akp.unit_price_gross_local_val * COL.prod_qty, vkp.unit_price_gross_local_val * COL.prod_qty,
           COL.prod_price_gross_local_val)
          END / (1 + COALESCE(Z_TC.tax_class_pct, TC.tax_class_pct)) - CASE
          WHEN GH.is_bundle_component_fg
          THEN (SUM(CASE
              WHEN GH.is_bundle_component_fg = CAST('false' AS BOOL)
              THEN COALESCE(zvp.unit_price_gross_local_val * COL.prod_qty, FIRST_VKP.vkp_price_gross_local_val * COL.prod_qty
                , COL.prod_price_gross_local_val)
              ELSE NULL
              END) OVER (PARTITION BY CAST(COL.cust_order_sid AS STRING), CAST(GH.bundle_header_prod_variant_sid AS STRING)
               RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)) * GH.prod_price_gross_bundle_pct
          ELSE COALESCE(zvp.unit_price_gross_local_val * COL.prod_qty, FIRST_VKP.vkp_price_gross_local_val * COL.prod_qty
            , COL.prod_price_gross_local_val)
          END / (1 + COALESCE(Z_TC.tax_class_pct, TC.tax_class_pct))
       END AS loss_check,
      COL.delivery_cost_net_local_val,
      COL.delivery_paushal_net_local_val,
      COL.delivery_paushal_coupon_net_local_val,
      COL.add_services_net_local_val,
      COL.is_replacement_order_fg
     FROM ldl_dig_core.t_fact_customer_order_line_1 AS COL
      LEFT JOIN ldl_dig_core.t_fact_currency_exchange_rate_1 AS EXR ON COL.curr_cd = EXR.from_curr_cd AND COL.cust_order_perform_dt
          BETWEEN EXR.active_from_dt AND EXR.active_to_dt AND EXR.to_curr_cd = 'EUR' AND EXR.curr_exchange_rate_type_cd
        = 'R'
      LEFT JOIN ldl_dig_core.t_dim_tax_class_1 AS TC ON COL.tax_class_cd = TC.tax_class_cd AND COL.cust_order_dt BETWEEN
         TC.active_from_dt AND TC.active_to_dt AND COL.wshop_cd = TC.wshop_cd
      LEFT JOIN ldl_dig_core.t_dim_distribution_zone_tax_class_1 AS Z_TC ON COL.tax_class_cd = Z_TC.tax_class_cd AND COL.dist_zone_cd
           = Z_TC.dist_zone_cd AND COL.cust_order_dt BETWEEN Z_TC.active_from_dt AND Z_TC.active_to_dt AND COL.wshop_cd
        = Z_TC.wshop_cd
      LEFT JOIN PRICING_CONDITION AS zvp ON COL.prod_variant_sid = zvp.prod_variant_sid AND COL.cust_order_dt BETWEEN
          zvp.active_from_dt AND zvp.active_to_dt AND COL.wshop_cd = zvp.wshop_cd AND zvp.price_type_cd = 'ZVP'
      LEFT JOIN PRICING_CONDITION AS vkp ON COL.prod_variant_sid = vkp.prod_variant_sid AND COL.cust_order_dt BETWEEN
          vkp.active_from_dt AND vkp.active_to_dt AND COL.wshop_cd = vkp.wshop_cd AND vkp.price_type_cd = 'VKP'
      LEFT JOIN PRICING_CONDITION AS akp ON COL.prod_variant_sid = akp.prod_variant_sid AND COL.cust_order_dt BETWEEN
          akp.active_from_dt AND akp.active_to_dt AND COL.wshop_cd = akp.wshop_cd AND akp.price_type_cd = 'AKP'
      LEFT JOIN ldl_dig_core.t_fact_product_price_sale_ivp_gld_vkp_1 AS FIRST_VKP ON COL.prod_variant_sid = FIRST_VKP.prod_variant_sid
          AND COL.wshop_cd = FIRST_VKP.wshop_cd AND FIRST_VKP.first_valid_price_fg
      LEFT JOIN ldl_dig_core.v_fact_order_line_bundle_component_1 AS GH ON COL.cust_order_sid = GH.cust_order_sid AND COL
        .cust_order_pos_nr = GH.cust_order_pos_nr
     WHERE (COL.cust_order_perform_dt >= DATE '2022-03-01' OR COL.cust_order_perform_dt IS NULL AND COL.cust_order_dt >=
          DATE '2022-03-01')
      AND NOT COL.is_order_cancel_fg
      AND COL.dist_channel_type_cd NOT IN ('MKPL')
     UNION ALL
     SELECT 'CV' AS goods_loss_origin_type_cd,
      COL.cust_order_sid,
      COL.cust_order_nr,
      COL.cust_order_pos_nr,
      COL.prod_variant_sid,
      COL.is_bundle_header_fg,
      COL.bundle_header_pos_nr,
      GH.bundle_header_prod_variant_sid,
      COL.wshop_cd,
      COL.cust_order_perform_dt AS event_date,
      COL.cust_order_dt,
      COL.curr_cd,
      COL.cust_sid,
      COL.delivery_src_type_cd,
      CV.profit_loss_reason_cd,
      COL.tax_class_cd,
      COALESCE(Z_TC.tax_class_pct, TC.tax_class_pct) AS tax_class_pct,
      CV.coupon_cd,
      CV.coupon_promo_cd,
      COL.prod_qty,
      COALESCE(zvp.unit_price_gross_local_val * COL.prod_qty, FIRST_VKP.vkp_price_gross_local_val * COL.prod_qty, COL.prod_price_gross_local_val
       ) AS tgt_price_gross_local_val_orig,
       CASE
       WHEN GH.is_bundle_component_fg
       THEN (SUM(CASE
           WHEN GH.is_bundle_component_fg = CAST('false' AS BOOL)
           THEN COALESCE(zvp.unit_price_gross_local_val * COL.prod_qty, FIRST_VKP.vkp_price_gross_local_val * COL.prod_qty
             , COL.prod_price_gross_local_val)
           ELSE NULL
           END) OVER (PARTITION BY CAST(COL.cust_order_sid AS STRING), CAST(GH.bundle_header_prod_variant_sid AS STRING)
            RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)) * GH.prod_price_gross_bundle_pct
       ELSE COALESCE(zvp.unit_price_gross_local_val * COL.prod_qty, FIRST_VKP.vkp_price_gross_local_val * COL.prod_qty,
        COL.prod_price_gross_local_val)
       END AS tgt_price_gross_local_val,
      COL.prod_price_gross_local_val AS actual_price_gross_local_val_orig,
      COL.prod_price_gross_local_val AS actual_price_gross_local_val,
       CV.coupon_item_gross_local_val * COL.prod_qty AS coupon_pos_gross_local_val,
        CASE
        WHEN GH.is_bundle_component_fg
        THEN (SUM(CASE
            WHEN GH.is_bundle_component_fg = CAST('false' AS BOOL)
            THEN COALESCE(zvp.unit_price_gross_local_val * COL.prod_qty, FIRST_VKP.vkp_price_gross_local_val * COL.prod_qty
              , COL.prod_price_gross_local_val)
            ELSE NULL
            END) OVER (PARTITION BY CAST(COL.cust_order_sid AS STRING), CAST(GH.bundle_header_prod_variant_sid AS STRING)
             RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)) * GH.prod_price_gross_bundle_pct
        ELSE COALESCE(zvp.unit_price_gross_local_val * COL.prod_qty, FIRST_VKP.vkp_price_gross_local_val * COL.prod_qty
         , COL.prod_price_gross_local_val)
        END / (1 + COALESCE(Z_TC.tax_class_pct, TC.tax_class_pct)) AS tgt_price_net_local_val,
       COL.prod_price_gross_local_val / (1 + COALESCE(Z_TC.tax_class_pct, TC.tax_class_pct)) AS
      actual_price_net_local_val,
       COL.ivp_unit_price_net_eur_val * COL.prod_qty AS ivp_price_net_eur_val,
         - 1 * CV.coupon_item_gross_local_val * COL.prod_qty / (1 + COALESCE(Z_TC.tax_class_pct, TC.tax_class_pct)) AS
      loss_net_local_val,
      1 AS loss_check,
      COL.delivery_cost_net_local_val,
      COL.delivery_paushal_net_local_val,
      COL.delivery_paushal_coupon_net_local_val,
      COL.add_services_net_local_val,
      COL.is_replacement_order_fg
     FROM ldl_dig_core.t_fact_customer_order_line_1 AS COL
      INNER JOIN ldl_dig_core.t_fact_coupon_validation_1 AS CV ON COL.cust_order_sid = CV.cust_order_sid AND COL.prod_variant_sid
         = CV.prod_variant_sid
      LEFT JOIN ldl_dig_core.t_fact_currency_exchange_rate_1 AS EXR ON COL.curr_cd = EXR.from_curr_cd AND COL.cust_order_perform_dt
          BETWEEN EXR.active_from_dt AND EXR.active_to_dt AND EXR.to_curr_cd = 'EUR' AND EXR.curr_exchange_rate_type_cd
        = 'R'
      LEFT JOIN ldl_dig_core.t_dim_tax_class_1 AS TC ON COL.tax_class_cd = TC.tax_class_cd AND COL.cust_order_dt BETWEEN
         TC.active_from_dt AND TC.active_to_dt AND COL.wshop_cd = TC.wshop_cd
      LEFT JOIN ldl_dig_core.t_dim_distribution_zone_tax_class_1 AS Z_TC ON COL.tax_class_cd = Z_TC.tax_class_cd AND COL.dist_zone_cd
           = Z_TC.dist_zone_cd AND COL.cust_order_dt BETWEEN Z_TC.active_from_dt AND Z_TC.active_to_dt AND COL.wshop_cd
        = Z_TC.wshop_cd
      LEFT JOIN PRICING_CONDITION AS zvp ON COL.prod_variant_sid = zvp.prod_variant_sid AND COL.cust_order_dt BETWEEN
          zvp.active_from_dt AND zvp.active_to_dt AND COL.wshop_cd = zvp.wshop_cd AND zvp.price_type_cd = 'ZVP'
      LEFT JOIN PRICING_CONDITION AS vkp ON COL.prod_variant_sid = vkp.prod_variant_sid AND COL.cust_order_dt BETWEEN
          vkp.active_from_dt AND vkp.active_to_dt AND COL.wshop_cd = vkp.wshop_cd AND vkp.price_type_cd = 'VKP'
      LEFT JOIN PRICING_CONDITION AS akp ON COL.prod_variant_sid = akp.prod_variant_sid AND COL.cust_order_dt BETWEEN
          akp.active_from_dt AND akp.active_to_dt AND COL.wshop_cd = akp.wshop_cd AND akp.price_type_cd = 'AKP'
      LEFT JOIN ldl_dig_core.t_fact_product_price_sale_ivp_gld_vkp_1 AS FIRST_VKP ON COL.prod_variant_sid = FIRST_VKP.prod_variant_sid
          AND COL.wshop_cd = FIRST_VKP.wshop_cd AND FIRST_VKP.first_valid_price_fg
      LEFT JOIN ldl_dig_core.v_fact_order_line_bundle_component_1 AS GH ON COL.cust_order_sid = GH.cust_order_sid AND COL
        .cust_order_pos_nr = GH.cust_order_pos_nr
     WHERE (COL.cust_order_perform_dt >= DATE '2022-03-01' OR COL.cust_order_perform_dt IS NULL AND COL.cust_order_dt >=
          DATE '2022-03-01')
      AND CV.profit_loss_reason_cd <> '350' -- external coupons not needed

      AND NOT COL.is_order_cancel_fg
      AND COL.dist_channel_type_cd NOT IN ('MKPL')) AS t27);