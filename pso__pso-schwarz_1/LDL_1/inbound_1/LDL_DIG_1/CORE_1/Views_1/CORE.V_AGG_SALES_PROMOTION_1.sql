CREATE OR REPLACE VIEW CORE.V_AGG_SALES_PROMOTION_1(
    WSHOP_CD 
    ,PROD_SID
    ,PROMO_START_DT
    ,PROMO_SALE_START_DT 
    ,SALE_PROMO_TYPE_CD 
    ,IS_REPEATED_FG
    ,PROMO_DUR_WEEK_CNT
    ,FIRST_WEEK_START_DT
    ,ANALYSIS_START_DT
    ,ANALYSIS_END_DT
    ,SALE_PROMO_STATUS_CD
    ,PROMO_ID
    ,TGT_PROD_RECEIVE_CY_WEEK
    ,FIRST_DELIVERY_CY_WEEK
    ,SUPPLIER_ORDER_QTY
    ,TGT_PROD_SALE_QTY
    ,IS_FIRST_PROMOTION_FG
    ,PROMO_NR
    ,PROMO_DESCR
    ,AMC_IAN_NR
    ,IS_TV_PROMO_FG
    ,RETURN_COND_DESCR
    ,IS_CATALOG_PROMO_FG
) COMMENT = 'Aggregation of multiple AMC row entries for the same promotion in a single row'  
AS
WITH aggr AS    --we want to get only one promo_id per promotion, sum the quantities reported in the different entries, take only the first delivery dates
(
SELECT
    wshop_cd, 
    prod_sid, 
    promo_start_dt, 
    promo_sale_start_dt, 
    sale_promo_type_cd, 
    is_repeated_fg, 
    promo_dur_week_cnt AS promo_dur_week_cnt,
    first_week_start_dt,
    analysis_start_dt,
    analysis_end_dt,
    sale_promo_status_cd,
    MIN(promo_id) AS promo_id,
    MIN(tgt_prod_receive_cy_week) AS tgt_prod_receive_cy_week,
    MIN(first_delivery_cy_week) AS first_delivery_cy_week,
    SUM(supplier_order_qty) AS supplier_order_qty,
    SUM(tgt_prod_sale_qty) AS tgt_prod_sale_qty,
    
     MIN(CASE WHEN promo_start_dt > date_from_parts(YEAR(GETDATE())-2, MONTH(GETDATE()), 01) AND is_repeated_fg = 'FALSE' 
             THEN promo_start_dt 
             END) 
        OVER (PARTITION BY prod_sid, wshop_cd) 
             AS FIRST_DATE
FROM
    CORE.t_dim_sales_promotion_1
WHERE   dwh_valid_fg
    AND sale_promo_status_cd = 'ACTIVE'
GROUP BY
    wshop_cd, 
    prod_sid, 
    promo_start_dt, 
    promo_sale_start_dt, 
    sale_promo_type_cd, 
    is_repeated_fg,
    promo_dur_week_cnt,
    first_week_start_dt,
    analysis_start_dt,
    analysis_end_dt,
    sale_promo_status_cd
)
SELECT                     --based on the promo_id selected (always the first one in temporal time), we associate to it the values from promo that could be duplicated due to data quality issues/other reasons
    aggr.wshop_cd, 
    aggr.prod_sid, 
    aggr.promo_start_dt, 
    aggr.promo_sale_start_dt, 
    aggr.sale_promo_type_cd, 
    aggr.is_repeated_fg, 
    aggr.promo_dur_week_cnt,
    aggr.first_week_start_dt,
    aggr.analysis_start_dt,
    aggr.analysis_end_dt,
    aggr.sale_promo_status_cd,
    aggr.promo_id,
    aggr.tgt_prod_receive_cy_week,
    aggr.first_delivery_cy_week,
    aggr.supplier_order_qty,
    aggr.tgt_prod_sale_qty,

    CASE WHEN aggr.promo_start_dt = aggr.first_date
    THEN 1
    ELSE 0
    END AS is_first_promotion_fg,
    
    promo.promo_nr,
    promo.promo_descr,
    promo.amc_ian_nr,
    promo.is_tv_promo_fg,
    promo.return_cond_descr,
    promo.is_catalog_prod_fg
FROM
    aggr
JOIN
    CORE.t_dim_sales_promotion_1 promo
    ON  aggr.promo_id = promo.promo_id
WHERE   promo.dwh_valid_fg
    AND promo.sale_promo_status_cd = 'ACTIVE'
;