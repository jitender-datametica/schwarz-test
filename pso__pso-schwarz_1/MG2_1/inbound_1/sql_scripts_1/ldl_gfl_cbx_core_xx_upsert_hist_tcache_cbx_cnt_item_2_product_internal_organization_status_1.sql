INSERT INTO  ${TEMP_DB}.${SRC2TGT_TEMP_TABLE1}_${SRC_CONTEXT_AREA}
(
      CTRCODE
    , INT_ORG_KEY_TYPE_CD

    , PROD_NR
    , PROD_KEY_TYPE_CD
    
    , PROD_STATUS_TYPE_CD  
    , PROD_STATUS_CATEG_CD 

      -- FRAMEWORK AND TECHNICAL COLUMNS
    , SOURCE_SYSTEM
    , EXTRACTION_DT
    , DWH_MAPPING_TMSP
    , TF_ERROR_FG
    , DELETED_FG
    , RECORD_ID
    , FILENAME
    , DWH_NODE_CD
    , DWH_LOAD_ID
)
SELECT DISTINCT 
    
      1                        AS CTRCODE
    , 'TRUST'                  AS INT_ORG_KEY_TYPE_CD
      
    , SRC.item_no              AS PROD_NR
    , 'CBX'               AS PROD_KEY_TYPE_CD
    
    , ldl_country_order_status AS PROD_STATUS_TYPE_CD  
    , 'CBX_BUYING'             AS PROD_STATUS_CATEG_CD 

    , 'CBX'                    AS SOURCE_SYSTEM
    , CURRENT_DATE             AS EXTRACTION_DT
    , SRC.updated_on           AS DWH_MAPPING_TMSP
    , 0                        AS TF_ERROR_FG
    , 0                        AS DELETED_FG
    , 0                        AS RECORD_ID
    , 't_${SRC_INPUT_TABLE}'   AS FILENAME
    , 'CBX'                    AS DWH_NODE_CD
    , '${LOAD_ID}'             AS DWH_LOAD_ID 
FROM ${TEMP_DB}.t_${SRC_INPUT_TABLE} SRC
WHERE SRC.item_no != '0'
QUALIFY ROW_NUMBER() OVER (PARTITION BY SRC.item_no, SRC.ldl_country_order_status ORDER BY SRC.updated_on DESC) = 1  -- <<<  verify dedup logic interpretation
UNION ALL
SELECT DISTINCT 
    
      1                        AS CTRCODE
    , 'TRUST'                  AS INT_ORG_KEY_TYPE_CD

    , SRC.item_no              AS PROD_NR
    , 'CBX'               AS PROD_KEY_TYPE_CD

    , SRC.status_1 || 1          AS PROD_STATUS_TYPE_CD  
    , 'CBX_WORKFLOW'           AS PROD_STATUS_CATEG_CD 
            
    , 'CBX'                    AS SOURCE_SYSTEM
    , CURRENT_DATE             AS EXTRACTION_DT
    , SRC.updated_on           AS DWH_MAPPING_TMSP
    , 0                        AS TF_ERROR_FG
    , 0                        AS DELETED_FG
    , 0                        AS RECORD_ID
    , 't_${SRC_INPUT_TABLE}'   AS FILENAME
    , 'CBX'                    AS DWH_NODE_CD
    , '${LOAD_ID}'             AS DWH_LOAD_ID 
FROM ${TEMP_DB}.t_${SRC_INPUT_TABLE} SRC
WHERE SRC.item_no != '0'
QUALIFY ROW_NUMBER() OVER (PARTITION BY SRC.item_no, SRC.status_1 ORDER BY SRC.updated_on DESC) = 1  -- <<<  verify dedup logic interpretation
;
