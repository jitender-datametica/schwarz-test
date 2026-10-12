CREATE OR REPLACE VIEW LEC_SHARE.V_AGG_DATA_QUALITY_KPI(
	CUST_ORDER_DT
    , ORDER_POSITIONS_CNT
    , MISSING_COGS_PER_POSITION_CNT
    , COGS_AVAILABILITY_PCT
    , PRCD_UPDATED_TMSP
    , ORDER_LINE_SHEDULED_TMSP
    , CHECK_PRCD_IN_TIME
    , TOTAL_ORDERS_CNT
    , DELAY_CNT
    , DELAY_PCT
    , ON_TIME_PCT
	) AS
WITH
    COGS_DATA AS (
        SELECT
            ORDER_LINE.CUST_ORDER_DT                                      AS CUST_ORDER_DT
            , ZEROIFNULL( ORDER_LINE.COGS_PRICE_NET_LOCAL_VAL ) = 0       AS ZERO_COGS_FG
        FROM
            CORE.T_FACT_CUSTOMER_ORDER_LINE                               AS ORDER_LINE
        WHERE
            ORDER_LINE.CUST_ORDER_DT >= CURRENT_DATE() - 14
    )
    , COGS_AGG AS (
        SELECT
            CUST_ORDER_DT                                                              AS CUST_ORDER_DT
            , COUNT( * )                                                               AS ORDER_POSITIONS_CNT
            , SUM( ( ZERO_COGS_FG ) ::INTEGER )                                        AS MISSING_COGS_PER_POSITION_CNT
            , DIV0( MISSING_COGS_PER_POSITION_CNT, ORDER_POSITIONS_CNT)                AS COGS_AVAILABILITY_RATIO
            , 100 - ROUND( 100*( COGS_AVAILABILITY_RATIO ), 2 ) || ' %'                AS COGS_AVAILABILITY_PCT
        FROM
            COGS_DATA
        GROUP BY
            CUST_ORDER_DT
    )
    , PRCD_AGG AS (
        SELECT
            DATE(DWH_UPDATED_TMSP) - 1                                                 AS CUST_ORDER_DT
            , MAX(DWH_UPDATED_TMSP)                                                    AS PRCD_UPDATED_TMSP
            , CAST(CONCAT(DATE(DWH_UPDATED_TMSP), ' 05:00:00') AS TIMESTAMP)           AS ORDER_LINE_SHEDULED_TMSP
            , CASE WHEN PRCD_UPDATED_TMSP > ORDER_LINE_SHEDULED_TMSP
                THEN '❌'
                ELSE '✔'
            END                                                                        AS CHECK_PRCD_IN_TIME
        FROM
            ETL_PROCESS.T_ETL_PRCD_ELEMENTS_POSITION AS PRCD
        WHERE
            TO_TIME(SRC_FILE_TMSP) BETWEEN '01:00:00' AND '03:30:00'
            AND DATE(DWH_UPDATED_TMSP) - 1 >= CURRENT_DATE() - 14
        GROUP BY
            DATE(DWH_UPDATED_TMSP)
    )
    , ORDER_DELAY_DATA AS (
        SELECT
            ORDER_HEADER.CUST_ORDER_DT
            , ORDER_HEADER.CUST_ORDER_SID
            , ORDER_HEADER.DWH_CREATED_TMSP                                                      AS HEAD_DWH_TMSP
            , ORDER_POSITION.DWH_CREATED_TMSP                                                    AS POS_DWH_TMSP
            , TO_TIMESTAMP_LTZ( CONCAT( ORDER_HEADER.CUST_ORDER_DT + 1, ' 02:00:00' ) )          AS SQL_SCHEDULE_TMSP
            , IFNULL( GREATEST( HEAD_DWH_TMSP, POS_DWH_TMSP ) < SQL_SCHEDULE_TMSP, FALSE )       AS ETL_BEFORE_SQL_FG
        FROM
            ETL_PROCESS.T_ETL_ORDER_HEADER      AS ORDER_HEADER
        LEFT JOIN
            ETL_PROCESS.T_ETL_ORDER_POSITION    AS ORDER_POSITION   
            ON ORDER_HEADER.CUST_ORDER_SID = ORDER_POSITION.CUST_ORDER_SID
        WHERE
            ORDER_HEADER.CUST_ORDER_TYPE_CD IN ( 'ZWSO', 'ZRPL' )
            AND ORDER_HEADER.CUST_ORDER_DT BETWEEN CURRENT_DATE - 14 AND CURRENT_DATE - 1
    )
    , ORDER_DELAY_AGG AS (
        SELECT
            CUST_ORDER_DT
            , COUNT( DISTINCT CUST_ORDER_SID )                                         AS TOTAL_ORDERS_CNT
            , COUNT( DISTINCT IFF( ETL_BEFORE_SQL_FG = FALSE, CUST_ORDER_SID, NULL ) ) AS DELAY_CNT
            , DIV0( DELAY_CNT, TOTAL_ORDERS_CNT )                                      AS DELAY_RATIO
            , ROUND( 100*( DELAY_RATIO ), 2 ) || ' %'                                  AS DELAY_PCT
            , ROUND( 100*( 1 - ( DELAY_RATIO ) ), 2 ) || ' %'                          AS ON_TIME_PCT
        FROM
            ORDER_DELAY_DATA
        GROUP BY
            CUST_ORDER_DT
    )
SELECT
      COGS_AGG.CUST_ORDER_DT
    , COGS_AGG.ORDER_POSITIONS_CNT
    , COGS_AGG.MISSING_COGS_PER_POSITION_CNT
    , COGS_AGG.COGS_AVAILABILITY_PCT
    , PRCD_AGG.PRCD_UPDATED_TMSP
    , PRCD_AGG.ORDER_LINE_SHEDULED_TMSP
    , PRCD_AGG.CHECK_PRCD_IN_TIME
    , ORDER_DELAY_AGG.TOTAL_ORDERS_CNT
    , ORDER_DELAY_AGG.DELAY_CNT
    , ORDER_DELAY_AGG.DELAY_PCT
    , ORDER_DELAY_AGG.ON_TIME_PCT
FROM
    COGS_AGG
FULL OUTER JOIN PRCD_AGG ON COGS_AGG.CUST_ORDER_DT = PRCD_AGG.CUST_ORDER_DT
FULL OUTER JOIN ORDER_DELAY_AGG ON COGS_AGG.CUST_ORDER_DT = ORDER_DELAY_AGG.CUST_ORDER_DT
ORDER BY
    COGS_AGG.CUST_ORDER_DT DESC
;