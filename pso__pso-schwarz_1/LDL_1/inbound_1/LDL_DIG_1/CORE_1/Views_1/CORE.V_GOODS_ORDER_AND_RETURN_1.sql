CREATE OR REPLACE VIEW CORE.V_GOODS_ORDER_AND_RETURN_1(
	BUSINESS_EVENT_TYPE_CD COMMENT '\"O\" for orders, \"R\" for returns',
	CUST_ORDER_SID COMMENT 'The unique identifier (surrogate key) for customer order',
	DOCUMENT_NR COMMENT 'The original order number or return order number from the source system',
	PROD_VARIANT_SID COMMENT 'Unique identifier (surrogate key) of the ordered/returned product',
	PROD_VARIANT_NR COMMENT 'The original number of the ordered/returned product',
	WSHOP_CD COMMENT 'The unique code for the Lidl webshop, where an order can be placed by a customer. The webshop is defined per political country.',
	EVENT_DATE COMMENT 'For Orders this is order_perform_dt (when delivery started). For Returns this is order_return_dt',
	CUST_ORDER_DT COMMENT 'The date when order was made',
	CURR_CD COMMENT 'Currency code in which order has been payed',
	TAX_CLASS_CD COMMENT 'The code identifying the tax class',
	DELIVERY_SRC_TYPE_CD COMMENT 'The code for source location_1 of product from where it is delivered i.e. from supplier_1 or warehouse directly',
	PROD_QTY COMMENT 'Quantity of a particular product ordered',
	IVP_PRICE_NET_EUR_VAL COMMENT 'Cost-of-Goods-sold, short: CoGs. Needed for calc of margin (= revenue - cogs )',
    ORDER_PROD_PRICE_GROSS_LOCAL_VAL COMMENT 'Original (listed) gross price of a product in local currency',
	PROD_PRICE_GROSS_LOCAL_VAL COMMENT 'For orders, this is the original (listed) gross price of a product in local currency. For returns, this is the credit note.'
) COMMENT='All events (orders AND returns) which are needed for Goods Losses reports, aggregate to CUST_ORDER_SID + PROD_VARIANT_SID level'
 AS
SELECT
    'O' AS BUSINESS_EVENT_TYPE_CD -- order
    ,cust_order_sid
    ,cust_order_nr AS document_nr
    ,prod_variant_sid
    ,prod_variant_nr
    -- 
    ,wshop_cd
    ,cust_order_perform_dt AS EVENT_DATE
    ,cust_order_dt
    ,curr_cd
    ,tax_class_cd
    ,delivery_src_type_cd
    
    ,SUM(prod_qty) AS prod_qty
    ,SUM(ivp_unit_price_net_eur_val * prod_qty) AS ivp_price_net_eur_val
    ,SUM(prod_price_gross_local_val) AS order_prod_price_gross_local_val
    ,SUM(prod_price_gross_local_val) AS prod_price_gross_local_val
FROM core.T_FACT_CUSTOMER_ORDER_LINE_1 ol
WHERE 1=1
    AND is_order_cancel_fg = FALSE
    AND is_part_of_bundle_header_cnt_fg = TRUE
    -- orders before this date will be exported as data set from QV and imported in a "legacy" table 
	AND (
			cust_order_perform_dt >= '2022-03-01' 
			OR (cust_order_perform_dt IS NULL AND cust_order_dt >= '2022-03-01')
		)
GROUP BY
    cust_order_sid
    ,cust_order_nr
    ,prod_variant_sid
    ,prod_variant_nr
    --
    ,wshop_cd
    ,cust_order_perform_dt
    ,cust_order_dt
    ,curr_cd
    ,tax_class_cd
    ,delivery_src_type_cd  

UNION ALL

SELECT 
    'R' AS BUSINESS_EVENT_TYPE_CD -- return
    ,orl.cust_order_sid
    ,orl.cust_order_return_nr AS document_nr
    ,orl.prod_variant_sid
    ,orl.prod_variant_nr
    --
    ,orl.wshop_cd
    ,orl.cust_order_return_dt AS EVENT_DATE
    ,orl.cust_order_dt
    ,orl.curr_cd
    ,ol.tax_class_cd
    ,ol.delivery_src_type_cd

    ,SUM(-1 * orl.prod_qty) AS prod_qty
    ,SUM(-1 * cogs_price_net_eur_val) AS ivp_price_net_eur_val
    ,SUM(-1 * ol.prod_price_gross_local_val) AS order_prod_price_gross_local_val
    ,SUM(-1 * orl.prod_price_gross_local_val) AS prod_price_gross_local_val
FROM  core.T_FACT_CUSTOMER_RETURN_LINE_1 orl
    JOIN core.T_FACT_CUSTOMER_ORDER_LINE_1 ol         ON orl.cust_order_sid = ol.cust_order_sid
                                                    AND orl.cust_order_pos_nr = ol.cust_order_pos_nr
WHERE 1=1
    AND orl.prod_price_gross_local_val > 0       -- excluding returns which are not resulting in a credit note to the customer -> there is no loss
    AND orl.cust_order_return_dt >= '2022-03-01' -- returns before this date will be exported as data set from QV and imported in a "legacy" table 
GROUP BY 
    orl.cust_order_sid
    ,orl.cust_order_return_nr
    ,orl.prod_variant_sid
    ,orl.prod_variant_nr
    --
    ,orl.wshop_cd
    ,orl.cust_order_return_dt
    ,orl.cust_order_dt
    ,orl.curr_cd
    ,ol.tax_class_cd
    ,ol.delivery_src_type_cd
;