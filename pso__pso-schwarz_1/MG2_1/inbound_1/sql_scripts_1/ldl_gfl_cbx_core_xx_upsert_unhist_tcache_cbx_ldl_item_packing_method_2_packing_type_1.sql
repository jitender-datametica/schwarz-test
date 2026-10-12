INSERT INTO  ${TEMP_DB}.${SRC2TGT_TEMP_TABLE1}_${SRC_CONTEXT_AREA}
(
        PACKING_TYPE_CD,
        LANG_CD,
        PACKING_TYPE_NAME,
        PACKING_TYPE_DESCR,
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
       src.ldl_code                     AS PACKING_TYPE_CD
     , 'DE'                             AS LANG_CD
     , TRIM(SUBSTRING (src.ldl_name,0,14)) ||'-'|| SUBSTRING(TRIM(src.ldl_code),7,7) AS PACKING_TYPE_NAME
     , TRIM(SUBSTRING (src.ldl_name,0,14)) ||'-'|| SUBSTRING(TRIM(src.ldl_code),7,7) AS PACKING_TYPE_DESCR
     , 'CBX'                            AS SOURCE_SYSTEM
     , CURRENT_DATE                     AS EXTRACTION_DT
     , CURRENT_TIMESTAMP                AS DWH_MAPPING_TMSP
     , 0                                AS TF_ERROR_FG
     , 0                                AS DELETED_FG
     , 0                                AS RECORD_ID
     , 't_${SRC_INPUT_TABLE}'           AS FILENAME
     , 'CBX'                            AS DWH_NODE_CD
     , '${LOAD_ID}'                     AS DWH_LOAD_ID
FROM ${TEMP_DB}.t_${SRC_INPUT_TABLE} AS SRC
WHERE src.ldl_name like 'Packing Method%'
;
