INSERT INTO  ${TEMP_DB}.${SRC2TGT_TEMP_TABLE1}_${SRC_CONTEXT_AREA}
(
        PROD_GRP_KEY_TYPE_CD,
        PROD_GRP_KEY_NR,
        PROD_GRP_TYPE_CD,
        PROD_GRP_NR,
        PROD_GRP_NAME,
        -- FRAMEWORK AND TECHNICAL COLUMNS
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
SELECT DISTINCT
        'IGI' as PROD_GRP_KEY_TYPE_CD,
        src.WGI_ID AS PROD_GRP_KEY_NR,
        'IGI' as PROD_GRP_TYPE_CD,
        src.WGI_ID AS PROD_GRP_NR,
        src.INT_DESC AS PROD_GRP_NAME,
        'WAWI' AS SOURCE_SYSTEM,
        CURRENT_DATE AS EXTRACTION_DT,
        src.MODDATE AS DWH_MAPPING_TMSP,
        0 AS TF_ERROR_FG,
        0 AS DELETED_FG,
        0 AS RECORD_ID,
        't_${SRC_INPUT_TABLE}' AS FILENAME,
        'WAWI_HQ' AS DWH_NODE_CD,
        '${LOAD_ID}' as DWH_LOAD_ID
  FROM ${TEMP_DB}.t_${SRC_INPUT_TABLE} SRC
 INNER JOIN ( SELECT CTRCODE
                    , Rank() OVER (ORDER BY CASE WHEN CTRCODE = 'DE' THEN 1
                                                 WHEN CTRCODE NOT IN ('BG', 'CY', 'GR') THEN 2
                                                 WHEN CTRCODE = 'GR' THEN 3
                                                 WHEN CTRCODE IN ('BG', 'CY') THEN 4
                                             END, CTRCODE) AS eks_rank
                FROM ( SELECT DISTINCT CTRCODE
                         FROM ${TEMP_DB}.t_${SRC_INPUT_TABLE}) AS a
            ) AS csrc
        ON  src.CTRCODE = csrc.CTRCODE
    QUALIFY csrc.eks_rank = Min(csrc.eks_rank) OVER (PARTITION BY src.WGI_ID)
    AND Row_Number() OVER (PARTITION BY src.WGI_ID, src.CTRCODE ORDER BY src.EXTRACTION_TMSP DESC) = 1
;
