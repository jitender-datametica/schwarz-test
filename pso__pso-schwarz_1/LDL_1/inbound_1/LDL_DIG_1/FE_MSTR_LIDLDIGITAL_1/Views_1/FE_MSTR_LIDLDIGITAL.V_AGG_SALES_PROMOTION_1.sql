CREATE OR REPLACE VIEW FE_MSTR_LIDLDIGITAL.V_AGG_SALES_PROMOTION_1(
	WSHOP_CD
	, PROD_SID
	, PROMO_START_DT
	, PASSED_SALE_WEEKS
	, PROMO_SALE_START_DT
	, SALE_PROMO_TYPE_CD
	, IS_REPEATED_FG
	, PROMO_DUR_WEEK_CNT
	, FIRST_WEEK_START_DT
	, ANALYSIS_START_DT
	, ANALYSIS_END_DT
	, SALE_PROMO_STATUS_CD
	, PROMO_ID
	, TGT_PROD_RECEIVE_CY_WEEK
	, FIRST_DELIVERY_CY_WEEK
	, SUPPLIER_ORDER_QTY
	, TGT_PROD_SALE_QTY
	, IS_FIRST_PROMOTION_FG
	, PROMO_NR
	, PROMO_DESCR
	, AMC_IAN_NR
	, AMC_IAN_NR_ARTIKELABVERKAUF
	, IS_TV_PROMO_FG
	, RETURN_COND_DESCR
	, IS_CATALOG_PROMO_FG
	, FINISHED_3_PROM_WEEKS_FG
	, FINISHED_PROM_WEEKS_FG
) AS 

WITH promo_dur_week_fg AS (
    SELECT 
        promo.promo_id
        , promo.wshop_cd
        , promo.prod_sid
        , (promo.first_week_start_dt + days_since_promo_start_cnt) < DATE(GETDATE())  AS finished_prom_weeks_fg
    FROM lec_share.v_agg_sales_promotion_core_view_1 AS promo
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
     CASE WHEN PROMO.WSHOP_CD = '' THEN '-1' ELSE IFNULL(PROMO.WSHOP_CD, '-1') END AS WSHOP_CD
    ,IFNULL(PROMO.PROD_SID, '-1') AS PROD_SID
    ,PROMO_START_DT AS PROMO_START_DT    
    ,FLOOR(DATEDIFF(DAY, PROMO_START_DT, CURRENT_DATE()) / 7) AS PASSED_SALE_WEEKS
    ,PROMO_SALE_START_DT AS PROMO_SALE_START_DT
    ,CASE WHEN SALE_PROMO_TYPE_CD = '' THEN '-1' ELSE IFNULL(SALE_PROMO_TYPE_CD, '-1') END AS SALE_PROMO_TYPE_CD
    ,IS_REPEATED_FG AS IS_REPEATED_FG
    ,PROMO_DUR_WEEK_CNT AS PROMO_DUR_WEEK_CNT
    ,FIRST_WEEK_START_DT AS FIRST_WEEK_START_DT
    ,ANALYSIS_START_DT AS ANALYSIS_START_DT
    ,ANALYSIS_END_DT AS ANALYSIS_END_DT
    ,CASE WHEN SALE_PROMO_STATUS_CD = '' THEN '-1' ELSE IFNULL(SALE_PROMO_STATUS_CD, '-1') END AS SALE_PROMO_STATUS_CD
    ,IFNULL(PROMO.PROMO_ID, '-1') AS PROMO_ID
    ,TGT_PROD_RECEIVE_CY_WEEK AS TGT_PROD_RECEIVE_CY_WEEK
    ,FIRST_DELIVERY_CY_WEEK AS FIRST_DELIVERY_CY_WEEK
    ,SUPPLIER_ORDER_QTY AS SUPPLIER_ORDER_QTY
    ,TGT_PROD_SALE_QTY AS TGT_PROD_SALE_QTY
    ,IS_FIRST_PROMOTION_FG AS IS_FIRST_PROMOTION_FG
    ,PROMO_NR AS PROMO_NR
    ,PROMO_DESCR AS PROMO_DESCR
    ,IFNULL(AMC_IAN_NR,'-1') AS AMC_IAN_NR
    ,IFNULL(AMC_IAN_NR, 'n/a') AS AMC_IAN_NR_ARTIKELABVERKAUF -- special requirement for artikelabverkauf report
    ,IS_TV_PROMO_FG AS IS_TV_PROMO_FG
    ,RETURN_COND_DESCR AS RETURN_COND_DESCR
    ,IS_CATALOG_PROMO_FG AS IS_CATALOG_PROMO_FG
    ,FIRST_WEEK_START_DT + 13 < DATE(GETDATE()) AS FINISHED_3_PROM_WEEKS_FG
    ,finished_prom_weeks_fg AS FINISHED_PROM_WEEKS_FG
FROM
    lec_share.v_agg_sales_promotion_core_view_1 AS promo 
LEFT JOIN 
    promo_dur_week_fg AS pdur
        ON promo.promo_id = pdur.promo_id
        AND promo.wshop_cd = pdur.wshop_cd
        AND promo.prod_sid = pdur.prod_sid
UNION ALL
    SELECT
         '-1' -- WSHOP_CD
        ,'-1' -- PROD_SID
        ,DATE('1900-01-01') -- PROMO_START_DT
        ,'0' -- PASSED_SALE_WEEKS
        ,DATE('1900-01-01') -- PROMO_SALE_START_DT
        ,'-1' -- SALE_PROMO_TYPE_CD
        ,'FALSE' -- IS_REPEATED_FG
        ,'0' -- PROMO_DUR_WEEK_CNT
        ,DATE('1900-01-01') -- FIRST_WEEK_START_DT
        ,DATE('1900-01-01') -- ANALYSIS_START_DT
        ,DATE('1900-01-01') -- ANALYSIS_END_DT
        ,'-1' -- SALE_PROMO_STATUS_CD
        ,'-1' -- PROMO_ID
        ,'0' -- TGT_PROD_RECEIVE_CY_WEEK
        ,'0' -- FIRST_DELIVERY_CY_WEEK
        ,'0' -- SUPPLIER_ORDER_QTY
        ,'0' -- TGT_PROD_SALE_QTY
        ,'0' -- IS_FIRST_PROMOTION_FG
        ,'-1' -- PROMO_NR
        ,'' -- PROMO_DESCR
        ,'-1' -- AMC_IAN_NR
        ,'n/a' -- AMC_IAN_NR_ARTIKELABVERKAUF
        ,'FALSE' -- IS_TV_PROMO_FG
        ,'' -- RETURN_COND_DESCR
        ,'FALSE' -- IS_CATALOG_PROMO_FG
        ,'FALSE' -- FINISHED_3_PROM_WEEKS_FG
        ,'FALSE' -- FINISEHD_PROM_WEEKS_FG
;