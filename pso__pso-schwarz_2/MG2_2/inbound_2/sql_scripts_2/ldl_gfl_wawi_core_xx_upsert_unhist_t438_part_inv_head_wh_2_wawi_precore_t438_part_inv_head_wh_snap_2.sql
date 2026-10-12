INSERT INTO  ${TEMP_DB}.${SRC2TGT_TEMP_TABLE1}_${SRC_CONTEXT_AREA}
(
      CTRCODE
    , WH_NR
    , C438_INV_ID
    , C438_LIST_ID
    , C438_SIC_ID
    , C438_INVENTORYDATE
    , C438_STORENR
    , C438_STATUS
    , C438_INV_TYPE
    , C438_SENT
    , C438_DIFFVALUE
    , C438_TURNOVER
    , C438_RESULT
    , C438_COLOR
    , C438_PERIOD_COLOR
    , C438_STOCK_CALC_DATE
    , C438_MODUSER
    , C438_MODDATE
    , C438_PERIOD_DIFFVALUE
    , C438_PERIOD_TURNOVER
    , C438_PERIOD_RANGE_RED
    , C438_PERIOD_RANGE_YELLOW
    , C438_POSCOUNT
    , C438_WHNR
    , SCN
    , EXTRACTION_TMSP

    --------------------------------
    , SOURCE_SYSTEM
    , EXTRACTION_DT
    , DWH_MAPPING_TMSP
    , TF_ERROR_FG
    , DELETED_FG
    , RECORD_ID
    , FILENAME
    , DWH_NODE_CD
    , DWH_LOAD_ID
)
SELECT 
      case 
          when ctrcode = 'CS' then 'ES'
          when ctrcode = 'NIE' then 'NI'
          else ctrcode
      end as ctrcode_converted
    , WH_NR
    , C438_INV_ID
    , C438_LIST_ID
    , C438_SIC_ID
    , C438_INVENTORYDATE
    , C438_STORENR
    , C438_STATUS
    , C438_INV_TYPE
    , C438_SENT
    , C438_DIFFVALUE
    , C438_TURNOVER
    , C438_RESULT
    , C438_COLOR
    , C438_PERIOD_COLOR
    , C438_STOCK_CALC_DATE
    , C438_MODUSER
    , C438_MODDATE
    , C438_PERIOD_DIFFVALUE
    , C438_PERIOD_TURNOVER
    , C438_PERIOD_RANGE_RED
    , C438_PERIOD_RANGE_YELLOW
    , C438_POSCOUNT
    , C438_WHNR
    , SCN
    , EXTRACTION_TMSP

    --------------------------------
    , 'WAWI'                             AS SOURCE_SYSTEM
    , CURRENT_DATE                       AS EXTRACTION_DT
    , current_timestamp                  AS DWH_MAPPING_TMSP
    , 0                                  AS TF_ERROR_FG
    , 0                                  AS DELETED_FG
    , 0                                  AS RECORD_ID
    , '${SRC_INPUT_TABLE}'               AS FILENAME
    , 'WAWI_WH'                          AS DWH_NODE_CD
    , '${LOAD_ID}'                       AS DWH_LOAD_ID
FROM ${TEMP_DB}.${SRC_INPUT_TABLE} src
INNER JOIN ETL.WAWI_CONTROL_TABLE_2 ctrl
ON true
AND ctrl.SOURCE_TABLE_NAME = UPPER('${TEMP_DB}.${SRC_INPUT_TABLE}')
AND ctrl.SOURCE_STATUS = 'A'
AND src.EXTRACTION_TMSP between ctrl.BEGIN_TMSP and ctrl.END_TMSP
QUALIFY Row_Number() OVER 
(PARTITION BY 
    ctrcode_converted, 
    WH_NR,
    C438_INV_ID
 ORDER BY src.EXTRACTION_TMSP DESC
) = 1 
;
