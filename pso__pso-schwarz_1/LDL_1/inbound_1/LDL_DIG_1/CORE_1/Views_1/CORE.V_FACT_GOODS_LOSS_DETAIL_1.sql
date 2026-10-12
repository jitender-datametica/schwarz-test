CREATE OR REPLACE VIEW CORE.V_FACT_GOODS_LOSS_DETAIL_1(
	GOODS_LOSS_ORIGIN_TYPE_CD COMMENT '\"PC\" for price chage, \"CV\" for coupon validation',
	BUSINESS_EVENT_TYPE_CD COMMENT '\"O\" for orders, \"R\" for returns',
	CUST_ORDER_SID COMMENT 'The unique identifier (surrogate key) for customer order',
	DOCUMENT_NR COMMENT 'The original order number or return order number from the source system',
	PROD_VARIANT_SID COMMENT 'Unique identifier (surrogate key) of the ordered/returned product',
	PROD_VARIANT_NR COMMENT 'The original number of the ordered/returned product',
	WSHOP_CD COMMENT 'The unique code for the Lidl webshop, where an order can be placed by a customer. The webshop is defined per political country.',
	EVENT_DATE COMMENT 'For Orders this is order_perform_dt (when delivery started). For Returns this is order_return_dt',
	CUST_ORDER_DT COMMENT 'The date when order was made',
	CURR_CD COMMENT 'Currency code in which order has been payed',
	DELIVERY_SRC_TYPE_CD COMMENT 'The code for source location_1 of product FROM where it is delivered i.e. FROM supplier_1 or warehouse directly',
	PROFIT_LOSS_REASON_CD COMMENT 'The reason code associated with this profit loss event',
	TAX_CLASS_CD COMMENT 'The code identifying the tax class',
	TAX_CLASS_PCT COMMENT 'What percent of the gross amount is the tax',
	COUPON_CD COMMENT 'Code of the promotional coupon',
	PROD_QTY COMMENT 'Quantity of a particular product ordered',
	TGT_PRICE_GROSS_LOCAL_VAL COMMENT 'The target price at which the product was intended to be sold, taxes included (in local currency)',
	ACTUAL_PRICE_GROSS_LOCAL_VAL COMMENT 'The actual price at which the product was sold, taxes included (in local currency)',
	COUPON_POS_GROSS_LOCAL_VAL COMMENT 'Coupon value for product discount. Tax included (in local currency)',
	TGT_PRICE_NET_LOCAL_VAL COMMENT 'The target price at which the product was intended to be sold, without taxes (in local currency)',
	ACTUAL_PRICE_NET_LOCAL_VAL COMMENT 'The actual price at which the product was sold, without taxes (in local currency)',
	IVP_PRICE_NET_LOCAL_VAL COMMENT 'Cost-of-Goods-sold, short: CoGs. Needed for calc of margin (= revenue - cogs ) (in local currency)',
	ORIG_LOSS_NET_LOCAL_VAL COMMENT 'For Price Change Losses this is the difference BETWEEN target price AND actual price. For coupon validation this is coupon value for product discount.Tax excluded (in local currency)',
	LOSS_NET_LOCAL_VAL COMMENT 'Same as ORIG_LOSS_NET_LOCAL_VAL but replaced by 0 if the ORIG_LOSS_NET_EUR_VAL value is higher than -0.035 and lower than 0.035, under the assumption it is a rounding issue - Only for Modul P',
	LOSS_SPLIT_COEFF COMMENT 'Coefficient how total loss amount is split BETWEEN TRANSFER_MARGIN_NET_LOCAL_VAL AND CORRECTION_COGS_NET_LOCAL_VAL',
	TRANSFER_MARGIN_NET_LOCAL_VAL COMMENT 'This amount is a loss that will be used to reduce the earnings AND thus affecting the margin (in local currency)',
	CORRECTION_COGS_NET_LOCAL_VAL COMMENT 'Correction value for the cost of goods sold. It is added to actual cost of goods sold to icrease losses AND thus affecting margin (in local currency)',
	TGT_PRICE_NET_EUR_VAL COMMENT 'The target price at which the product was intended to be sold, without taxes (in euro)',
	ACTUAL_PRICE_NET_EUR_VAL COMMENT 'The actual price at which the product was sold, without taxes (in euro)',
	IVP_PRICE_NET_EUR_VAL COMMENT 'Cost-of-Goods-sold, short: CoGs. Needed for calc of margin (= revenue - cogs, in euro)',
	ORIG_LOSS_NET_EUR_VAL COMMENT 'Coefficient how total loss amount is split BETWEEN TRANSFER_MARGIN_NET_LOCAL_VAL AND CORRECTION_COGS_NET_LOCAL_VAL (in euro)',
	LOSS_NET_EUR_VAL COMMENT 'Same as LOSS_NET_EUR_VAL but replaced by 0 if the value is higher than -0.035 and lower than 0.035, under the assumption it is a rounding issue - Only for Modul P',
	TRANSFER_MARGIN_NET_EUR_VAL COMMENT 'This amount is a loss that will be used to reduce the earnings AND thus affecting the margin (in euro)',
	CORRECTION_COGS_NET_EUR_VAL COMMENT 'Correction value for the cost of goods sold. It is added to actual cost of goods sold to icrease losses AND thus affecting margin (in euro)',
	QUALITY_CHECK_CD COMMENT 'Code indication data quality in a row. 0-fine, 1-error with target price, 2-error with IVP price'
) COMMENT = 'One row for all Orders AND Returns at [Order;ProductVariant] level, plus one row for every Coupon Validation at [Order;ProductVariant;CouponCode] level. The columns show what (if any) is the loss amount for each of these events'
AS
WITH
pricing_condition AS
(
    SELECT  wshop_cd
        ,prod_variant_sid
        ,price_type_cd 
        ,active_from_tmsp
        ,active_to_tmsp
        ,active_from_dt
        ,CASE 
            WHEN active_to_dt = LEAD(active_from_dt) OVER (PARTITION BY wshop_cd, prod_variant_sid, price_type_cd ORDER BY active_from_tmsp)
                THEN DATEADD(DAY,-1,active_to_dt) 
            WHEN LEAD(active_to_tmsp) OVER (PARTITION BY wshop_cd, prod_variant_sid, price_type_cd ORDER BY active_to_tmsp) IS NULL
                THEN active_to_dt
        ELSE active_to_dt END AS active_to_dt 
        ,unit_price_gross_local_val
        ,price_change_reason_cd
    FROM (
    SELECT
            wshop_cd
            ,prod_variant_sid
            ,price_type_cd 
            ,active_from_tmsp
            ,active_to_tmsp                                   
			,TO_DATE(active_from_tmsp) AS active_from_dt
            ,TO_DATE(active_to_tmsp) AS active_to_dt
            ,price_val AS unit_price_gross_local_val
            ,price_change_reason_cd
            ,ROW_NUMBER () OVER (PARTITION BY wshop_cd, prod_variant_sid, price_type_cd, active_from_dt ORDER BY active_from_tmsp DESC) AS rn
        FROM core.t_fact_product_pricing_condition_1 pps
        WHERE 
        (
            (price_type_cd = 'ZVP' AND price_change_reason_cd = '130') OR 
            (price_type_cd = 'VKP' AND price_change_reason_cd IN ('112','113','114','115','116','120')) OR
            (price_type_cd = 'AKP')
        )
        QUALIFY rn = 1
    )
)
,first_vkp AS 
(
    SELECT 
        wshop_cd
        ,prod_variant_sid
        ,vkp_price_gross_local_val AS  unit_vkp_price_gross_local_val
    FROM core.t_fact_product_price_sale_ivp_gld_vkp_1
    WHERE first_valid_price_fg = TRUE
                                                                                                 
)
SELECT 
    goods_loss_origin_type_cd
    ,business_event_type_cd
    ,cust_order_sid
    ,document_nr
    ,prod_variant_sid
    ,prod_variant_nr
    ,wshop_cd
    ,EVENT_DATE
    ,cust_order_dt
    ,curr_cd
    ,delivery_src_type_cd
    ,profit_loss_reason_cd
    ,tax_class_cd    
    ,tax_class_pct
    ,coupon_cd
    ,prod_qty
    ,tgt_price_gross_local_val
    ,actual_price_gross_local_val
    ,coupon_pos_gross_local_val
    ,tgt_price_net_local_val
    ,actual_price_net_local_val
    ,ivp_price_net_local_val
    ,loss_net_local_val                                                            AS orig_loss_net_local_val
    ,CASE WHEN loss_net_eur_val = 0 THEN 0 ELSE loss_net_local_val END             AS loss_net_local_val
    ,loss_split_coeff
    ,CASE WHEN loss_net_eur_val = 0 THEN 0 ELSE transfer_margin_net_local_val END  AS transfer_margin_net_local_val
    ,CASE WHEN loss_net_eur_val = 0 THEN 0 ELSE correction_cogs_net_local_val END  AS correction_cogs_net_local_val
    ,tgt_price_net_eur_val
    ,actual_price_net_eur_val
    ,ivp_price_net_eur_val
    ,orig_loss_net_eur_val                                                         AS orig_loss_net_eur_val
    ,loss_net_eur_val                                                              AS loss_net_eur_val                                                               
    ,CASE WHEN loss_net_eur_val = 0 THEN 0 ELSE transfer_margin_net_eur_val END    AS transfer_margin_net_eur_val
    ,CASE WHEN loss_net_eur_val = 0 THEN 0 ELSE correction_cogs_net_eur_val END    AS correction_cogs_net_eur_val  
    ,quality_check_cd   
