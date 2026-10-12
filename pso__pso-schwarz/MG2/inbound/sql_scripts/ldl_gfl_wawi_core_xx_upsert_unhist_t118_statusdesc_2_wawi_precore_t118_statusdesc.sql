TRUNCATE TABLE ${TARGET_DB}.${TGT_TARGET_TABLE};

INSERT INTO  ${TEMP_DB}.${SRC2TGT_TEMP_TABLE1}_${SRC_CONTEXT_AREA}
(
        CTRCODE,
        EXTRACTION_TMSP,
        STATUS,
        STATUSDESC,
        HQ,
        WH,
        SCN,
        --
        SOURCE_SYSTEM,
        EXTRACTION_DT,
        DWH_MAPPING_TMSP,
        TF_ERROR_FG,
        DELETED_FG,
        RECORD_ID,
        FILENAME,
        DWH_NODE_CD,
        DWH_LOAD_ID
)
SELECT LEFT( src.CTRCODE, 2) as CTRCODE,
       src.EXTRACTION_TMSP,
       src.C118_STATUS,
       src.C118_STATUSDESC,
       src.C118_HQ,
       src.C118_WH,
       src.SCN,
       --
       'WAWI' AS SOURCE_SYSTEM,
       CURRENT_DATE AS EXTRACTION_DT,
       current_timestamp AS DWH_MAPPING_TMSP,
       0 AS TF_ERROR_FG,
       0 AS DELETED_FG,
       0 AS RECORD_ID,
       '${SRC_INPUT_TABLE}' AS FILENAME,
       'WAWI' AS DWH_NODE_CD,
       '${LOAD_ID}' as DWH_LOAD_ID
  FROM ${TEMP_DB}.${SRC_INPUT_TABLE} SRC
 INNER JOIN ETL.WAWI_CONTROL_TABLE ctrl
        ON ctrl.SOURCE_TABLE_NAME = UPPER('${TEMP_DB}.${SRC_INPUT_TABLE}')
       AND ctrl.SOURCE_STATUS = 'A'
       AND src.EXTRACTION_TMSP between ctrl.BEGIN_TMSP and ctrl.END_TMSP
QUALIFY Row_Number() OVER
(PARTITION BY
    LEFT( src.CTRCODE, 2),
    src.C118_STATUS
 ORDER BY src.EXTRACTION_TMSP DESC
) = 1
;
