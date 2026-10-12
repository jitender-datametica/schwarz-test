TRUNCATE TABLE ${TARGET_DB}.${TGT_TARGET_TABLE};

INSERT INTO  ${TEMP_DB}.${SRC2TGT_TEMP_TABLE1}_${SRC_CONTEXT_AREA}
(
      CTRCODE
    , WH_NR
    , C170_GATETYPEID
    , C170_GATETYPE
    , C170_SHOW_PALLETS
    , C170_CHECK_TEMP
    , C170_MULT_BB_DATE
    , C170_MULT_PAL_FACT
    , C170_DEF_TASK_TYPE
    , C170_RCV_LANE
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
      LEFT( src.CTRCODE, 2) as CTRCODE
    , WH_NR
    , C170_GATETYPEID
    , C170_GATETYPE
    , C170_SHOW_PALLETS
    , C170_CHECK_TEMP
    , C170_MULT_BB_DATE
    , C170_MULT_PAL_FACT
    , C170_DEF_TASK_TYPE
    , C170_RCV_LANE
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
    , 'WAWI_HQ'                          AS DWH_NODE_CD
    , '${LOAD_ID}'                       AS DWH_LOAD_ID
FROM ${TEMP_DB}.${SRC_INPUT_TABLE} src
INNER JOIN ETL.WAWI_CONTROL_TABLE_1 ctrl
ON true
AND ctrl.SOURCE_TABLE_NAME = UPPER('${TEMP_DB}.${SRC_INPUT_TABLE}')
AND ctrl.SOURCE_STATUS = 'A'
AND src.EXTRACTION_TMSP between ctrl.BEGIN_TMSP and ctrl.END_TMSP
QUALIFY Row_Number() OVER 
(PARTITION BY 
    LEFT( src.CTRCODE, 2), 
    C170_GATETYPEID 
 ORDER BY src.EXTRACTION_TMSP DESC
) = 1 
;
