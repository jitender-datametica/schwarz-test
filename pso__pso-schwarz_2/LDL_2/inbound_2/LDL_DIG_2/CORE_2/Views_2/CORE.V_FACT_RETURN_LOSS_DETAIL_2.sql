CREATE OR REPLACE VIEW CORE.V_FACT_RETURN_LOSS_DETAIL_2(
	GOODS_LOSS_ORIGIN_TYPE_CD COMMENT 'PC for price changes, and CV for coupon validation',
	CUST_ORDER_SID COMMENT 'The unique identifier (surrogate key) for customer order',
	CUST_ORDER_NR COMMENT 'The original order number or return order number from the source system',
	CUST_ORDER_POS_NR COMMENT 'The particular position number of an item_2 in an order',
	PROD_VARIANT_SID COMMENT 'Unique identifier (surrogate key) of the ordered/returned product',
	CUST_ORDER_RETURN_SID COMMENT 'The unique identifier (surrogate key) for return of customer order',
	CUST_ORDER_RETURN_NR COMMENT 'An original return order number',
	CUST_ORDER_RETURN_POS_NR COMMENT 'A number of an particular position ( product ) in an return order',
	PROD_CONDITION_CD COMMENT 'the condition code of the product. (01 - can be sold online, 02 - needs to be checked, 03 - for scrapping)',
	BUNDLE_HEADER_PROD_VARIANT_SID COMMENT 'Unique Identifier for the product variant of the bundle header to which this bundle item_2 belongs',
	WSHOP_CD COMMENT 'The unique code for the Lidl webshop, where an order can be placed by a customer. The webshop is defined per political country_2',
	EVENT_DATE COMMENT 'For Orders this is order_perform_dt (when delivery started). For Returns this is order_return_dt',
	CUST_ORDER_DT COMMENT 'The date when order was made',
	CURR_CD COMMENT 'Currency code in which order has been payed',
	DELIVERY_SRC_TYPE_CD COMMENT 'The code for source location_2 of product FROM where it is delivered i.e. FROM supplier_2 or warehouse directly',
	PROFIT_LOSS_REASON_CD COMMENT 'The reason code associated with this profit loss event',
	TAX_CLASS_CD COMMENT 'The code identifying the tax class',
	TAX_CLASS_PCT COMMENT 'What percent of the gross amount is the tax',
	COUPON_CD COMMENT 'Code of the promotional coupon',
    COUPON_PROMO_CD COMMENT 'A business key that uniquely identifies the promotion campaign to which this coupon belongs.',
	PROD_QTY COMMENT 'Quantity of a particular product ordered',
	TGT_PRICE_GROSS_LOCAL_VAL COMMENT 'The target price at which the product was intended to be sold, taxes included (in local currency)',
	ACTUAL_PRICE_GROSS_LOCAL_VAL COMMENT 'The actual price at which the product was sold, taxes included (in local currency)',
	COUPON_POS_GROSS_LOCAL_VAL COMMENT 'Coupon value for product discount. Tax included (in local currency)',
	TGT_PRICE_NET_LOCAL_VAL COMMENT 'The target price at which the product was intended to be sold, without taxes (in local currency)',
	ACTUAL_PRICE_NET_LOCAL_VAL COMMENT 'The actual price at which the product was sold, without taxes (in local currency)',
	COGS_PRICE_NET_EUR_VAL COMMENT 'Cost-of-Goods-sold, short: CoGs. Needed for calc of margin (= revenue - cogs)',
	ORIG_LOSS_NET_LOCAL_VAL COMMENT 'For Price Change Losses this is the difference BETWEEN target price AND actual price. For coupon validation this is coupon value for product discount.Tax excluded (in local currency)',
	LOSS_NET_LOCAL_VAL COMMENT 'Same as ORIG_LOSS_NET_LOCAL_VAL but replaced by 0 if the ORIG_LOSS_NET_EUR_VAL value is higher than -0.035 and lower than 0.035, under the assumption it is a rounding issue - Only for Modul P',
	DELIVERY_COST_NET_LOCAL_VAL COMMENT 'Article specific net delivery cost in local currency. This cost is optional and mostly article dependent. An example is a fridge which has additional delivery costs',
	DELIVERY_PAUSHAL_NET_LOCAL_VAL COMMENT 'A paushal for delivery costs splitted per every order position in netto and local currency',
	SELLBACK_NET_LOCAL_VAL COMMENT 'A sellback value net for returned article specific in local currency. Amount which is discounted from the product internal price after it is returned, depending on its condition (whether it is damaged or not)',
	DELIVERY_PAUSHAL_COUPON_NET_LOCAL_VAL COMMENT 'A discount value netto for paushal delivery cost splitted per every order position in local currency',
	ADD_SERVICES_NET_LOCAL_VAL COMMENT 'Additional services net value of a returned article in local currency. This cost is optional and mostly article dependent.'
) COMMENT='One row for all Orders at [Order;ProductVariant] level, plus one row for every Coupon Validation at [Order;ProductVariant;CouponCode] level. The columns show what (if any) is the loss amount for each of these events'
 AS
    WITH pricing_condition AS
