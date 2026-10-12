CREATE OR REPLACE VIEW FE_MSTR_LIDLDIGITAL.V_AGG_PRODUCT_PROMOTION_1(
	WSHOP_CD
	,PROMO_ID
	,PROMO_SALE_START_DT
	,PROMO_START_DT
	,PROD_SID
	,AMC_IAN_NR
	,IS_AFTER_CANCELLATION_FG
	,CURR_USAGE_TYPE_CD
	,CURR_CD
	,IS_FIRST_PROMOTION_FG
	,IS_REPEATED_FG
	,SALE_PROMO_TYPE_CD
	,PROD_ORDERABLE_LVL_CD
	,FIRST_DELIVERY_CY_WEEK
	,FIRST_DELIVERY_CY_WEEK_NAME
	,PROMO_DUR_WEEK_CNT
	,FIRST_INBOUND_DT
	,FINISHED_3_PROM_WEEKS_FG
    ,FINISHED_PROM_WEEKS_FG
	,PASSED_SALE_WEEKS_CNT
	,PROD_QTY
	,RETURN_PROD_QTY
	,TGT_PROD_SALE_QTY
	,PLAN_AB_QTY
	,PLAN_AMC_QTY
	,DELTA_PLAN_AB_QTY
	,DELTA_PLAN_AMC_QTY
	,TOTAL_PLAN_AB_QTY
	,TOTAL_PLAN_AMC_QTY
	,ALLOC_STOCK_CNT
	,AVAIL_TO_PROMISE_CNT
	,AVAIL_TO_SELL_CNT
	,BLOCKED_STOCK_CNT
	,TOTAL_STOCK_CNT
	,RECEIVE_ON_DOCK_CNT
	,WSHOP_TOTAL_STOCK_CNT
	,WSHOP_PROD_PROMOS_CNT
	,DAYS_NOT_ORDERABLE_IN_PROMOTION_CNT
	,ORDERABLE_IN_PROMOTION_START_DT
	,ORDERABLE_PROD_VARIANTS_CNT
	,SUPPLIER_ORDER_QTY
	,EST_INIT_PROMO_STOCK_CNT
	,PROMO_SALE_PRICE_GROSS_VAL
	,PROMO_PURCH_PRICE_NET_VAL
	,GROSS_MARGIN_NET_VAL
	,PROD_PRICE_GROSS_VAL
	,PROD_PRICE_NET_VAL
	,ACTIVE_PROD_VARIANTS_CNT
	,EST_INIT_PROMO_STOCK_AT_AVG_SALE_PRICE_NET_VAL
	,SUPPLIER_ORDER_QTY_AT_AVG_SALE_PRICE_NET_VAL
	,WSHOP_TOTAL_STOCK_AT_AVG_SALE_PRICE_NET_VAL
	,TGT_PROD_SALE_QTY_AT_SALE_PRICE_GROSS_VAL
	,WSHOP_TOTAL_STOCK_AT_PURCH_PRICE_NET_VAL
	,WSHOP_TOTAL_STOCK_AT_SALE_PRICE_GROSS_VAL
	,EST_INIT_PROMO_STOCK_AT_SALE_PRICE_GROSS_VAL
	,VENLO_STOCK_CNT
	,SPECIAL_ANALYSIS_PROD_QTY
	,SPECIAL_ANALYSIS_PROD_PRICE_NET_VAL
	,SPECIAL_ANALYSIS_GROSS_MARGIN_NET_VAL
	,SUPPLIER_ORDER_QTY_AT_AVG_SPECIAL_ANALYSIS_SALE_PRICE_NET_VAL
	,EST_INIT_PROMO_STOCK_AT_AVG_SPECIAL_ANALYSIS_SALE_PRICE_NET_VAL
	,WSHOP_TOTAL_STOCK_AT_AVG_SPECIAL_ANALYSIS_SALE_PRICE_NET_VAL
) AS 

