TRUNCATE TABLE ${TARGET_DB}.${TGT_TARGET_TABLE};

INSERT INTO  ${TEMP_DB}.${SRC2TGT_TEMP_TABLE1}_${SRC_CONTEXT_AREA}
(
      CTRCODE
    , WH_NR
    , C439_INV_ID
    , C439_ITEMNR
    , C439_ITEMDESC
    , C439_CALC_STOCK
    , C439_COUNT_STOCK
    , C439_PLAUS_STOCK
    , C439_RETAIL_PRICE
    , C439_TURNOVER
    , C439_DECIMALCASE
    , C439_COUNTFLAG
    , C439_MODUSER
    , C439_MODDATE
    , C439_NOTE
    , C439_LAST_DIFF
    , C439_ITEMGROUP
    , C439_WHNR
    , C439_ADD_REASON
    , SCN
    , C439_ORDER_1
    , C439_ORDER_2
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
    , C439_INV_ID
    , C439_ITEMNR
    , C439_ITEMDESC
    , C439_CALC_STOCK
    , C439_COUNT_STOCK
    , C439_PLAUS_STOCK
    , C439_RETAIL_PRICE
    , C439_TURNOVER
    , C439_DECIMALCASE
    , C439_COUNTFLAG
    , C439_MODUSER
    , C439_MODDATE
    , C439_NOTE
    , C439_LAST_DIFF
    , C439_ITEMGROUP
    , C439_WHNR
    , C439_ADD_REASON
    , SCN
    , C439_ORDER_1
    , C439_ORDER_2
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
INNER JOIN ETL.WAWI_CONTROL_TABLE_1 ctrl
ON true
AND ctrl.SOURCE_TABLE_NAME = UPPER('${TEMP_DB}.${SRC_INPUT_TABLE}')
AND ctrl.SOURCE_STATUS = 'A'
AND src.EXTRACTION_TMSP between ctrl.BEGIN_TMSP and ctrl.END_TMSP
QUALIFY Row_Number() OVER 
(PARTITION BY 
    ctrcode_converted, 
    WH_NR,
    C439_INV_ID,
    C439_ITEMNR
 ORDER BY src.EXTRACTION_TMSP DESC
) = 1 
;