FROM
(
    SELECT 
        -- Granularity columns >>
        'PC' AS goods_loss_origin_type_cd
        ,wor.business_event_type_cd
        ,wor.cust_order_sid
        ,wor.document_nr
        ,wor.prod_variant_sid  -- (allows to add dims for FOOD/NF, AssortClass, Brand_1 Class)  
        ,wor.prod_variant_nr
        -- Granularity columns <<
        
        -- additional descriptive attributes >>
        ,wor.wshop_cd
        ,wor.EVENT_DATE
        ,wor.cust_order_dt
        ,wor.curr_cd
        ,wor.delivery_src_type_cd
        ,COALESCE(akp.price_change_reason_cd, vkp.price_change_reason_cd, '113') AS profit_loss_reason_cd
        ,tc.tax_class_cd    
        ,tc.tax_class_pct
        ,NULL AS coupon_cd
        -- additional descriptive attributes <<

        -- temp measures >>
        ,wor.prod_qty
        ,COALESCE(
                zvp.unit_price_gross_local_val * wor.prod_qty
                ,first_vkp.unit_vkp_price_gross_local_val * wor.prod_qty
                ,wor.prod_price_gross_local_val
        )                                                                   AS tgt_price_gross_local_val
        ,COALESCE(
                akp.unit_price_gross_local_val * wor.prod_qty
                ,vkp.unit_price_gross_local_val * wor.prod_qty 
                ,wor.prod_price_gross_local_val)                            AS actual_price_gross_local_val																		 
        ,NULL AS coupon_pos_gross_local_val
        -- temp measures <<

        -- Final Measures >>
        ,tgt_price_gross_local_val / (1+tc.tax_class_pct)           AS tgt_price_net_local_val
        ,actual_price_gross_local_val / (1+tc.tax_class_pct)        AS actual_price_net_local_val
        ,wor.ivp_price_net_eur_val * exr.exchange_rate              AS ivp_price_net_local_val
        ,actual_price_net_local_val - tgt_price_net_local_val       AS loss_net_local_val
        ,CASE
            WHEN tgt_price_net_local_val <> 0 THEN (tgt_price_net_local_val - ivp_price_net_local_val) / tgt_price_net_local_val
            ELSE NULL 
        END                                                         AS loss_split_coeff
        ,-1 * loss_net_local_val * loss_split_coeff                 AS transfer_margin_net_local_val
        ,-1 * loss_net_local_val * (1 - loss_split_coeff)           AS correction_cogs_net_local_val
        
        ,tgt_price_gross_local_val / exr.exchange_rate / (1+tc.tax_class_pct)             AS tgt_price_net_eur_val
        ,actual_price_gross_local_val / exr.exchange_rate / (1+tc.tax_class_pct)          AS actual_price_net_eur_val
        ,wor.ivp_price_net_eur_val                                  AS ivp_price_net_eur_val
        ,actual_price_net_eur_val - tgt_price_net_eur_val           AS orig_loss_net_eur_val
        ,CASE WHEN  orig_loss_net_eur_val > -0.035
                AND orig_loss_net_eur_val < 0.035
                                    THEN 0 
                                    ELSE orig_loss_net_eur_val END  AS loss_net_eur_val
        ,-1 * loss_net_eur_val * loss_split_coeff                  	AS transfer_margin_net_eur_val
        ,-1 * loss_net_eur_val * (1 - loss_split_coeff)             AS correction_cogs_net_eur_val
        ,0 AS quality_check_cd       
        -- Final Measures <<
    FROM core.V_GOODS_ORDER_AND_RETURN_1 wor
        LEFT JOIN core.t_fact_currency_exchange_rate_1 exr ON wor.curr_cd = exr.from_curr_cd
                                                    AND wor.EVENT_DATE BETWEEN exr.active_from_dt AND exr.active_to_dt
                                                    AND exr.to_curr_cd = 'EUR'
                                                    AND exr.curr_exchange_rate_type_cd = 'R'
        LEFT JOIN core.t_dim_tax_class_1 tc ON wor.tax_class_cd = tc.tax_class_cd
                                        AND wor.cust_order_dt BETWEEN tc.active_from_dt AND tc.active_to_dt
                                        AND wor.wshop_cd = tc.wshop_cd

        LEFT JOIN pricing_condition zvp ON wor.prod_variant_sid = zvp.prod_variant_sid
                                        AND wor.cust_order_dt BETWEEN zvp.active_from_dt AND zvp.active_to_dt
                                        AND wor.wshop_cd = zvp.wshop_cd
                                        AND zvp.price_type_cd = 'ZVP'      
        LEFT JOIN pricing_condition vkp ON wor.prod_variant_sid = vkp.prod_variant_sid
                                        AND wor.cust_order_dt BETWEEN vkp.active_from_dt AND vkp.active_to_dt
                                        AND wor.wshop_cd = vkp.wshop_cd
                                        AND vkp.price_type_cd = 'VKP'
        LEFT JOIN pricing_condition akp ON wor.prod_variant_sid = akp.prod_variant_sid
                                        AND wor.cust_order_dt BETWEEN akp.active_from_dt AND akp.active_to_dt
                                        AND wor.wshop_cd = akp.wshop_cd
                                        AND akp.price_type_cd = 'AKP'
        LEFT JOIN FIRST_VKP first_vkp ON wor.prod_variant_sid = first_vkp.prod_variant_sid
                                    AND wor.wshop_cd = first_vkp.wshop_cd
)
UNION ALL

