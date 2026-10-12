TRUNCATE TABLE ${TARGET_DB}.${TGT_TARGET_TABLE};

INSERT INTO  ${TEMP_DB}.${SRC2TGT_TEMP_TABLE1}_${SRC_CONTEXT_AREA}
(
        CTRCODE,
        EXTRACTION_TMSP,
        ITEMNO,
        UN_NO,
        UN_DESC,
        DANG_SLIP,
        LQ_GRP,
        TRANS_CAT,
        GROSS_WGHT,
        PACK_GRP,
        FACTOR,
        TUNNELCODE,
        UN_DESC_DE,
        LIMIT_LQ_QTY,
        LQ_GRP_FLAG,
        ENV_HAZ_FLAG,
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
       src.C220_ITEMNO,
       src.C220_UN_NO,
       src.C220_UN_DESC,
       src.C220_DANG_SLIP,
       src.C220_LQ_GRP,
       src.C220_TRANS_CAT,
       src.C220_GROSS_WGHT,
       src.C220_PACK_GRP,
       src.C220_FACTOR,
       src.C220_TUNNELCODE,
       src.C220_UN_DESC_DE,
       src.C220_LIMIT_LQ_QTY,
       src.C220_LQ_GRP_FLAG,
       src.C220_ENV_HAZ_FLAG,
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
    src.C220_ITEMNO
 ORDER BY src.EXTRACTION_TMSP DESC
) = 1
;