WITH promo_dur_week_fg AS (
    SELECT 
        promo.promo_id
        , promo.prod_sid
        , promo.is_after_cancellation_fg
        , promo.curr_usage_type_cd
        , (promo.first_week_start_dt + days_since_promo_start_cnt) < DATE(GETDATE())  AS finished_prom_weeks_fg
    FROM lec_share.v_agg_product_promotion_1 promo
    LEFT JOIN 
    (
        SELECT TO_DATE(rep.parameter_value_char, 'YYYY-MM_1-DD') AS active_from
              , active_from AS valid_from
              , LEAD(active_from - 1, 1, TO_DATE('9999-12-31', 'YYYY-MM_1-DD')) OVER (PARTITION BY report ORDER BY active_from) AS valid_to  
              , parameter_value_numeric AS days_since_promo_start_cnt
        FROM 
               lec_share.v_meta_report_parameter_1 rep
        WHERE report = 'Artikelabverkauf'
    ) par 
    ON promo.first_week_start_dt BETWEEN valid_from AND valid_to
)
SELECT 
    IFNULL( promo.wshop_cd, '-1')                                                    AS wshop_cd
    , IFNULL( promo.promo_id, '-1')                                                  AS promo_id
    , promo_sale_start_dt                                                            AS promo_sale_start_dt
    , promo_start_dt                                                                 AS promo_start_dt
    , IFNULL( promo.prod_sid, '-1')                                                  AS prod_sid
    , amc_ian_nr                                                                     AS amc_ian_nr
    , promo.is_after_cancellation_fg                                                 AS is_after_cancellation_fg
    , IFNULL(promo.curr_usage_type_cd, '-1')                                         AS curr_usage_type_cd
    , curr_cd                                                                        AS curr_cd
    , is_first_promotion_fg                                                          AS is_first_promotion_fg
    , is_repeated_fg                                                                 AS is_repeated_fg
    , sale_promo_type_cd                                                             AS sale_promo_type_cd
    , prod_orderable_lvl_cd                                                          AS prod_orderable_lvl_cd
    , first_delivery_cy_week                                                         AS first_delivery_cy_week
    , LEFT(first_delivery_cy_week,4) || ' KW ' ||RIGHT(first_delivery_cy_week,2)     AS first_delivery_cy_week_name
    , promo_dur_week_cnt                                                             AS promo_dur_week_cnt
    , first_inbound_dt                                                               AS first_inbound_dt
    , finished_3_prom_weeks_fg                                                       AS finished_3_prom_weeks_fg
    , finished_prom_weeks_fg                                                         AS finished_prom_weeks_fg
    , passed_sale_weeks_cnt                                                          AS passed_sale_weeks_cnt
    , prod_qty                                                                       AS prod_qty
    , return_prod_qty                                                                AS return_prod_qty
    , tgt_prod_sale_qty                                                              AS tgt_prod_sale_qty
    , plan_ab_qty                                                                    AS plan_ab_qty
    , plan_amc_qty                                                                   AS plan_amc_qty
    , delta_plan_ab_qty                                                              AS delta_plan_ab_qty
    , delta_plan_amc_qty                                                             AS delta_plan_amc_qty
    , total_plan_ab_qty                                                              AS total_plan_ab_qty
    , total_plan_amc_qty                                                             AS total_plan_amc_qty
    , alloc_stock_cnt                                                                AS alloc_stock_cnt
    , avail_to_promise_cnt                                                           AS avail_to_promise_cnt
    , avail_to_sell_cnt                                                              AS avail_to_sell_cnt
    , blocked_stock_cnt                                                              AS blocked_stock_cnt
    , total_stock_cnt                                                                AS total_stock_cnt
    , receive_on_dock_cnt                                                            AS receive_on_dock_cnt
    , wshop_total_stock_cnt                                                          AS wshop_total_stock_cnt
    , wshop_prod_promos_cnt                                                          AS wshop_prod_promos_cnt
    , days_not_orderable_in_promotion_cnt                                            AS days_not_orderable_in_promotion_cnt
    , orderable_in_promotion_start_dt                                                AS orderable_in_promotion_start_dt
    , orderable_prod_variants_cnt                                                    AS orderable_prod_variants_cnt
    , supplier_order_qty                                                             AS supplier_order_qty
    , est_init_promo_stock_cnt                                                       AS est_init_promo_stock_cnt
    , promo_sale_price_gross_val                                                     AS promo_sale_price_gross_val
    , promo_purch_price_net_val                                                      AS promo_purch_price_net_val
    , gross_margin_net_val                                                           AS gross_margin_net_val
    , prod_price_gross_val                                                           AS prod_price_gross_val
    , prod_price_net_val                                                             AS prod_price_net_val
    , active_prod_variants_cnt                                                       AS active_prod_variants_cnt
    , DIV0( prod_price_net_val , prod_qty )* est_init_promo_stock_cnt                AS est_init_promo_stock_at_avg_sale_price_net_val
    , DIV0( prod_price_net_val , prod_qty )* supplier_order_qty                      AS supplier_order_qty_at_avg_sale_price_net_val
    , DIV0( prod_price_net_val , prod_qty )* wshop_total_stock_cnt                   AS wshop_total_stock_at_avg_sale_price_net_val
    , promo_sale_price_gross_val *  tgt_prod_sale_qty                                AS tgt_prod_sale_qty_at_sale_price_gross_val 
    , promo_purch_price_net_val * wshop_total_stock_cnt                              AS wshop_total_stock_at_purch_price_net_val 
    , promo_sale_price_gross_val * wshop_total_stock_cnt                             AS wshop_total_stock_at_sale_price_gross_val 
    , promo_sale_price_gross_val * est_init_promo_stock_cnt                          AS est_init_promo_stock_at_sale_price_gross_val 
    , avail_to_sell_cnt + receive_on_dock_cnt                                        AS venlo_stock_cnt
    , special_analysis_prod_qty                                                      AS special_analysis_prod_qty                                 
	, special_analysis_prod_price_net_val	                                         AS special_analysis_prod_price_net_val	
	, special_analysis_gross_margin_net_val	                                         AS special_analysis_gross_margin_net_val
	, DIV0( special_analysis_prod_price_net_val , special_analysis_prod_qty)* supplier_order_qty     	AS supplier_order_qty_at_avg_special_analysis_sale_price_net_val
    , DIV0( special_analysis_prod_price_net_val , special_analysis_prod_qty)* est_init_promo_stock_cnt  AS est_init_promo_stock_at_avg_special_analysis_sale_price_net_val
    , DIV0( special_analysis_prod_price_net_val , special_analysis_prod_qty)* wshop_total_stock_cnt     AS wshop_total_stock_at_avg_special_analysis_sale_price_net_val
FROM lec_share.v_agg_product_promotion_1 AS promo 
LEFT JOIN promo_dur_week_fg AS pdur
    ON  promo.promo_id = pdur.promo_id
    AND promo.prod_sid = pdur.prod_sid
    AND promo.is_after_cancellation_fg = pdur.is_after_cancellation_fg
    AND promo.curr_usage_type_cd = pdur.curr_usage_type_cd
;