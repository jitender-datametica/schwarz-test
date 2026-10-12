CREATE OR REPLACE VIEW FE_MSTR_LIDLDIGITAL.V_AGG_PRODUCT_VARIANT_PROMOTION_CLUSTER(
	WSHOP_CD
	,PROMO_ID
	,PROD_VARIANT_SID
	,PROMO_START_DT
	,PROMO_SALE_START_DT
	,IS_AFTER_CANCELLATION_FG
	,CURR_USAGE_TYPE_CD
	,CURR_CD
	,PROD_ORDERABLE_LVL_CD
	,FIRST_INBOUND_DT
	,PROMO_SALE_CLUSTER_CD
	,CURRENT_PROMO_SALE_CLUSTER_CD
	,IS_CURRENT_PROMO_SALE_CLUSTER_FG
	,PROD_QTY
	,CUM_PROD_QTY
	,RETURN_PROD_QTY
	,CUM_RETURN_PROD_QTY
	,GROSS_MARGIN_NET_VAL
	,CUM_GROSS_MARGIN_NET_VAL
	,PROD_PRICE_NET_VAL
	,CUM_PROD_PRICE_NET_VAL
	,PROD_PRICE_GROSS_VAL
	,CUM_PROD_PRICE_GROSS_VAL
	,SALE_PROMO_TYPE_CD
	,IS_FIRST_PROMOTION_FG
	,IS_REPEATED_FG
	,PROMO_DUR_WEEK_CNT
	,FIRST_DELIVERY_CY_WEEK
	,FINISHED_3_PROM_WEEKS_FG
    ,FINISHED_PROM_WEEKS_FG
	,PLAN_AMC_QTY
	,CUM_PLAN_AMC_QTY
	,PLAN_AB_QTY
	,CUM_PLAN_AB_QTY
) AS

WITH promo_dur_week_fg AS (
    SELECT 
        pvp.promo_id
        , pvp.prod_variant_sid
        , pvp.is_after_cancellation_fg
        , pvp.curr_usage_type_cd
        , pvp.promo_sale_cluster_cd
        , (pvp.first_week_start_dt + days_since_promo_start_cnt) < DATE(GETDATE())  AS finished_prom_weeks_fg
    FROM lec_share.v_agg_product_variant_promotion_cluster pvp
    LEFT JOIN 
    (
        SELECT TO_DATE(rep.parameter_value_char, 'YYYY-MM-DD') AS active_from
              , active_from AS valid_from
              , LEAD(active_from - 1, 1, TO_DATE('9999-12-31', 'YYYY-MM-DD')) OVER (PARTITION BY report ORDER BY active_from) AS valid_to  
              , parameter_value_numeric AS days_since_promo_start_cnt
        FROM 
               lec_share.v_meta_report_parameter rep
        WHERE report = 'Artikelabverkauf'
    ) par 
    ON pvp.first_week_start_dt BETWEEN valid_from AND valid_to
)
SELECT 
    IFNULL( promo.wshop_cd, '-1')                                  AS wshop_cd
    , IFNULL( promo.promo_id, '-1')                                AS promo_id
    , IFNULL( promo.prod_variant_sid, '-1')                        AS prod_variant_sid
    , promo_start_dt
    , promo_sale_start_dt
    , promo.is_after_cancellation_fg                               AS is_after_cancellation_fg
    , IFNULL( promo.curr_usage_type_cd, '-1')                      AS curr_usage_type_cd
    , curr_cd
    , prod_orderable_lvl_cd
    , first_inbound_dt
    , promo.promo_sale_cluster_cd
    , current_promo_sale_cluster_cd
    , is_current_promo_sale_cluster_fg
    , prod_qty
    , cum_prod_qty
    , return_prod_qty
    , cum_return_prod_qty
    , gross_margin_net_val
    , cum_gross_margin_net_val
    , prod_price_net_val
    , cum_prod_price_net_val
    , prod_price_gross_val
    , cum_prod_price_gross_val
    , sale_promo_type_cd
    , is_first_promotion_fg
    , is_repeated_fg
    , promo_dur_week_cnt
    , first_delivery_cy_week
    , finished_3_prom_weeks_fg
    , finished_prom_weeks_fg
    , plan_amc_qty                                                                     
    , cum_plan_amc_qty                                                                 
    , plan_ab_qty                                                                      
    , cum_plan_ab_qty
FROM 
    lec_share.v_agg_product_variant_promotion_cluster AS promo
LEFT JOIN promo_dur_week_fg AS pdur
        ON  promo.promo_id = pdur.promo_id
        AND promo.prod_variant_sid = pdur.prod_variant_sid
        AND promo.is_after_cancellation_fg = pdur.is_after_cancellation_fg
        AND promo.curr_usage_type_cd = pdur.curr_usage_type_cd
        AND promo.promo_sale_cluster_cd = pdur.promo_sale_cluster_cd
;