(
    SELECT  wshop_cd
        ,prod_variant_sid
        ,price_type_cd 
        ,active_from_tmsp
        ,active_to_tmsp
        ,active_from_dt
        ,CASE WHEN active_to_dt = LEAD(active_from_dt) OVER (PARTITION BY wshop_cd, prod_variant_sid, price_type_cd ORDER BY active_from_tmsp)
                THEN DATEADD(DAY,-1,active_to_dt) 
             WHEN LEAD(active_to_tmsp) OVER (PARTITION BY wshop_cd, prod_variant_sid, price_type_cd ORDER BY active_to_tmsp) IS NULL
                THEN active_to_dt
                ELSE active_to_dt 
         END                              AS active_to_dt 
        ,unit_price_gross_local_val
        ,price_change_reason_cd
    FROM (
    SELECT
            wshop_cd
            ,prod_variant_sid
            ,price_type_cd 
            ,active_from_tmsp
            ,active_to_tmsp                                   
			,TO_DATE(active_from_tmsp)     AS active_from_dt
            ,TO_DATE(active_to_tmsp)       AS active_to_dt
            ,price_val                     AS unit_price_gross_local_val
            ,price_change_reason_cd
            ,ROW_NUMBER () OVER (PARTITION BY wshop_cd, prod_variant_sid, price_type_cd, active_from_dt ORDER BY active_from_tmsp DESC) AS rn
        FROM core.t_fact_product_pricing_condition_2 AS pps
        WHERE 
        (
            (price_type_cd = 'ZVP' AND price_change_reason_cd = '130') OR 
            (price_type_cd = 'VKP' AND price_change_reason_cd IN ('112','113','114','115','116','120')) OR
            (price_type_cd = 'AKP')
        )
        QUALIFY rn = 1
    ) 

)
SELECT 
    goods_loss_origin_type_cd
    ,cust_order_sid
    ,cust_order_nr
    ,cust_order_pos_nr
    ,prod_variant_sid
    ,cust_order_return_sid
    ,cust_order_return_nr
    ,cust_order_return_pos_nr
    ,prod_condition_cd
    ,bundle_header_prod_variant_sid
    ,wshop_cd
    ,event_date
    ,cust_order_dt
    ,curr_cd
    ,delivery_src_type_cd
    ,profit_loss_reason_cd
    ,tax_class_cd    
    ,tax_class_pct
    ,coupon_cd
    ,coupon_promo_cd
    ,prod_qty                                                      
    ,tgt_price_gross_local_val_ret     AS    tgt_price_gross_local_val                                
    ,actual_price_gross_local_val_ret  AS    actual_price_gross_local_val                                 
    ,coupon_pos_gross_local_val
    ,tgt_price_net_local_val_ret       AS     tgt_price_net_local_val   
    ,actual_price_net_local_val_ret    AS     actual_price_net_local_val 
    ,cogs_price_net_eur_val   --cogs directly in EUR because original value is in EUR (avoid double conversion in following stages)
    ,loss_net_local_val_calc                                                       AS orig_loss_net_local_val
    ,CASE WHEN loss_check = 0 THEN 0 ELSE loss_net_local_val_calc END              AS loss_net_local_val 
    ,delivery_cost_net_local_val
    ,delivery_paushal_net_local_val
    ,sellback_net_local_val
    ,delivery_paushal_coupon_net_local_val
    ,add_services_net_local_val
