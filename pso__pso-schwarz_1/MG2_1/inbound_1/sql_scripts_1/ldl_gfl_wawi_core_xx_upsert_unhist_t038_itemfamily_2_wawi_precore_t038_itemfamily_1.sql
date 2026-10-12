TRUNCATE TABLE ${TARGET_DB}.${TGT_TARGET_TABLE};

INSERT INTO  ${TEMP_DB}.${SRC2TGT_TEMP_TABLE1}_${SRC_CONTEXT_AREA}
(
        CTRCODE,
        EXTRACTION_TMSP,
        FAMILY_ID,
        ITEMGRPNR,
        PRODGRPNR,
        FAMILY_CODE,
        DESC_LONG,
        DESC_SHORT,
        MOD_DATE,
        MOD_USER,
        MMO_CALCULATION_FLAG,
        PST_PRINT_FLAG,
        MMO_MODIFY_FLAG,
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
       src.C038_FAMILY_ID,
       src.C038_ITEMGRPNR,
       src.C038_PRODGRPNR,
       src.C038_FAMILY_CODE,
       src.C038_DESC_LONG,
       src.C038_DESC_SHORT,
       src.C038_MOD_DATE,
       src.C038_MOD_USER,
       src.C038_MMO_CALCULATION_FLAG,
       src.C038_PST_PRINT_FLAG,
       src.C038_MMO_MODIFY_FLAG,
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
    QUALIFY csrc.eks_rank = Min(csrc.eks_rank) OVER (PARTITION BY LEFT( src.CTRCODE, 2), src.C038_FAMILY_ID)
    AND Row_Number() OVER (PARTITION BY LEFT( src.CTRCODE, 2), src.C038_FAMILY_ID ORDER BY src.EXTRACTION_TMSP DESC) = 1
;
