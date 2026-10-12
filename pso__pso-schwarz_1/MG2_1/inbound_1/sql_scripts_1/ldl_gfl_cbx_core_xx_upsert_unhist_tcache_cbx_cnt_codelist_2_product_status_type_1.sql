INSERT INTO  ${TEMP_DB}.${SRC2TGT_TEMP_TABLE1}_${SRC_CONTEXT_AREA}
(
        PROD_STATUS_CATEG_CD,
        PROD_STATUS_TYPE_CD,
        LANG_CD,
        PROD_STATUS_TYPE_DESCR,
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
SELECT distinct 
       'CBX_BUYING'                     AS PROD_STATUS_CATEG_CD
     , cl.code                          AS PROD_STATUS_TYPE_CD
     , 'DE'                             AS LANG_CD
     , clb.cust_text1 || '-'|| cl.name  AS PROD_STATUS_TYPE_DESCR
     , 'CBX'                            AS SOURCE_SYSTEM
     , CURRENT_DATE                     AS EXTRACTION_DT
     , current_timestamp                AS DWH_MAPPING_TMSP
     , 0                                AS TF_ERROR_FG
     , 0                                AS DELETED_FG
     , 0                                AS RECORD_ID
     , 't_${SRC_INPUT_TABLE}'           AS FILENAME
     , 'CBX_BUY_STATUS'                 AS DWH_NODE_CD
     , '${LOAD_ID}'                     AS DWH_LOAD_ID 
FROM      ${TEMP_DB}.t_${SRC_INPUT_TABLE} cl
LEFT JOIN etl.t_tcache_cbx_ctm_codelist_book_1 clb ON cl.id = clb.id
WHERE TRUE
AND clb.cust_text1 IS NOT NULL
AND cl.code IS NOT NULL
AND cl.name ='LIDL_CO_STATUS'
;
