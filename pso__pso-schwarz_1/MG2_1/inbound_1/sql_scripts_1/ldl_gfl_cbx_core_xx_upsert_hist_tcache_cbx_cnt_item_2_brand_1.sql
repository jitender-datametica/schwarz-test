INSERT INTO  ${TEMP_DB}.${SRC2TGT_TEMP_TABLE1}_${SRC_CONTEXT_AREA}
(
        BRAND_NAME,
	--    BRAND_TYPE_CD,
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
SELECT 
        DISTINCT UPPER(ldl_brand_name) as BRAND_NAME
    -- , ldl_brand_type as BRAND_TYPE_CD
     , 'CBX' AS SOURCE_SYSTEM
     , CURRENT_DATE AS EXTRACTION_DT
     , current_timestamp AS DWH_MAPPING_TMSP
     , 0 AS TF_ERROR_FG
     , 0 AS DELETED_FG
     ,  0 AS RECORD_ID
     , 't_${SRC_INPUT_TABLE}' AS FILENAME
     , 'CBX' AS DWH_NODE_CD
     , '${LOAD_ID}' as DWH_LOAD_ID 
  FROM ${TEMP_DB}.t_${SRC_INPUT_TABLE} SRC
 WHERE item_no != '0' 
   AND ldl_brand is not null
;
