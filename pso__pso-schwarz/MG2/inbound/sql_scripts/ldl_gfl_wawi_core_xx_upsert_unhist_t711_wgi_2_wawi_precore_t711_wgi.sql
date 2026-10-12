TRUNCATE TABLE ${TARGET_DB}.${TGT_TARGET_TABLE};

INSERT INTO  ${TEMP_DB}.${SRC2TGT_TEMP_TABLE1}_${SRC_CONTEXT_AREA}
(
        CTRCODE,
        EXTRACTION_TMSP,
        WGI_ID,
        NAT_WGI_ID,
        ITEM_GROUP,
        DATE_FROM,
        DATE_TO,
        VERSION,
        INT_DESC,
        NAT_DESC,
        REMARKS,
        MODUSER,
        MODDATE,
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
       src.C711_WGI_ID,
       src.C711_NAT_WGI_ID,
       src.C711_ITEM_GROUP,
       src.C711_DATE_FROM,
       src.C711_DATE_TO,
       src.C711_VERSION,
       src.C711_INT_DESC,
       src.C711_NAT_DESC,
       src.C711_REMARKS,
       src.C711_MODUSER,
       src.C711_MODDATE,
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
 INNER JOIN ( SELECT CTRCODE
                    , Rank() OVER (ORDER BY CASE WHEN CTRCODE = 'DE' THEN 1
                                                 WHEN CTRCODE NOT IN ('BG', 'CY', 'GR') THEN 2
                                                 WHEN CTRCODE = 'GR' THEN 3
                                                 WHEN CTRCODE IN ('BG', 'CY') THEN 4
                                             END, CTRCODE) AS eks_rank
                FROM ( SELECT DISTINCT CTRCODE
                         FROM ${TEMP_DB}.${SRC_INPUT_TABLE}) AS a
            ) AS csrc
        ON  src.CTRCODE = csrc.CTRCODE
    QUALIFY csrc.eks_rank = Min(csrc.eks_rank) OVER (PARTITION BY src.C711_WGI_ID, src.C711_NAT_WGI_ID, src.C711_ITEM_GROUP)
    AND Row_Number() OVER (PARTITION BY src.C711_WGI_ID, src.C711_NAT_WGI_ID, src.C711_ITEM_GROUP, src.C711_DATE_FROM, src.CTRCODE ORDER BY src.EXTRACTION_TMSP DESC) = 1
;
