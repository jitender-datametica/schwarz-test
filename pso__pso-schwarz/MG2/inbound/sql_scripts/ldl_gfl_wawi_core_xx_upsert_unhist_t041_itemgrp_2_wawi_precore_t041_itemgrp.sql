TRUNCATE TABLE ${TARGET_DB}.${TGT_TARGET_TABLE};

INSERT INTO  ${TEMP_DB}.${SRC2TGT_TEMP_TABLE1}_${SRC_CONTEXT_AREA}
(
        CTRCODE,
        EXTRACTION_TMSP,
        ITEMGRPNR,
        STAFFNR,
        PRODGRPNR,
        DESCSHORT,
        DESC,
        SORTINGTERM,
        DIFFRCV,
        MODUSER,
        MODDATE,
        GROUP_ID,
        TEMP_MIN,
        TEMP_MAX,
        RCV_COUNT,
        RCV_DAYS,
        MMO_DELIVERY_TIME,
        TRACEABILITY_LEVEL,
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
       src.C041_ITEMGRPNR,
       src.C041_STAFFNR,
       src.C041_PRODGRPNR,
       src.C041_DESCSHORT,
       src.C041_DESC,
       src.C041_SORTINGTERM,
       src.C041_DIFFRCV,
       src.C041_MODUSER,
       src.C041_MODDATE,
       src.C041_GROUP_ID,
       src.C041_TEMP_MIN,
       src.C041_TEMP_MAX,
       src.C041_RCV_COUNT,
       src.C041_RCV_DAYS,
       src.C041_MMO_DELIVERY_TIME,
       src.C041_TRACEABILITY_LEVEL,
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
INNER JOIN ( SELECT   CTRCODE
                    , Rank() OVER (ORDER BY CASE WHEN CTRCODE = 'DE' THEN 1
                                                 WHEN CTRCODE NOT IN ('BG', 'CY', 'GR') THEN 2
                                                 WHEN CTRCODE = 'GR' THEN 3
                                                 WHEN CTRCODE IN ('BG', 'CY') THEN 4
                                             END, CTRCODE) AS eks_rank
                FROM ( SELECT DISTINCT CTRCODE
                         FROM ${TEMP_DB}.${SRC_INPUT_TABLE}) AS a
            ) AS csrc
        ON  src.CTRCODE = csrc.CTRCODE
    QUALIFY csrc.eks_rank = Min(csrc.eks_rank) OVER (PARTITION BY LEFT( src.CTRCODE, 2), src.C041_ITEMGRPNR, src.c041_PRODGRPNR)
    AND Row_Number() OVER (PARTITION BY LEFT( src.CTRCODE, 2), src.C041_ITEMGRPNR, src.c041_PRODGRPNR ORDER BY src.EXTRACTION_TMSP DESC) = 1
;
