CREATE OR REPLACE TEMPORARY TABLE ${FWRK_WORK_DB}.delta_keys AS (
    SELECT DISTINCT  
           src.dwh_cal_dt AS bus_dt
         , src.loc_sid AS int_org_sid
      FROM ${FWRK_WORK_DB}.VT1 AS src
);

CREATE OR REPLACE TEMPORARY TABLE ETL.vt3 AS 
SELECT
      AGG.BUS_DT
    , AGG.STORE_SID
    , COALESCE(PRDVAR.PROD_SID, -1) AS PROD_SID
    , AGG.SALES_VARIANT_SID
    , AGG.COUNTRY_ORG_SID
    , AGG.COUNTRY_ORG_CD
    , AGG.SALES_CNT
    , AGG.SALES_QTY
    , AGG.RETURN_CNT
    , AGG.RETURN_QTY
    , CASE WHEN EXC.PROD_SID IS NULL THEN AGG.PERF_ADJ_SALES_CNT  END PERF_ADJ_SALES_CNT
    , CASE WHEN EXC.PROD_SID IS NULL THEN AGG.PERF_ADJ_SALES_QTY  END PERF_ADJ_SALES_QTY
    , CASE WHEN EXC.PROD_SID IS NULL THEN AGG.PERF_ADJ_RETURN_CNT  END PERF_ADJ_RETURN_CNT
    , CASE WHEN EXC.PROD_SID IS NULL THEN AGG.PERF_ADJ_RETURN_QTY  END PERF_ADJ_RETURN_QTY
    , AGG.UOM_CD
    , AGG.SALES_NET_VAL AS CASH_REGISTER_SALES_NET_VAL
    , AGG.SALES_GROSS_VAL AS CASH_REGISTER_SALES_GROSS_VAL
    , AGG.RETURN_NET_VAL AS CASH_REGISTER_RETURN_NET_VAL
    , AGG.RETURN_GROSS_VAL AS CASH_REGISTER_RETURN_GROSS_VAL
    , CASE WHEN EXC.PROD_SID IS NULL THEN AGG.PERF_ADJ_SALES_NET_VAL END PERF_ADJ_SALES_NET_VAL
    , CASE WHEN EXC.PROD_SID IS NULL THEN AGG.PERF_ADJ_RETURN_NET_VAL END PERF_ADJ_RETURN_NET_VAL
    , AGG.CURR_CD
    , CURRENT_TIMESTAMP               AS DWH_CREATED_TMSP
    , CURRENT_TIMESTAMP               AS DWH_UPDATED_TMSP
    , 1                               AS DWH_LOAD_ID
    , 'CORE_REL'                      AS DWH_NODE_CD
