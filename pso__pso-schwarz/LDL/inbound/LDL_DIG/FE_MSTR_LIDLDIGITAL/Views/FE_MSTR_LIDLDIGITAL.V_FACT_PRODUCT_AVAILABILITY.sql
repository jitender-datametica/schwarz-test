CREATE OR REPLACE VIEW FE_MSTR_LIDLDIGITAL.V_FACT_PRODUCT_AVAILABILITY(
	WSHOP_CD
	, CAL_DT
	, PROD_SID
	, PROD_NR
	, ACTIVE_FG
	, IS_ORDERABLE_FG
	, IS_VISIBLE_FG
	, IS_SOLD_OUT_FG
	, IS_REPLENISHMENT_CONSIDERED_FG
	, IS_AVAIL_IN_STORE_FG
	, IS_IN_STOCK_FG
	, AVAIL_LVL
	, PROD_ORDERABLE_LVL_CD
	, TOTAL_STOCK_QTY
) AS SELECT
    CASE WHEN WSHOP_CD = '' THEN '-1' ELSE IFNULL(WSHOP_CD, '-1') END                                 	   AS WSHOP_CD
    , CAL_DT                                                                                               AS CAL_DT
    , IFNULL(PROD_SID , '-1')                                                                   		   AS PROD_SID
    , PROD_NR                                                                                   		   AS PROD_NR
	, ACTIVE_FG                                                                                            AS ACTIVE_FG
    , IS_ORDERABLE_FG                                                                                      AS IS_ORDERABLE_FG
    , IS_VISIBLE_FG                                                                                        AS IS_VISIBLE_FG
    , IS_SOLD_OUT_FG                                                                                       AS IS_SOLD_OUT_FG
	, IFF(IS_REPLENISHMENT_CONSIDERED_FG IS NULL, NULL, IFF(IS_REPLENISHMENT_CONSIDERED_FG, 'YES', 'NO'))  AS IS_REPLENISHMENT_CONSIDERED_FG
    , IS_AVAIL_IN_STORE_FG                                                                                 AS IS_AVAIL_IN_STORE_FG
    , IS_IN_STOCK_FG                                                                                       AS IS_IN_STOCK_FG
    , CASE WHEN AVAIL_LVL_CD = '' THEN '-1' ELSE IFNULL(AVAIL_LVL_CD, '-1') END                            AS AVAIL_LVL
    , CASE WHEN PROD_ORDERABLE_LVL_CD = '' THEN '-1' ELSE IFNULL(PROD_ORDERABLE_LVL_CD, '-1') END          AS PROD_ORDERABLE_LVL_CD
    , TOTAL_STOCK_QTY                                                                                      AS TOTAL_STOCK_QTY
FROM
    lec_share.v_fact_product_availability
;