FROM
(
    --here we have the PC (Price Changes) part, used to enquire all returns and the losses coming from promotions/discounts
    SELECT 
        'PC' AS goods_loss_origin_type_cd
        ,crl.cust_order_sid
        ,crl.cust_order_nr
        ,crl.cust_order_pos_nr
        ,crl.prod_variant_sid
        ,crl.cust_order_return_sid
        ,crl.cust_order_return_nr
        ,crl.cust_order_return_pos_nr
        ,crl.prod_condition_cd 
        ,gh.bundle_header_prod_variant_sid AS bundle_header_prod_variant_sid
        ,crl.wshop_cd
        ,crl.cust_order_return_dt AS event_date
        ,crl.cust_order_dt
        ,crl.curr_cd
        ,col.delivery_src_type_cd
        ,COALESCE(akp.price_change_reason_cd, vkp.price_change_reason_cd, '113') AS profit_loss_reason_cd
        ,col.tax_class_cd    
        ,COALESCE(z_tc.tax_class_pct, tc.tax_class_pct)                           AS tax_class_pct
        ,NULL AS coupon_cd
        ,NULL AS coupon_promo_cd
        ,crl.prod_qty * (-1)                                               AS prod_qty
        ,ABS(COALESCE(
                zvp.unit_price_gross_local_val * crl.prod_qty
                ,first_vkp.vkp_price_gross_local_val * crl.prod_qty
                ,crl.prod_price_gross_local_val 
        )) * (-1)                                                           AS tgt_price_gross_local_val_orig

        ,CASE WHEN gh.is_bundle_component_fg = '1'
            THEN (orld.tgt_price_gross_local_val/orld.prod_qty) * crl.prod_qty * (-1)
            ELSE tgt_price_gross_local_val_orig
        END                                                                AS tgt_price_gross_local_val_ret
            
        ,ABS(COALESCE(
                akp.unit_price_gross_local_val * crl.prod_qty
                ,vkp.unit_price_gross_local_val * crl.prod_qty 
                ,crl.prod_price_gross_local_val)) * (-1)                    AS actual_price_gross_local_val_orig

        ,CASE WHEN gh.is_bundle_component_fg = '1'
            THEN (orld.actual_price_gross_local_val/orld.prod_qty) * crl.prod_qty * (-1)
            ELSE actual_price_gross_local_val_orig
        END                                                                 AS actual_price_gross_local_val_ret											 
        ,NULL                                                               AS coupon_pos_gross_local_val
        ,tgt_price_gross_local_val_ret / (1+COALESCE(z_tc.tax_class_pct, tc.tax_class_pct))               AS tgt_price_net_local_val_ret
        ,actual_price_gross_local_val_ret / (1+COALESCE(z_tc.tax_class_pct, tc.tax_class_pct))            AS actual_price_net_local_val_ret                           
        ,crl.cogs_price_net_eur_val * (-1)                                  AS cogs_price_net_eur_val
        ,actual_price_net_local_val_ret - tgt_price_net_local_val_ret       AS loss_net_local_val_calc
        ,CASE WHEN (loss_net_local_val / exr.exchange_rate) BETWEEN -0.35 AND 0.35 
             THEN 0
             ELSE loss_net_local_val                             
        END                                                                 AS loss_check   --check to exclude losses that are inferior to 35cents
        ,crl.delivery_cost_net_local_val
        ,crl.delivery_paushal_net_local_val
        ,crl.sellback_net_local_val
        ,crl.delivery_paushal_coupon_net_local_val
        ,crl.add_services_net_local_val
    FROM core.t_fact_customer_return_line_2 AS crl
        LEFT JOIN core.t_fact_customer_order_line_2 AS col
                                                    ON      crl.cust_order_sid = col.cust_order_sid
                                                        AND crl.cust_order_pos_nr = col.cust_order_pos_nr
        LEFT JOIN core.t_fact_currency_exchange_rate_2 AS exr 
                                                    ON      crl.curr_cd = exr.from_curr_cd
                                                        AND crl.cust_order_return_dt BETWEEN exr.active_from_dt AND exr.active_to_dt
                                                        AND exr.to_curr_cd = 'EUR'
                                                        AND exr.curr_exchange_rate_type_cd = 'R'
        LEFT JOIN core.t_dim_tax_class_2 AS tc         
                                                    ON      col.tax_class_cd = tc.tax_class_cd
                                                        AND crl.cust_order_dt BETWEEN tc.active_from_dt AND tc.active_to_dt
                                                        AND crl.wshop_cd = tc.wshop_cd
        LEFT JOIN core.t_dim_distribution_zone_tax_class_2 AS z_tc                 
                                                    ON col.tax_class_cd = z_tc.tax_class_cd
                                                        AND col.dist_zone_cd = z_tc.dist_zone_cd
                                                        AND crl.cust_order_dt BETWEEN z_tc.active_from_dt AND z_tc.active_to_dt
                                                        AND crl.wshop_cd = z_tc.wshop_cd

        LEFT JOIN pricing_condition AS zvp           
                                                    ON      crl.prod_variant_sid = zvp.prod_variant_sid
                                                        AND crl.cust_order_dt BETWEEN zvp.active_from_dt AND zvp.active_to_dt 
                                                        AND crl.wshop_cd = zvp.wshop_cd
                                                        AND zvp.price_type_cd = 'ZVP'      
        LEFT JOIN pricing_condition AS vkp           
                                                    ON      crl.prod_variant_sid = vkp.prod_variant_sid
                                                        AND crl.cust_order_dt BETWEEN vkp.active_from_dt AND vkp.active_to_dt
                                                        AND crl.wshop_cd = vkp.wshop_cd
                                                        AND vkp.price_type_cd = 'VKP'
        LEFT JOIN pricing_condition AS akp           
                                                    ON      crl.prod_variant_sid = akp.prod_variant_sid
                                                        AND crl.cust_order_dt BETWEEN akp.active_from_dt AND akp.active_to_dt
                                                        AND crl.wshop_cd = akp.wshop_cd
                                                        AND akp.price_type_cd = 'AKP'
        LEFT JOIN core.t_fact_product_price_sale_ivp_gld_vkp_2 AS first_vkp
                                                    ON      crl.prod_variant_sid = first_vkp.prod_variant_sid 
                                                        AND crl.wshop_cd = first_vkp.wshop_cd
                                                        AND first_valid_price_fg = TRUE 

        LEFT JOIN core.v_fact_order_line_bundle_component_2    AS gh      
                                                     ON     crl.cust_order_sid = gh.cust_order_sid
                                                        AND crl.cust_order_pos_nr = gh.cust_order_pos_nr

        LEFT JOIN core.v_fact_order_loss_detail_2 AS orld    --JOIN To get the tgt/actual prices of components when they are in bundles
                                                     ON     crl.cust_order_sid = orld.cust_order_sid
                                                         AND crl.cust_order_pos_nr = orld.cust_order_pos_nr
                                                         AND orld.goods_loss_origin_type_cd = 'PC'

        WHERE   crl.prod_price_gross_local_val > 0       -- excluding returns which are not resulting in a credit note to the customer -> there is no loss
            AND crl.cust_order_return_dt >= '2022-03-01' -- returns before this date will be exported as data set from QV and imported in a "legacy" table
            AND NOT crl.dist_channel_type_cd IN ('MKPL') -- filters out MKPL orders
          
    UNION ALL
 --here we have the CV (Coupon Validation part) used to enquire which losses comes from coupon usage
    SELECT 
        'CV' AS goods_loss_origin_type_cd
        ,crl.cust_order_sid
        ,crl.cust_order_nr
        ,crl.cust_order_pos_nr
        ,crl.prod_variant_sid 
        ,crl.cust_order_return_sid
        ,crl.cust_order_return_nr
        ,crl.cust_order_return_pos_nr
        ,crl.prod_condition_cd
        ,gh.bundle_header_prod_variant_sid AS bundle_header_prod_variant_sid
        ,crl.wshop_cd
        ,crl.cust_order_return_dt AS event_date
        ,crl.cust_order_dt
        ,crl.curr_cd
        ,col.delivery_src_type_cd
        ,cv.profit_loss_reason_cd AS profit_loss_reason_cd
        ,col.tax_class_cd    
        ,COALESCE(z_tc.tax_class_pct, tc.tax_class_pct)                           AS tax_class_pct
        ,cv.coupon_cd
        ,cv.coupon_promo_cd
        ,crl.prod_qty * (-1)                                                  AS prod_qty
        ,ABS(COALESCE(
                zvp.unit_price_gross_local_val * crl.prod_qty
                ,first_vkp.vkp_price_gross_local_val * crl.prod_qty
                ,crl.prod_price_gross_local_val
            )) * (-1)                                                         AS tgt_price_gross_local_val_orig
    
        ,CASE WHEN gh.is_bundle_component_fg = '1'
            THEN (orld.tgt_price_gross_local_val/orld.prod_qty) * crl.prod_qty * (-1)
            ELSE tgt_price_gross_local_val_orig
        END                                                                   AS tgt_price_gross_local_val_ret
            
        ,col.prod_price_gross_local_val * (-1)                                AS actual_price_gross_local_val_orig             
        ,col.prod_price_gross_local_val * (-1)                                AS actual_price_gross_local_val_ret  --item_2 price is taken from order line
        ,cv.coupon_item_gross_local_val * crl.prod_qty * (-1)				  AS coupon_pos_gross_local_val 
        ,tgt_price_gross_local_val_ret / (1+COALESCE(z_tc.tax_class_pct, tc.tax_class_pct))                 AS tgt_price_net_local_val
        ,actual_price_gross_local_val_ret / (1+COALESCE(z_tc.tax_class_pct, tc.tax_class_pct))              AS actual_price_net_local_val_ret
        ,crl.cogs_price_net_eur_val * (-1)                                    AS cogs_price_net_eur_val 
        ,cv.coupon_item_gross_local_val * crl.prod_qty / (1+COALESCE(z_tc.tax_class_pct, tc.tax_class_pct)) AS loss_net_local_val
        ,1                                                                    AS loss_check --just needed a number > 0 for the union, every loss is considered here for coupons independently of the value
        ,crl.delivery_cost_net_local_val
        ,crl.delivery_paushal_net_local_val
        ,crl.sellback_net_local_val
        ,crl.delivery_paushal_coupon_net_local_val
        ,crl.add_services_net_local_val
    FROM core.t_fact_customer_return_line_2 AS crl
    JOIN      core.t_fact_coupon_validation_2 cv     
                                                        ON cv.cust_order_sid = crl.cust_order_sid
                                                            AND cv.prod_variant_sid = crl.prod_variant_sid
    LEFT JOIN core.t_fact_customer_order_line_2 AS col
                                                        ON crl.cust_order_sid = col.cust_order_sid
                                                            AND crl.cust_order_pos_nr = col.cust_order_pos_nr
    LEFT JOIN core.t_fact_currency_exchange_rate_2 AS exr 
                                                        ON crl.curr_cd = exr.from_curr_cd
                                                            AND crl.cust_order_return_dt BETWEEN exr.active_from_dt AND exr.active_to_dt
                                                            AND exr.to_curr_cd = 'EUR'
                                                            AND exr.curr_exchange_rate_type_cd = 'R'
    
    LEFT JOIN core.t_dim_tax_class_2 AS tc                 
                                                        ON col.tax_class_cd = tc.tax_class_cd
                                                            AND crl.cust_order_dt BETWEEN tc.active_from_dt AND tc.active_to_dt
                                                            AND crl.wshop_cd = tc.wshop_cd
    LEFT JOIN core.t_dim_distribution_zone_tax_class_2 AS z_tc                 
                                                        ON col.tax_class_cd = z_tc.tax_class_cd
                                                            AND col.dist_zone_cd = z_tc.dist_zone_cd
                                                            AND crl.cust_order_dt BETWEEN z_tc.active_from_dt AND z_tc.active_to_dt
                                                            AND crl.wshop_cd = z_tc.wshop_cd

    LEFT JOIN pricing_condition AS zvp                   
                                                        ON crl.prod_variant_sid = zvp.prod_variant_sid
                                                            AND crl.cust_order_dt BETWEEN zvp.active_from_dt AND zvp.active_to_dt
                                                            AND crl.wshop_cd = zvp.wshop_cd
                                                            AND zvp.price_type_cd = 'ZVP'      
    LEFT JOIN pricing_condition AS vkp                     
                                                        ON crl.prod_variant_sid = vkp.prod_variant_sid
                                                            AND crl.cust_order_dt BETWEEN vkp.active_from_dt AND vkp.active_to_dt
                                                            AND crl.wshop_cd = vkp.wshop_cd
                                                            AND vkp.price_type_cd = 'VKP'
    LEFT JOIN pricing_condition AS akp                     
                                                        ON crl.prod_variant_sid = akp.prod_variant_sid
                                                            AND crl.cust_order_dt BETWEEN akp.active_from_dt AND akp.active_to_dt
                                                            AND crl.wshop_cd = akp.wshop_cd
                                                            AND akp.price_type_cd = 'AKP'
    LEFT JOIN core.t_fact_product_price_sale_ivp_gld_vkp_2 AS first_vkp
                                                        ON crl.prod_variant_sid = first_vkp.prod_variant_sid  
                                                            AND crl.wshop_cd = first_vkp.wshop_cd
                                                            AND first_valid_price_fg = TRUE 

    LEFT JOIN core.v_fact_order_line_bundle_component_2  AS gh      
                                                        ON     crl.cust_order_sid = gh.cust_order_sid
                                                            AND  crl.cust_order_pos_nr = gh.cust_order_pos_nr
    
    LEFT JOIN 
            (SELECT
                cust_order_sid
                ,cust_order_pos_nr
                ,coupon_cd
                ,profit_loss_reason_cd
                ,ANY_VALUE(tgt_price_gross_local_val) AS tgt_price_gross_local_val
                ,ANY_VALUE(prod_qty) AS prod_qty
            FROM
                core.v_fact_order_loss_detail_2
            WHERE goods_loss_origin_type_cd = 'CV'
            GROUP BY
                cust_order_sid
                ,cust_order_pos_nr
                ,coupon_cd
                ,profit_loss_reason_cd
            ) AS orld    --JOIN To get the tgt/actual prices of components when they are in bundles
                                                       ON      crl.cust_order_sid = orld.cust_order_sid
                                                            AND crl.cust_order_pos_nr = orld.cust_order_pos_nr
                                                            AND cv.coupon_cd = orld.coupon_cd
                                                            AND cv.profit_loss_reason_cd = orld.profit_loss_reason_cd

    WHERE                     
         crl.prod_price_gross_local_val > 0       -- excluding returns which are not resulting in a credit note to the customer -> there is no loss
        AND crl.cust_order_return_dt >= '2022-03-01' -- returns before this date will be exported as data set from QV and imported in a "legacy" table
        AND NOT cv.profit_loss_reason_cd = '350'
        AND NOT crl.dist_channel_type_cd IN ('MKPL') -- filters out MKPL orders
)
;