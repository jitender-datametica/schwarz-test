INSERT INTO  ${TEMP_DB}.${SRC2TGT_TEMP_TABLE1}_${SRC_CONTEXT_AREA}
(
        PROD_KEY_TYPE_CD,
        PROD_NR,
        PROD_GRP_KEY_TYPE_CD,
        PROD_GRP_NR,
        PROD_GRP_TYPE_CD,
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
SELECT  --CBX_P
        'CBX' AS PROD_KEY_TYPE_CD,
        src.item_no AS PROD_NR,
        'P' AS PROD_GRP_KEY_TYPE_CD,
        COALESCE (src.ldl_pillar, '@') AS PROD_GRP_NR,
        'P' AS PROD_GRP_TYPE_CD,
        -- FRAMEWORK AND TECHNICAL COLUMNS
        'CBX' AS SOURCE_SYSTEM,
        CURRENT_DATE AS EXTRACTION_DT,
        src.updated_on AS DWH_MAPPING_TMSP,
        0 AS TF_ERROR_FG,
        0 AS DELETED_FG,
        0 AS RECORD_ID,
        't_${SRC_INPUT_TABLE}' AS FILENAME,
        'CBX' AS DWH_NODE_CD,
        '${LOAD_ID}' as DWH_LOAD_ID
  FROM ${TEMP_DB}.t_${SRC_INPUT_TABLE} SRC
 WHERE src.item_no != '0'
QUALIFY Row_Number() OVER (PARTITION BY src.item_no,PROD_GRP_NR ORDER BY src.updated_on DESC) = 1

UNION 

SELECT  --CBX_IFG
        'CBX' AS PROD_KEY_TYPE_CD,
        src.item_no AS PROD_NR,
        'IFG' AS PROD_GRP_KEY_TYPE_CD,
        LTRIM(SPLIT(src.ldl_article_group, '_')[0], '0') ||'|'|| LTRIM (SPLIT(src.ldl_article_group, '_')[1], '0') AS PROD_GRP_NR,
        'IFG' AS PROD_GRP_TYPE_CD,
        -- FRAMEWORK AND TECHNICAL COLUMNS
        'CBX' AS SOURCE_SYSTEM,
        CURRENT_DATE AS EXTRACTION_DT,
        src.updated_on AS DWH_MAPPING_TMSP,
        0 AS TF_ERROR_FG,
        0 AS DELETED_FG,
        0 AS RECORD_ID,
        't_${SRC_INPUT_TABLE}' AS FILENAME,
        'CBX' AS DWH_NODE_CD,
        '${LOAD_ID}' as DWH_LOAD_ID
  FROM ${TEMP_DB}.t_${SRC_INPUT_TABLE} SRC
 WHERE src.item_no != '0'
   AND src.ldl_article_group IS NOT NULL
QUALIFY Row_Number() OVER (PARTITION BY src.item_no,PROD_GRP_NR ORDER BY src.updated_on DESC) = 1
;
