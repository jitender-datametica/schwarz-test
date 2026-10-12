INSERT INTO  ${TEMP_DB}.${SRC2TGT_TEMP_TABLE1}_${SRC_CONTEXT_AREA}
(
        INT_ORG_NATURAL_KEY ,
        INT_ORG_KEY_TYPE_CD,
        INT_ORG_TYPE_CD ,
        REAL_ESTATE_NATURAL_KEY ,
        REAL_ESTATE_KEY_TYPE_CD ,
        cal_month,
        PLANNED_VAL_TYPE_NATURAL_KEY,
        PLANNED_VAL_TYPE_KEY_TYPE_CD,
        plan_pos_nr,
        planned_kpi_meas,
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
        UPPER(SUBSTR(VLXMLCNTR, 1, 2)) ||'|'||UPPER(SUBSTR(GXXMLKLAG,1,3)) AS INT_ORG_NATURAL_KEY,
        'COMPANY' as INT_ORG_KEY_TYPE_CD,
        'COMPANY' as INT_ORG_TYPE_CD ,
        'DUMMY|DUMMY' REAL_ESTATE_NATURAL_KEY,
        'DUMMY' REAL_ESTATE_KEY_TYPE_CD,
        SRC.calmonth ,
        '248|WH_DLV' as PLANNED_VAL_TYPE_NATURAL_KEY,
        'PVAL' as PLANNED_VAL_TYPE_KEY_TYPE_CD,
        '' as plan_pos_nr,
        SRC.plan as planned_kpi_meas,
        SRC.EXTRACTION_DATE as EXTRACTION_DT,        
        CURRENT_TIMESTAMP              AS  DWH_MAPPING_TMSP,
        0                              AS  TF_ERROR_FG,
        0                              AS  DELETED_FG,
        0                              AS  RECORD_ID,
        't_${SRC_INPUT_TABLE}'          AS  FILENAME,
        'SAP_HANA'                     AS  DWH_NODE_CD,
       '${LOAD_ID}' as DWH_LOAD_ID 
FROM ${TEMP_DB}.t_${SRC_INPUT_TABLE} SRC
QUALIFY ROW_NUMBER() OVER (PARTITION BY INT_ORG_NATURAL_KEY, INT_ORG_TYPE_CD, REAL_ESTATE_NATURAL_KEY, CALMONTH, PLANNED_VAL_TYPE_NATURAL_KEY, PLAN_POS_NR
order by extraction_date desc, extraction_ts desc)=1
;