SELECT 
    -- Granularity columns >>
    'CV' AS goods_loss_origin_type_cd
    ,wor.business_event_type_cd
    ,wor.cust_order_sid
    ,wor.document_nr
    ,wor.prod_variant_sid  -- (allows to add dims for FOOD/NF, AssortClass, Brand_1 Class)  
    ,wor.prod_variant_nr
    -- Granularity columns <<
    
    -- additional descriptive attributes >>
    ,wor.wshop_cd
    ,wor.EVENT_DATE
    ,wor.cust_order_dt
    ,wor.curr_cd
    ,wor.delivery_src_type_cd
    ,cv.profit_loss_reason_cd AS profit_loss_reason_cd
    ,tc.tax_class_cd
    ,tc.tax_class_pct
    ,cv.coupon_cd
    -- additional descriptive attributes <<
        
    -- temp measures >>
    ,wor.prod_qty
    ,COALESCE(
            zvp.unit_price_gross_local_val * wor.prod_qty
            ,first_vkp.unit_vkp_price_gross_local_val * wor.prod_qty
            ,wor.prod_price_gross_local_val
    )                                                                       AS tgt_price_gross_local_val
    ,wor.order_prod_price_gross_local_val                                   AS actual_price_gross_local_val --item_1 price is taken from order line for both orders and returns
    ,cv.coupon_item_gross_local_val * wor.prod_qty 					        AS coupon_pos_gross_local_val
    -- temp measures <<

    -- Final Measures >>
    ,tgt_price_gross_local_val / (1+tc.tax_class_pct)           AS tgt_price_net_local_val
    ,actual_price_gross_local_val / (1+tc.tax_class_pct)        AS actual_price_net_local_val
    ,wor.ivp_price_net_eur_val * exr.exchange_rate              AS ivp_price_net_local_val
    ,-1 * cv.coupon_item_gross_local_val * wor.prod_qty / (1+tc.tax_class_pct)     AS orig_loss_net_local_val
    ,orig_loss_net_local_val                                    AS loss_net_local_val
    ,CASE
        WHEN tgt_price_net_local_val <> 0 THEN (tgt_price_net_local_val - ivp_price_net_local_val) / tgt_price_net_local_val
        ELSE NULL 
    END                                                         AS loss_split_coeff
    ,-1 * loss_net_local_val * loss_split_coeff                 AS transfer_margin_net_local_val
    ,-1 * loss_net_local_val * (1 - loss_split_coeff)           AS correction_cogs_net_local_val

    ,tgt_price_gross_local_val / exr.exchange_rate / (1+tc.tax_class_pct)             AS tgt_price_net_eur_val
    ,actual_price_gross_local_val / exr.exchange_rate / (1+tc.tax_class_pct)          AS actual_price_net_eur_val
    ,wor.ivp_price_net_eur_val                                  AS ivp_price_net_eur_val
    ,loss_net_local_val / exr.exchange_rate                     AS orig_loss_net_eur_val
    ,orig_loss_net_eur_val                                      AS loss_net_eur_val
    ,-1 * loss_net_eur_val * loss_split_coeff                   AS transfer_margin_net_eur_val
    ,-1 * loss_net_eur_val * (1 - loss_split_coeff)             AS correction_cogs_net_eur_val
    
    ,CASE
        WHEN (wor.business_event_type_cd = 'R' AND tgt_price_gross_local_val >= 0) OR     --returns values are negative
             (wor.business_event_type_cd = 'O' AND tgt_price_gross_local_val <= 0)      THEN 1
        WHEN (wor.business_event_type_cd = 'R' AND wor.ivp_price_net_eur_val >= 0) OR     --returns values are negative
             (wor.business_event_type_cd = 'O' AND wor.ivp_price_net_eur_val <= 0)      THEN 2
        ELSE 0
    END                                                         AS quality_check_cd
        
    -- Final Measures <<
