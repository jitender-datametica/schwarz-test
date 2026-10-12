CREATE OR REPLACE VIEW FE_MSTR_LIDLDIGITAL.V_AGG_PRODUCT_VARIANT_PROMOTION_1(
	WSHOP_CD
	,PROMO_ID
	,PROD_VARIANT_SID
	,IS_AFTER_CANCELLATION_FG
	,PROMO_SALE_START_DT
	,PROMO_START_DT
	,CURR_CD
	,CURR_USAGE_TYPE_CD
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
	,DAYS_NOT_ORDERABLE_IN_PROMOTION_CNT
	,ORDERABLE_IN_PROMOTION_START_DT
	,SUPPLIER_ORDER_QTY
	,EST_INIT_PROMO_STOCK_CNT
	,PROMO_SALE_PRICE_GROSS_VAL
	,PROMO_PURCH_PRICE_NET_VAL
	,GROSS_MARGIN_NET_VAL
	,PROD_PRICE_GROSS_VAL
	,PROD_PRICE_NET_VAL
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
        pvp.promo_id
        , pvp.prod_variant_sid
        , pvp.is_after_cancellation_fg
        , pvp.curr_usage_type_cd
        , (pvp.first_week_start_dt + days_since_promo_start_cnt) < DATE(GETDATE())  AS finished_prom_weeks_fg
    FROM lec_share.v_agg_product_variant_promotion_1 pvp
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
    ON pvp.first_week_start_dt BETWEEN valid_from AND valid_to
)

SELECT 
    IFNULL( pvp.wshop_cd, '-1')                                                      AS wshop_cd
    , IFNULL( pvp.promo_id, '-1')                                                    AS promo_id
    , IFNULL( pvp.prod_variant_sid, '-1')                                            AS prod_variant_sid
    , pvp.is_after_cancellation_fg                                                   AS is_after_cancellation_fg
    , promo_sale_start_dt                                                            AS promo_sale_start_dt
    , promo_start_dt                                                                 AS promo_start_dt
    , curr_cd                                                                        AS curr_cd
    , IFNULL( pvp.curr_usage_type_cd, '-1')                                          AS curr_usage_type_cd
    , is_first_promotion_fg                                                          AS is_first_promotion_fg
    , is_repeated_fg                                                                 AS is_repeated_fg
    , sale_promo_type_cd                                                             AS sale_promo_type_cd
    , prod_orderable_lvl_cd                                                          AS prod_orderable_lvl_cd
    , first_delivery_cy_week                                                         AS first_delivery_cy_week
    , LEFT(first_delivery_cy_week,4) || ' KW ' ||RIGHT(first_delivery_cy_week,2)     AS first_delivery_cy_week_name
    , promo_dur_week_cnt                                                             AS promo_dur_week_cnt
    , first_inbound_dt                                                               AS first_inbound_dt
    , finished_3_prom_weeks_fg                                                       AS finished_3_prom_weeks_fg
    , pdur.finished_prom_weeks_fg                                                    AS finished_prom_weeks_fg                                           
    , passed_sale_weeks_cnt                                                          AS passed_sale_weeks_cnt
    , prod_qty                                                                       AS prod_qty
    , return_prod_qty                                                                AS return_prod_qty
    , tgt_prod_sale_qty                                                              AS tgt_prod_sale_qty
    , plan_ab_qty                                                                    AS plan_ab_qty
    , plan_amc_qty                                                                   AS plan_amc_qty
    , delta_plan_ab_qty                                                              AS delta_plan_ab_qty
    , delta_plan_amc_qty                                                             AS delta_plan_amc_total_qty
    , total_plan_ab_qty                                                              AS total_plan_ab_qty
    , total_plan_amc_qty                                                             AS total_plan_amc_qty
    , alloc_stock_cnt                                                                AS alloc_stock_cnt
    , avail_to_promise_cnt                                                           AS avail_to_promise_cnt
    , avail_to_sell_cnt                                                              AS avail_to_sell_cnt
    , blocked_stock_cnt                                                              AS blocked_stock_cnt
    , total_stock_cnt                                                                AS total_stock_cnt
    , receive_on_dock_cnt                                                            AS receive_on_dock_cnt
    , wshop_total_stock_cnt                                                          AS wshop_total_stock_cnt
    , days_not_orderable_in_promotion_cnt                                            AS days_not_orderable_in_promotion_cnt
    , orderable_in_promotion_start_dt                                                AS orderable_in_promotion_start_dt
    , supplier_order_qty                                                             AS supplier_order_qty
    , est_init_promo_stock_cnt                                                       AS est_init_promo_stock_cnt
    , promo_sale_price_gross_val                                                     AS promo_sale_price_gross_val
    , promo_purch_price_net_val                                                      AS promo_purch_price_net_val
    , gross_margin_net_val                                                           AS gross_margin_net_val
    , prod_price_gross_val                                                           AS prod_price_gross_val
    , prod_price_net_val                                                             AS prod_price_net_val
    , promo_purch_price_net_val * wshop_total_stock_cnt                              AS wshop_total_stock_at_purch_price_net_val --verantwortungsbestand_land_zu_ek
    , promo_sale_price_gross_val * wshop_total_stock_cnt                             AS wshop_total_stock_at_sale_price_gross_val --verantwortungsbestand_land_zu_vk
    , promo_sale_price_gross_val * est_init_promo_stock_cnt                          AS est_init_promo_stock_at_sale_price_gross_val --potentialumsatz
    , avail_to_sell_cnt + receive_on_dock_cnt                                        AS venlo_stock_cnt
    , special_analysis_prod_qty                                                      AS special_analysis_prod_qty                                 
	, special_analysis_prod_price_net_val	                                         AS special_analysis_prod_price_net_val	
	, special_analysis_gross_margin_net_val	                                         AS special_analysis_gross_margin_net_val	
	, DIV0( special_analysis_prod_price_net_val , special_analysis_prod_qty)* supplier_order_qty     	AS supplier_order_qty_at_avg_special_analysis_sale_price_net_val
    , DIV0( special_analysis_prod_price_net_val , special_analysis_prod_qty)* est_init_promo_stock_cnt  AS est_init_promo_stock_at_avg_special_analysis_sale_price_net_val
    , DIV0( special_analysis_prod_price_net_val , special_analysis_prod_qty)* wshop_total_stock_cnt     AS wshop_total_stock_at_avg_special_analysis_sale_price_net_val
FROM 
    lec_share.v_agg_product_variant_promotion_1 pvp
LEFT JOIN promo_dur_week_fg AS pdur
        ON  pvp.promo_id = pdur.promo_id
        AND pvp.prod_variant_sid = pdur.prod_variant_sid
        AND pvp.is_after_cancellation_fg = pdur.is_after_cancellation_fg
        AND pvp.curr_usage_type_cd = pdur.curr_usage_type_cd
;