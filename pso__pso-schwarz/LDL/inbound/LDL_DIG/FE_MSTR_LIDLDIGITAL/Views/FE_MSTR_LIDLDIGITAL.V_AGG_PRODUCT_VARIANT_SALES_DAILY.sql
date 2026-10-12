CREATE OR REPLACE VIEW FE_MSTR_LIDLDIGITAL.V_AGG_PRODUCT_VARIANT_SALES_DAILY(
    WSHOP_CD
	, CAL_DT
    , PROD_SALE_TYPE_CD
    , PROD_SET_TYPE_NAME
    , PROD_VARIANT_SID
    , PROD_VARIANT_NR
    , PROD_VARIANT_NAME
	, PROD_SID
	, PROD_NR
	, PROD_NAME
	, BRAND_CLASS_CD
	, BRAND_CLASS_DESCR
	, DELIVERY_SRC_TYPE_CD
	, DELIVERY_SRC_TYPE_DESCR
	, PROD_ORG_LVL_NAME
	, PROD_QTY
	, PROD_PRICE_NET_EUR_VAL
	, COGS_PRICE_NET_EUR_VAL
	, RETURN_PROD_ORDER_DT_PRICE_NET_EUR_VAL
	, RETURN_PROD_ORDER_DT_QTY
	, RETURN_PROD_PRICE_NET_EUR_VAL
	, RETURN_PROD_QTY
	, CANCEL_PROD_QTY
	, CANCEL_PROD_PRICE_NET_EUR_VAL
	, CANCEL_COGS_PRICE_NET_EUR_VAL
	, PROD_COUPON_NET_EUR_VAL
	, DELIVERY_PAUSHAL_NET_EUR_VAL
	, DELIVERY_PAUSHAL_COUPON_NET_EUR_VAL
	, DELIVERY_COST_NET_EUR_VAL
) AS 
SELECT 
    IFNULL( wshop_cd, '-1')                               AS wshop_cd
    , cal_dt                                              AS cal_dt
    , prod_sale_type_cd                                   AS prod_sale_type_cd
    , CASE
		WHEN is_part_of_bundle_header_cnt_fg = 1 AND is_part_of_bundle_pos_cnt_fg = 1	THEN 'Single Item'
		WHEN is_part_of_bundle_header_cnt_fg = 1 AND is_part_of_bundle_pos_cnt_fg = 0	THEN 'Group Header'
												                                        ELSE 'Group Component'
	  END::VARCHAR(20) 									  AS prod_set_type_name
    , IFNULL(prod_variant_sid, '-1')  	                  AS prod_variant_sid
    , prod_variant_nr                                     AS prod_variant_nr
    , prod_variant_name                                   AS prod_variant_name
    , IFNULL(prod_sid , '-1')                             AS prod_sid
    , prod_nr                                             AS prod_nr
    , prod_name                                           AS prod_name
    , IFNULL(brand_class_cd, '-1')                        AS brand_class_cd
    , brand_class_descr                                   AS brand_class_descr
    , IFNULL(delivery_src_type_cd, '-1')                  AS delivery_src_type_cd
    , delivery_src_type_descr                             AS delivery_src_type_descr
    , prod_org_lvl_name                                   AS prod_org_lvl_name
    , prod_qty                                            AS prod_qty
    , prod_price_net_eur_val                              AS prod_price_net_eur_val
    , cogs_price_net_eur_val                              AS cogs_price_net_eur_val
    , return_prod_order_dt_price_net_eur_val              AS return_prod_order_dt_price_net_eur_val
    , return_prod_order_dt_qty                            AS return_prod_order_dt_qty
    , return_prod_price_net_eur_val                       AS return_prod_price_net_eur_val
    , return_prod_qty                                     AS return_prod_qty
    , cancel_prod_qty                                     AS cancel_prod_qty
    , cancel_prod_price_net_eur_val                       AS cancel_prod_price_net_eur_val
    , cancel_cogs_price_net_eur_val                       AS cancel_cogs_price_net_eur_val
    , prod_coupon_net_eur_val                             AS prod_coupon_net_eur_val
    , delivery_paushal_net_eur_val                        AS delivery_paushal_net_eur_val
    , delivery_paushal_coupon_net_eur_val                 AS delivery_paushal_coupon_net_eur_val
    , delivery_cost_net_eur_val                           AS delivery_cost_net_eur_val
   
FROM lec_share.v_agg_product_variant_sales_daily
;