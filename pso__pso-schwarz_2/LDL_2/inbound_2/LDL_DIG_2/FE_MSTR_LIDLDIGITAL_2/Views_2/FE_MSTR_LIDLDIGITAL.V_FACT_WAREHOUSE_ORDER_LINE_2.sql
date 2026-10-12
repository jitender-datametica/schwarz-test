CREATE OR REPLACE VIEW FE_MSTR_LIDLDIGITAL.V_FACT_WAREHOUSE_ORDER_LINE_2(
	WH_ORDER_SID
	,WSHOP_CD
    ,DIST_CHANNEL_CD
	,WH_ORDER_NR
	,WH_ORDER_POS_NR
	,WH_SID
	,WH_CD
	,PROD_VARIANT_SID
	,OUT_INVOICE_DT
	,WH_ORDER_DOC_TYPE_CD
	,WH_ORDER_PROCESS
	,WH_GOODS_ISSUE_STATUS_CD
	,WH_ORDER_CREATE_TMSP
	,WH_ORDER_SHIP_TYPE_NAME
	,WH_ORDER_LINE_PROCESS_STATUS_CD
	,WH_TASK_CONFIRM_TMSP
	,QTY_PRO_STATUS
	,ORDERED_PROD_QTY
	,SORT_TRACK_NAME
	,SORT_TROLLEY_NAME
	,IS_ORDER_IN_PROGRESS_FG
	,OUTBOUND_TMSP
	,WH_TASK_CONFIRM_HOUR
	,PACK_SORT_TRACK_GROUP
	,SORT_TRACK_GROUP
	,DEST_STORAGE_UNIT_NR
	,CUST_ORDER_SID
	,CUST_ORDER_POS_NR
	,ACTUAL_PICK_QTY
	,IS_TASK_IN_PROGRESS_FG
	,MAX_WAVE_QTY
	,ORDER_PICK_QTY
	,PROD_QTY
	,TGT_PICK_QTY
	,WH_ORDER_PROCESS_SORT_STATUS_CD
	,STORAGE_UNIT_NR
) AS
WITH CTE_WAREHOUSE_PROCESSING_TABLE AS
(
    SELECT
         FACT.WH_ORDER_SID
        ,FACT.WH_ORDER_POS_NR
        ,FACT.WH_SID
        ,MAX(FACT.WH_TASK_CONFIRM_TMSP)         AS WH_TASK_CONFIRM_TMSP
        ,MAX(FACT.SORT_TRACK_NAME)              AS SORT_TRACK_NAME
        ,MAX(FACT.PACK_SORT_TRACK_NAME)         AS PACK_SORT_TRACK_NAME
        ,MAX(FACT.SORT_TROLLEY_NAME)            AS SORT_TROLLEY_NAME
        ,MAX(DEST_STORAGE_UNIT_NR)              AS DEST_STORAGE_UNIT_NR
        ,COALESCE(MAX(FACT.PROD_QTY)
                 ,MAX(FACT.ACTUAL_PICK_QTY)
                 ,MAX(FACT.MAX_WAVE_QTY)
                 ,MAX(FACT.TGT_PICK_QTY))       AS PROD_QTY_TASK
    FROM
        lec_share.v_fact_warehouse_processing_2 AS FACT
    INNER JOIN
        (SELECT
             WH_ORDER_SID
            ,WH_ORDER_POS_NR
            ,WH_SID
            ,MAX(WH_TASK_CREATE_TMSP)  AS WH_TASK_CREATE_TMSP
        FROM
            lec_share.v_fact_warehouse_processing_2
        WHERE
            DWH_VALID_FG = TRUE
        GROUP BY
             WH_ORDER_SID
            ,WH_ORDER_POS_NR
            ,WH_SID
        ) AS MAX
    ON  MAX.WH_ORDER_SID        = FACT.WH_ORDER_SID
    AND MAX.WH_ORDER_POS_NR     = FACT.WH_ORDER_POS_NR
    AND MAX.WH_SID              = FACT.WH_SID 
    AND MAX.WH_TASK_CREATE_TMSP = FACT.WH_TASK_CREATE_TMSP
    WHERE
        FACT.DWH_VALID_FG = TRUE
    GROUP BY
         FACT.WH_ORDER_SID
        ,FACT.WH_ORDER_POS_NR
        ,FACT.WH_SID
)
SELECT
     L.WH_ORDER_SID                                                     AS WH_ORDER_SID
    ,CASE WHEN L.WSHOP_CD = ''
          THEN '-1'
          ELSE IFNULL(L.WSHOP_CD, '-1') END                             AS WSHOP_CD
    ,L.DIST_CHANNEL_CD                                                  AS DIST_CHANNEL_CD        --PARKSIDE
    ,L.WH_ORDER_NR                                                      AS WH_ORDER_NR
    ,L.WH_ORDER_POS_NR                                                  AS WH_ORDER_POS_NR
    ,IFNULL(L.WH_SID, '-1')                                             AS WH_SID
    ,IFNULL(L.WH_CD, '-1')                                              AS WH_CD
    ,IFNULL(L.PROD_VARIANT_SID, '-1')                                   AS PROD_VARIANT_SID
    ,L.OUT_INVOICE_DT                                                   AS OUT_INVOICE_DT
    ,CASE WHEN L.WH_ORDER_DOC_TYPE_CD = ''
          THEN '-1'
          ELSE IFNULL(L.WH_ORDER_DOC_TYPE_CD, '-1') END                 AS WH_ORDER_DOC_TYPE_CD
    ,CASE WHEN L.WH_ORDER_DOC_TYPE_CD IN ('ZPLW' , 'ZEPL')
          THEN 'EPO'
          WHEN L.WH_ORDER_DOC_TYPE_CD IN ('ZEPO' , 'ZEPG', 'ZEPW')
          THEN 'MEPO'
          WHEN L.WH_ORDER_DOC_TYPE_CD IN ('ZMPG' , 'ZMPO', 'ZEPT', 'ZMPT', 'ZMPW')
          THEN 'BATCH'
          ELSE 'SONSTIGE' END                                           AS WH_ORDER_PROCESS         -- ATTRIBUTE "PROCESS" IN LUD DASHBOARD
    ,CASE WHEN L.WH_GOODS_ISSUE_STATUS_CD = ''
          THEN '-1'
          ELSE IFNULL(L.WH_GOODS_ISSUE_STATUS_CD, '-1') END             AS WH_GOODS_ISSUE_STATUS_CD
    ,CONVERT_TIMEZONE('Europe/Berlin', L.WH_ORDER_CREATE_TMSP)::TIMESTAMP_NTZ            AS WH_ORDER_CREATE_TMSP
    ,L.WH_ORDER_SHIP_TYPE_NAME                                          AS WH_ORDER_SHIP_TYPE_NAME
    ,IFNULL(LPS.WH_ORDER_LINE_PROCESS_STATUS_CD, '1')                   AS WH_ORDER_LINE_PROCESS_STATUS_CD -- if null then Status_2 1 = 'Nicht in Welle'
    ,P.WH_TASK_CONFIRM_TMSP                                             AS WH_TASK_CONFIRM_TMSP
    ,COALESCE(PROD_QTY_TASK, L.PROD_QTY)                                AS QTY_PRO_STATUS
    ,L.PROD_QTY                                                         AS ORDERED_PROD_QTY    
    ,P.SORT_TRACK_NAME                                                  AS SORT_TRACK_NAME
    ,P.SORT_TROLLEY_NAME                                                AS SORT_TROLLEY_NAME
    ,L.IS_ORDER_IN_PROGRESS_FG                                          AS IS_ORDER_IN_PROGRESS_FG
    ,CONVERT_TIMEZONE('Europe/Berlin', L.OUTBOUND_TMSP)::TIMESTAMP_NTZ  AS OUTBOUND_TMSP
    ,HOUR(P.WH_TASK_CONFIRM_TMSP)                                       AS WH_TASK_CONFIRM_HOUR
    ,CASE
          WHEN LEFT(P.PACK_SORT_TRACK_NAME, 2) = 'SW'
          THEN 'BATCH'
          WHEN LEFT(P.PACK_SORT_TRACK_NAME, 3) = 'EPO'
          THEN 'SINGLES'
          ELSE 'MEPO' END                                               AS PACK_SORT_TRACK_GROUP
    ,CASE
          WHEN LEFT(P.SORT_TRACK_NAME, 2) = 'P0'
          THEN 'P0'
          WHEN LEFT(P.SORT_TRACK_NAME, 2) = 'P1'
          THEN 'P1'
          WHEN LEFT(P.SORT_TRACK_NAME, 2) = 'P2'
          THEN 'P2'
          WHEN LEFT(P.SORT_TRACK_NAME, 2) = 'P3'
          THEN 'P3'
          WHEN LEFT(P.SORT_TRACK_NAME, 2) = 'P4'
          THEN 'P4'
          WHEN LEFT(P.SORT_TRACK_NAME, 2) = 'P5'
          THEN 'P5'
          WHEN LEFT(P.SORT_TRACK_NAME, 2) = 'P6'
          THEN 'P6'
          WHEN LEFT(P.SORT_TRACK_NAME, 2) = 'P7'
          THEN 'P7'
          WHEN LEFT(P.SORT_TRACK_NAME, 2) = 'P8'
          THEN 'P8'
          ELSE 'SONSTIGES' END                                          AS SORT_TRACK_GROUP
         ,CASE WHEN P.DEST_STORAGE_UNIT_NR = '' THEN '-1' ELSE IFNULL(P.DEST_STORAGE_UNIT_NR, '-1') END AS DEST_STORAGE_UNIT_NR
    ,NULL    AS CUST_ORDER_SID
    ,NULL    AS CUST_ORDER_POS_NR
    ,NULL    AS ACTUAL_PICK_QTY
    ,NULL    AS IS_TASK_IN_PROGRESS_FG
    ,NULL    AS MAX_WAVE_QTY
    ,NULL    AS ORDER_PICK_QTY
    ,NULL    AS PROD_QTY
    ,NULL    AS TGT_PICK_QTY
    ,NULL    AS WH_ORDER_PROCESS_SORT_STATUS_CD
    ,IFNULL(LPS.STORAGE_UNIT_NR, '-1') AS   STORAGE_UNIT_NR
FROM
    lec_share.v_fact_warehouse_order_line_2 L
LEFT JOIN CTE_WAREHOUSE_PROCESSING_TABLE P
    ON  L.WH_ORDER_SID      = P.WH_ORDER_SID
    AND L.WH_ORDER_POS_NR   = P.WH_ORDER_POS_NR
    AND L.WH_SID            = P.WH_SID
LEFT JOIN
    lec_share.v_fact_warehouse_order_line_process_status_2  LPS
    ON  L.WH_ORDER_SID    = LPS.WH_ORDER_SID
    AND L.WH_ORDER_POS_NR = LPS.WH_ORDER_POS_NR 
    AND L.WH_SID          = LPS.WH_SID
WHERE
        L.DWH_VALID_FG = TRUE
    ;