CREATE OR REPLACE VIEW FE_MSTR_LIDLDIGITAL.V_FACT_PRODUCT_VARIANT_AVAILABILITY(
	WSHOP_CD
	, CAL_DT
	, PROD_VARIANT_SID
	, ACTIVE_FG
	, PROD_VARIANT_NR
	, IS_ORDERABLE_FG
	, IS_VISIBLE_FG
	, IS_REPLENISHMENT_CONSIDERED_FG
	, IS_AVAIL_IN_STORE_FG
	, IS_IN_STOCK_FG
	, AVAIL_LVL
	, PROD_ORDERABLE_LVL_CD
	, PROD_ORDERABLE_LVL_CD_PRODUCT
    , CONTENT_CLASSIFICATION_RATING
	, SRC_CATALOG_NAME
	, IS_IN_PROMO_FG
	, MAX_ORDER_QTY
	, TOTAL_STOCK_QTY
	, LOCALE_NAME
	, IS_LEGACY_FG
	, IS_SOLD_OUT_FG
	, PROD_SID
	, PROD_NR
	, REG_PROD_NAME
	, AVAIL_LVL_PRODUCT
	, IS_ORDERABLE_FG_PRODUCT
	, IS_VISIBLE_FG_PRODUCT
	, IS_REPLENISHMENT_CONSIDERED_FG_PRODUCT
	, IS_AVAIL_IN_STORE_FG_PRODUCT
	, IS_IN_STOCK_FG_PRODUCT
) AS SELECT
   CASE WHEN PA.WSHOP_CD = '' THEN '-1' ELSE IFNULL(PA.WSHOP_CD, '-1') END                                 AS WSHOP_CD
    , CAL_DT                                                                                               AS CAL_DT
    , IFNULL(PA.PROD_VARIANT_SID , '-1')                                                                   AS PROD_VARIANT_SID
    , ACTIVE_FG                                                                                            AS ACTIVE_FG
    , PA.PROD_VARIANT_NR                                                                                   AS PROD_VARIANT_NR
    , IS_ORDERABLE_FG                                                                                      AS IS_ORDERABLE_FG
    , IS_VISIBLE_FG                                                                                        AS IS_VISIBLE_FG
    , IFF(IS_REPLENISHMENT_CONSIDERED_FG IS NULL, NULL, IFF(IS_REPLENISHMENT_CONSIDERED_FG, 'YES', 'NO'))  AS IS_REPLENISHMENT_CONSIDERED_FG
    , IS_AVAIL_IN_STORE_FG                                                                                 AS IS_AVAIL_IN_STORE_FG
    , IS_IN_STOCK_FG                                                                                       AS IS_IN_STOCK_FG
    , CASE WHEN AVAIL_LVL_CD = '' THEN '-1' ELSE IFNULL(AVAIL_LVL_CD, '-1') END                            AS AVAIL_LVL
    , CASE WHEN PROD_ORDERABLE_LVL_CD = '' THEN '-1' ELSE IFNULL(PROD_ORDERABLE_LVL_CD, '-1') END          AS PROD_ORDERABLE_LVL_CD
    , COALESCE(MAX(PROD_ORDERABLE_LVL_CD) OVER (PARTITION BY PVR.WSHOP_CD, CAL_DT, PVR.PROD_SID), '-1')    AS PROD_ORDERABLE_LVL_CD_PRODUCT
    , IFNULL (CONTENT_CLASSIFICATION_RATING, '-1')                                                         AS CONTENT_CLASSIFICATION_RATING
    , SRC_CATALOG_NAME                                                                                     AS SRC_CATALOG_NAME
    , IS_IN_PROMO_FG                                                                                       AS IS_IN_PROMO_FG
    , MAX_ORDER_QTY                                                                                        AS MAX_ORDER_QTY
    , TOTAL_STOCK_QTY                                                                                      AS TOTAL_STOCK_QTY
    , LOCALE_NAME                                                                                          AS LOCALE_NAME
    , IS_LEGACY_FG                                                                                         AS IS_LEGACY_FG
    , IS_SOLD_OUT_FG                                                                                       AS IS_SOLD_OUT_FG
	, PVR.PROD_SID                                                                                         AS PROD_SID
	, PVR.PROD_NR                                                                                          AS PROD_NR
	, PVR.REG_PROD_NAME                                                                                    AS REG_PROD_NAME
	, COALESCE(MAX(AVAIL_LVL_CD) OVER (PARTITION BY PVR.WSHOP_CD, CAL_DT, PVR.PROD_SID), '-1')             AS AVAIL_LVL_PRODUCT
	, MAX(is_orderable_fg) OVER (PARTITION BY pvr.wshop_cd, cal_dt, pvr.prod_sid)                          AS IS_ORDERABLE_FG_PRODUCT
	, MAX(is_visible_fg) OVER (PARTITION BY pvr.wshop_cd, cal_dt, pvr.prod_sid)                            AS is_visible_fg_PRODUCT
	, MAX(IS_REPLENISHMENT_CONSIDERED_FG) OVER (PARTITION BY pvr.wshop_cd, cal_dt, pvr.prod_sid)           AS IS_REPLENISHMENT_CONSIDERED_FG_PRODUCT
	, MAX(IS_AVAIL_IN_STORE_FG) OVER (PARTITION BY pvr.wshop_cd, cal_dt, pvr.prod_sid)                     AS IS_AVAIL_IN_STORE_FG_PRODUCT
	, MAX(IS_IN_STOCK_FG) OVER (PARTITION BY pvr.wshop_cd, cal_dt, pvr.prod_sid)                           AS IS_IN_STOCK_FG_PRODUCT
FROM
    lec_share.v_fact_product_variant_availability PA
LEFT OUTER JOIN
    FE_MSTR_LIDLDIGITAL.V_REL_PRODUCT_VARIANT_REGIONAL PVR
    ON PA.PROD_VARIANT_SID = PVR.PROD_VARIANT_SID
    AND PA.WSHOP_CD = PVR.WSHOP_CD
;