FROM core.V_GOODS_ORDER_AND_RETURN_1 wor
    JOIN core.t_fact_coupon_validation_1 cv ON cv.cust_order_sid = wor.cust_order_sid
                                        AND cv.prod_variant_sid = wor.prod_variant_sid
    LEFT JOIN core.t_fact_currency_exchange_rate_1 exr ON wor.curr_cd = exr.from_curr_cd
                                                AND wor.EVENT_DATE BETWEEN exr.active_from_dt AND exr.active_to_dt
                                                AND exr.to_curr_cd = 'EUR'
                                                AND exr.curr_exchange_rate_type_cd = 'R'
    
    LEFT JOIN core.t_dim_tax_class_1 tc ON wor.tax_class_cd = tc.tax_class_cd
                                    AND wor.cust_order_dt BETWEEN tc.active_from_dt AND tc.active_to_dt
                                    AND wor.wshop_cd = tc.wshop_cd

    LEFT JOIN pricing_condition zvp ON wor.prod_variant_sid = zvp.prod_variant_sid
                                    AND wor.cust_order_dt BETWEEN zvp.active_from_dt AND zvp.active_to_dt
                                    AND wor.wshop_cd = zvp.wshop_cd
                                    AND zvp.price_type_cd = 'ZVP'      
    LEFT JOIN pricing_condition vkp ON wor.prod_variant_sid = vkp.prod_variant_sid
                                    AND wor.cust_order_dt BETWEEN vkp.active_from_dt AND vkp.active_to_dt
                                    AND wor.wshop_cd = vkp.wshop_cd
                                    AND vkp.price_type_cd = 'VKP'
    LEFT JOIN pricing_condition akp ON wor.prod_variant_sid = akp.prod_variant_sid
                                    AND wor.cust_order_dt BETWEEN akp.active_from_dt AND akp.active_to_dt
                                    AND wor.wshop_cd = akp.wshop_cd
                                    AND akp.price_type_cd = 'AKP'
    LEFT JOIN FIRST_VKP first_vkp ON wor.prod_variant_sid = first_vkp.prod_variant_sid
                                AND wor.wshop_cd = first_vkp.wshop_cd                           

WHERE NOT cv.coupon_pos_gross_local_val = 0
;