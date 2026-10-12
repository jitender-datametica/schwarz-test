INSERT INTO  ${TEMP_DB}.${SRC2TGT_TEMP_TABLE1}_${SRC_CONTEXT_AREA}
(
        INT_COMPANY_NATURAL_KEY,
        INT_COMPANY_KEY_TYPE_CD,
        STAT_TYPE_CD,
        STAT_DT,
        CAL_MONTH,
        CURR_STAT_FG ,
        STAT_VAL,
        CURR_CD ,
        STAT_CNT,
        STAT_QTY,
        STAT_MEAS,
        UOM_CD,    
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
        UPPER(SUBSTR(VLXMLCNTR, 1, 2)) ||'|'||UPPER(SUBSTR(GXXMLKLAG,1,3)) AS INT_COMPANY_NATURAL_KEY,
        'COMPANY' as INT_COMPANY_KEY_TYPE_CD,
        '248' as stat_type_cd,
        SRC.EXTRACTION_DATE as STAT_DT,--?
        SRC.calmonth ,
        1 as CURR_STAT_FG,
        NULL as stat_val,
        NULL as CURR_CD,
        NULl as STAT_CNT,
        NULL as STAT_QTY,
        SRC.IST as STAT_MEAS,
        UNIT as UOM_CD,
        SRC.EXTRACTION_DATE as EXTRACTION_DT,        
        CURRENT_TIMESTAMP              AS  DWH_MAPPING_TMSP,
        0                              AS  TF_ERROR_FG,
        0                              AS  DELETED_FG,
        0                              AS  RECORD_ID,
        't_${SRC_INPUT_TABLE}'          AS  FILENAME,
        'SAP_HANA'                     AS  DWH_NODE_CD,
       '${LOAD_ID}' as DWH_LOAD_ID 
FROM ${TEMP_DB}.t_${SRC_INPUT_TABLE} SRC

;