FROM
(
    SELECT
          SRC.BUS_DT                      AS BUS_DT
        , SRC.STORE_SID                   AS STORE_SID
        , SRC.PROD_VARIANT_SID            AS SALES_VARIANT_SID
        , Any_Value(SRC.COUNTRY_ORG_SID)  AS COUNTRY_ORG_SID
        , Any_Value(SRC.COUNTRY_ORG_CD)   AS COUNTRY_ORG_CD
        , SUM(SRC.PROD_VARIANT_CNT)       AS SALES_VARIANT_CNT
        , SUM(SRC.PROD_VARIANT_QTY)       AS SALES_VARIANT_QTY
        , SUM(CASE WHEN PROD_RETAIL_LINE_TYPE_CD IN ('S', 'SD', 'D', 'RD') THEN PROD_VARIANT_CNT END) AS SALES_CNT
        , SUM(CASE WHEN PROD_RETAIL_LINE_TYPE_CD IN ('S', 'SD', 'D', 'RD') THEN PROD_VARIANT_QTY END) AS SALES_QTY
        , SUM(CASE WHEN PROD_RETAIL_LINE_TYPE_CD IN ('R')                  THEN PROD_VARIANT_CNT END * -1) AS RETURN_CNT
        , SUM(CASE WHEN PROD_RETAIL_LINE_TYPE_CD IN ('R')                  THEN PROD_VARIANT_QTY END * -1) AS RETURN_QTY
        , Any_Value(COALESCE(SRC.UOM_CD, '@')) AS UOM_CD
        , SUM(CASE WHEN PROD_RETAIL_LINE_TYPE_CD IN ('S', 'SD', 'D', 'RD') THEN RETAIL_LINE_NET_VAL END) AS SALES_NET_VAL
        , SUM(CASE WHEN PROD_RETAIL_LINE_TYPE_CD IN ('S', 'SD', 'D', 'RD') THEN RETAIL_LINE_GROSS_VAL END) AS SALES_GROSS_VAL
        , SUM(CASE WHEN PROD_RETAIL_LINE_TYPE_CD IN ('R')                  THEN RETAIL_LINE_NET_VAL END) AS RETURN_NET_VAL
        , SUM(CASE WHEN PROD_RETAIL_LINE_TYPE_CD IN ('R')                  THEN RETAIL_LINE_GROSS_VAL END) AS RETURN_GROSS_VAL
        , Any_Value(COALESCE(SRC.CURR_CD, '@')) AS CURR_CD
        , SUM(CASE WHEN (ABS(SRC.UNIT_PRICE) / ((100 + SRC.TAX_PCT) / 100)) / ER.EXCHANGE_RATE NOT BETWEEN 0.0001 AND 0.0315
                        AND PROD_RETAIL_LINE_TYPE_CD IN ('S', 'SD', 'D', 'RD')
                        THEN SRC.PROD_VARIANT_CNT
                        ELSE 0
              END) AS PERF_ADJ_SALES_CNT
        , SUM(CASE WHEN (ABS(SRC.UNIT_PRICE) / ((100 + SRC.TAX_PCT) / 100)) / ER.EXCHANGE_RATE NOT BETWEEN 0.0001 AND 0.0315
                        AND PROD_RETAIL_LINE_TYPE_CD IN ('R')
                        THEN SRC.PROD_VARIANT_CNT
                        ELSE 0
              END) AS PERF_ADJ_RETURN_CNT


        , SUM(CASE WHEN (ABS(SRC.UNIT_PRICE) / ((100 + SRC.TAX_PCT) / 100)) / ER.EXCHANGE_RATE NOT BETWEEN 0.0001 AND 0.0315
                        AND PROD_RETAIL_LINE_TYPE_CD IN ('S', 'SD', 'D', 'RD')
                        THEN SRC.PROD_VARIANT_QTY
                        ELSE 0
              END) AS PERF_ADJ_SALES_QTY
        , SUM(CASE WHEN (ABS(SRC.UNIT_PRICE) / ((100 + SRC.TAX_PCT) / 100)) / ER.EXCHANGE_RATE NOT BETWEEN 0.0001 AND 0.0315
                        AND PROD_RETAIL_LINE_TYPE_CD IN ('R')
                        THEN SRC.PROD_VARIANT_QTY
                        ELSE 0
              END) AS PERF_ADJ_RETURN_QTY
        , SUM(CASE WHEN (ABS(SRC.UNIT_PRICE) / ((100 + SRC.TAX_PCT) / 100)) / ER.EXCHANGE_RATE NOT BETWEEN 0.0001 AND 0.0315
                        AND PROD_RETAIL_LINE_TYPE_CD IN ('S', 'SD', 'D', 'RD')
                        THEN SRC.RETAIL_LINE_NET_VAL
                        ELSE 0
              END) AS PERF_ADJ_SALES_NET_VAL
        , SUM(CASE WHEN (ABS(SRC.UNIT_PRICE) / ((100 + SRC.TAX_PCT) / 100)) / ER.EXCHANGE_RATE NOT BETWEEN 0.0001 AND 0.0315
                        AND PROD_RETAIL_LINE_TYPE_CD IN ('R')
                        THEN SRC.RETAIL_LINE_NET_VAL
                        ELSE 0
              END) AS PERF_ADJ_RETURN_NET_VAL
    FROM CORE_REL.T_PRODUCT_RETAIL_LINE AS SRC
    JOIN ${FWRK_WORK_DB}.delta_keys dk
       ON dk.int_org_sid = src.store_sid
       AND dk.bus_dt = src.bus_dt
    INNER JOIN
    (
        SELECT TGT_CURR_CD, EXCHANGE_RATE
        FROM CORE_REL.T_EXCHANGE_RATE
        WHERE EXCHANGE_RATE_TYPE_CD = 'BEW_ISK'
          AND SRC_CURR_CD = 'EUR'
          AND DWH_VALID_FG = TRUE
    ) AS ER
    ON  SRC.CURR_CD = ER.TGT_CURR_CD
    WHERE SRC.TURNOVER_RELEVANT_FG = TRUE
    AND SRC.BUS_DT BETWEEN $min_dwh_cal_dt AND $max_dwh_cal_dt
    GROUP BY
          SRC.BUS_DT
        , SRC.STORE_SID
        , SRC.PROD_VARIANT_SID
) AS AGG
LEFT OUTER JOIN CORE_REL.T_PRODUCT_VARIANT AS PRDVAR
  ON  PRDVAR.PROD_VARIANT_SID = AGG.SALES_VARIANT_SID
  AND PRDVAR.DWH_VALID_FG = TRUE
