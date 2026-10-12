INSERT INTO  ${TEMP_DB}.${SRC2TGT_TEMP_TABLE1}_${SRC_CONTEXT_AREA}
(
        PROD_GRP_TYPE_CD,
        PROD_GRP_NR,
        PARENT_PROD_GRP_TYPE_CD,
        PARENT_PROD_GRP_NR,
        PROD_GRP_HIERARCHY_TYPE_CD,
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
        'SIG' as PROD_GRP_TYPE_CD,
        UPPER(src.ITEM_GROUP) AS PROD_GRP_NR,
        'IGI' as PARENT_PROD_GRP_TYPE_CD,
        UPPER(src.WGI_ID) AS PARENT_PROD_GRP_NR,
        'IGH' as PROD_GRP_HIERARCHY_TYPE_CD,
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
    AND Row_Number() OVER (PARTITION BY src.WGI_ID, src.ITEM_GROUP, src.CTRCODE ORDER BY src.EXTRACTION_TMSP DESC) = 1
;
