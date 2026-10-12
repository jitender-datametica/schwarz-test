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
        'MP' as PROD_GRP_KEY_TYPE_CD,
        CASE WHEN src.product_category_value = 'Hartware' THEN 'HG' 
             WHEN src.product_category_value = 'Textil'   THEN 'TX'
             ELSE '@'
        END AS PROD_GRP_KEY_NR,
        'MP' as PROD_GRP_TYPE_CD,
        CASE WHEN src.product_category_value = 'Hartware' THEN 'HG' 
             WHEN src.product_category_value = 'Textil'   THEN 'TX'
             ELSE '@'
        END AS PROD_GRP_NR,
        COALESCE(src.product_category_value ,'@') AS PROD_GRP_NAME,
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
QUALIFY Row_Number() OVER (PARTITION BY CASE WHEN src.product_category_value = 'Hartware' THEN 'HG' 
                                             WHEN src.product_category_value = 'Textil'   THEN 'TX'
                                             ELSE '@'
                                        END ORDER BY src.updated_on DESC) = 1
UNION ALL
SELECT DISTINCT
        'P' AS PROD_GRP_KEY_TYPE_CD,
        UPPER(src.ldl_pillar) AS PROD_GRP_KEY_NR,
        'P' AS PROD_GRP_TYPE_CD,
        UPPER(src.ldl_pillar) AS PROD_GRP_NR,
        src.ldl_pillar AS PROD_GRP_NAME,
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
   AND src.ldl_pillar IS NOT NULL
QUALIFY Row_Number() OVER (PARTITION BY UPPER(src.ldl_pillar) ORDER BY src.updated_on DESC) = 1
;
