CREATE OR REPLACE VIEW FE_MSTR_LIDLDIGITAL.V_AGG_SALES_DAILY(
    WSHOP_CD
	, CAL_DT
	, ORDER_CNT
	, TOTAL_PROD_PRICE_NET_EUR_VAL
	, TGT_REVENUE_NET_EUR_VAL
	, COGS_PRICE_NET_EUR_VAL
	, TGT_COGS_NET_EUR_VAL
	, TOTAL_RETURN_PROD_ORDER_DT_PRICE_NET_EUR_VAL
	, TOTAL_RETURN_PROD_PRICE_NET_EUR_VAL
	, TOTAL_CANCEL_PROD_PRICE_NET_EUR_VAL
	, CANCEL_COGS_PRICE_NET_EUR_VAL
	, TOTAL_PROD_COUPON_NET_EUR_VAL
	, TOTAL_DELIVERY_PAUSHAL_NET_EUR_VAL
	, TOTAL_DELIVERY_PAUSHAL_COUPON_NET_EUR_VAL
	, TOTAL_DELIVERY_COST_NET_EUR_VAL
) AS 
SELECT 
    IFNULL( wshop_cd, '-1')                                     AS wshop_cd
    , cal_dt                                                    AS cal_dt
    , order_cnt                                                 AS order_cnt
    , total_prod_price_net_eur_val                              AS total_prod_price_net_eur_val
    , tgt_revenue_net_eur_val                                   AS tgt_revenue_net_eur_val
    , cogs_price_net_eur_val                                    AS cogs_price_net_eur_val
    , tgt_cogs_net_eur_val                                      AS tgt_cogs_net_eur_val
    , total_return_prod_order_dt_price_net_eur_val              AS total_return_prod_order_dt_price_net_eur_val
    , total_return_prod_price_net_eur_val                       AS total_return_prod_price_net_eur_val
    , total_cancel_prod_price_net_eur_val                       AS total_cancel_prod_price_net_eur_val
    , cancel_cogs_price_net_eur_val                             AS cancel_cogs_price_net_eur_val
    , total_prod_coupon_net_eur_val                             AS total_prod_coupon_net_eur_val
    , total_delivery_paushal_net_eur_val                        AS total_delivery_paushal_net_eur_val
    , total_delivery_paushal_coupon_net_eur_val                 AS total_delivery_paushal_coupon_net_eur_val
    , total_delivery_cost_net_eur_val                           AS total_delivery_cost_net_eur_val
   
FROM lec_share.v_agg_sales_daily
;