LEFT OUTER JOIN
(
    SELECT DISTINCT PPG.PROD_SID
    FROM CORE_REL.T_PRODUCT_TO_PRODUCT_GROUP AS PPG
    INNER JOIN CORE_REL.T_PRODUCT_GROUP_HIERARCHY AS PGH1
    ON  PPG.DWH_VALID_FG = TRUE
    AND PPG.PROD_GRP_TYPE_CD = 'IFG'
    AND PPG.PROD_GRP_SID = PGH1.PROD_GRP_SID
    AND PGH1.PROD_GRP_HIERARCHY_TYPE_CD = 'IGH'
    AND PGH1.DWH_VALID_FG = TRUE
    INNER JOIN CORE_REL.T_PRODUCT_GROUP AS SIG
    ON  PGH1.PARENT_PROD_GRP_SID = SIG.PROD_GRP_SID
    AND SIG.DWH_VALID_FG = TRUE
    LEFT OUTER JOIN CORE_REL.T_PRODUCT_GROUP_HIERARCHY AS PGH2
    ON  PGH1.PARENT_PROD_GRP_SID = PGH2.PROD_GRP_SID
    AND PGH2.PROD_GRP_HIERARCHY_TYPE_CD = 'IGH'
    AND PGH2.DWH_VALID_FG = TRUE
    LEFT OUTER JOIN CORE_REL.T_PRODUCT_GROUP AS IGI
    ON  PGH2.PARENT_PROD_GRP_SID = IGI.PROD_GRP_SID
    AND IGI.DWH_VALID_FG = TRUE
    WHERE IGI.PROD_GRP_SID IS NULL
      AND TRY_CAST(SIG.PROD_GRP_NR AS Number) <> 991 /* Ignore all except commissions from the "Admin" group */
) AS EXC
ON  PRDVAR.PROD_SID = EXC.PROD_SID
;

/* 
##########################################################################
#STEP 2: Delete data from target                                         #
##########################################################################
*/

BEGIN TRANSACTION;


DELETE FROM CORE_DIM.t_fact_retail_by_store_day_product agg USING ETL.vt1 b
WHERE b.country_cd = agg.country_org_cd
AND b.dwh_cal_dt = agg.bus_dt
AND b.loc_sid = agg.store_sid;


/* 
##########################################################################
#STEP 3: Load target table                                               #
##########################################################################
*/

/* 
#  1.01	22.03.2025 Stephane Tonga  change value sign from negativ to positiv of the kpis return_cnt, return_qty
*/


MERGE INTO CORE_DIM.t_fact_retail_by_store_day_product tgt
USING ETL.vt3 agg
ON  tgt.bus_dt = agg.bus_dt
AND tgt.store_sid = agg.store_sid
AND tgt.sales_variant_sid = agg.sales_variant_sid
WHEN NOT MATCHED THEN INSERT
(
bus_dt,
store_sid,
prod_sid,
sales_variant_sid,
country_org_sid,
country_org_cd,
sales_cnt,
sales_qty,
return_cnt,
return_qty,
perf_adj_sales_cnt,
perf_adj_sales_qty,
perf_adj_return_cnt,
perf_adj_return_qty,
perf_adj_sales_net_val,
perf_adj_return_net_val,
uom_cd,
cash_register_sales_net_val,
cash_register_sales_gross_val,
cash_register_return_net_val,
cash_register_return_gross_val,
curr_cd,
dwh_created_tmsp,
dwh_updated_tmsp,
dwh_load_id,
dwh_node_cd
)
VALUES
(
agg.bus_dt,
agg.store_sid,
agg.prod_sid,
agg.sales_variant_sid,
agg.country_org_sid,
agg.country_org_cd,
agg.sales_cnt,
agg.sales_qty,
agg.return_cnt,
agg.return_qty,
agg.perf_adj_sales_cnt,
agg.perf_adj_sales_qty,
agg.perf_adj_return_cnt,
agg.perf_adj_return_qty,
agg.perf_adj_sales_net_val,
agg.perf_adj_return_net_val,
agg.uom_cd,
agg.cash_register_sales_net_val,
agg.cash_register_sales_gross_val,
agg.cash_register_return_net_val,
agg.cash_register_return_gross_val,
agg.curr_cd,
agg.dwh_created_tmsp,
agg.dwh_updated_tmsp,
agg.dwh_load_id,
agg.dwh_node_cd
)
;

COMMIT;


/* 
##########################################################################
#STEP 5: Load delta                                                      #
##########################################################################
*/


INSERT INTO etl_process.t_prcs_delta  (
SELECT 't_fact_retail_by_store_day_product' as DEPENDENCY,
       dl.DWH_NODE_CD,
       dl.COUNTRY_CD,
       dl.DWH_CAL_DT,
       dl.LOC_SID,
       dl.LOAD_TMSP,
       dl.DWH_LOAD_ID 
FROM ETL_PROCESS.t_prcs_delta AS dl
JOIN CORE_DIM.T_DIM_CALENDAR_DATE AS dt
    ON dt.cal_dt BETWEEN dl.DWH_CAL_DT AND CURRENT_DATE
WHERE dl.dwh_load_id = ${LOAD_ID});
