TRUNCATE TABLE ETL.T_WAWI_PRECORE_T007_DESCRIPTIONS_1;

INSERT INTO  ${TEMP_DB}.${SRC2TGT_TEMP_TABLE1}_${SRC_CONTEXT_AREA}
(
        CTRCODE,
        EXTRACTION_TMSP,
        ID,
        TYPE_,
        CODE,
        DESC,
        READONLY,
        MODUSER,
        MODDATE,
        EKS_LINK,
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
       src.C007_ID,
       src.C007_TYPE,
       src.C007_CODE,
       src.C007_DESC,
       src.C007_READONLY,
       src.C007_MODUSER,
       src.C007_MODDATE,
       src.C007_EKS_LINK,
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
INNER JOIN ETL.WAWI_CONTROL_TABLE_1 ctrl
 ON TRUE
AND ctrl.SOURCE_TABLE_NAME = UPPER('${TEMP_DB}.${SRC_INPUT_TABLE}')
AND ctrl.SOURCE_STATUS = 'A'
AND src.EXTRACTION_TMSP between ctrl.BEGIN_TMSP and ctrl.END_TMSP
QUALIFY Row_Number() OVER
(PARTITION BY
    LEFT( src.CTRCODE, 2), 
    src.C007_TYPE, 
    src.C007_CODE
 ORDER BY src.EXTRACTION_TMSP DESC
) = 1
;
