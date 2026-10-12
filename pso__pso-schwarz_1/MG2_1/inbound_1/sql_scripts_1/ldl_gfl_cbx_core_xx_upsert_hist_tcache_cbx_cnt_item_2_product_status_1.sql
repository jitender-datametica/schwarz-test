INSERT INTO  ${TEMP_DB}.${SRC2TGT_TEMP_TABLE1}_${SRC_CONTEXT_AREA}
(
        PROD_KEY_TYPE_CD,
        PROD_NR,
        PROD_STATUS_CATEG_CD,
        PROD_STATUS_TYPE_CD,
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
        'CBX' as PROD_KEY_TYPE_CD,
        src.item_no AS PROD_NR,
        'CBX_WORKFLOW' AS PROD_STATUS_CATEG_CD,
        src.status_1 AS PROD_STATUS_TYPE_CD,
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
WHERE src.item_no <> '0'
UNION ALL
SELECT DISTINCT
        'CBX' as PROD_KEY_TYPE_CD,
        src.item_no AS PROD_NR,
        'CBX_BUYING' AS PROD_STATUS_CATEG_CD,
        src.ldl_country_order_status AS PROD_STATUS_TYPE_CD,
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
WHERE src.item_no <> '0'
QUALIFY Row_Number() OVER (PARTITION BY src.item_no, src.status_1 ORDER BY src.updated_on DESC) = 1
;
