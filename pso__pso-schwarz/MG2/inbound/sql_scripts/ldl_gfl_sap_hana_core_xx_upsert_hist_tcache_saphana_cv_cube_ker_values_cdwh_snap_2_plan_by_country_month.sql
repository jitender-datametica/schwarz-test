INSERT INTO   ${TEMP_DB}.${SRC2TGT_TEMP_TABLE1}_${SRC_CONTEXT_AREA}
(
        reporting_country_cd ,
        cal_month,
        planned_val_type_natural_key,
        planned_val_type_key_type_cd,
        plan_pos_nr,
        planned_kpi_meas,
        extraction_dt,
        dwh_mapping_tmsp,
        tf_error_fg,
        deleted_fg,
        record_id,
        filename,
        dwh_node_cd,
        dwh_load_id
)
SELECT
        UPPER(SUBSTR(VLXMLCNTR, 1, 2)) reporting_country_cd,
        SRC.calmonth ,
        '255|CTR' as PLANNED_VAL_TYPE_NATURAL_KEY,
        'PVAL' as PLANNED_VAL_TYPE_KEY_TYPE_CD,
        '' as plan_pos_nr,
        SRC.kalk_repr_plan as planned_kpi_meas,
        SRC.EXTRACTION_DATE as EXTRACTION_DT,        
        CURRENT_TIMESTAMP              AS  DWH_MAPPING_TMSP,
        0                              AS  TF_ERROR_FG,
        0                              AS  DELETED_FG,
        0                              AS  RECORD_ID,
        't_${SRC_INPUT_TABLE}'          AS  FILENAME,
        'SAP_HANA'                     AS  DWH_NODE_CD,
       '${LOAD_ID}' as DWH_LOAD_ID 
FROM ${TEMP_DB}.t_${SRC_INPUT_TABLE} SRC
--FROM ETL.T_TCACHE_SAPHANA_CV_CUBE_KER_VALUES_CDWH_SNAP SRC
QUALIFY ROW_NUMBER() OVER (PARTITION BY reporting_country_cd, CALMONTH, PLANNED_VAL_TYPE_NATURAL_KEY, PLAN_POS_NR
order by extraction_date desc)=1
UNION ALL
SELECT
        UPPER(SUBSTR(VLXMLCNTR, 1, 2)) reporting_country_cd,
        SRC.calmonth ,
        '256|CTR' as PLANNED_VAL_TYPE_NATURAL_KEY,
        'PVAL' as PLANNED_VAL_TYPE_KEY_TYPE_CD,
        '' as plan_pos_nr,
        SRC.steuern_plan as planned_kpi_meas,
        SRC.EXTRACTION_DATE as EXTRACTION_DT,        
        CURRENT_TIMESTAMP              AS  DWH_MAPPING_TMSP,
        0                              AS  TF_ERROR_FG,
        0                              AS  DELETED_FG,
        0                              AS  RECORD_ID,
        't_${SRC_INPUT_TABLE}'          AS  FILENAME,
        'SAP_HANA'                     AS  DWH_NODE_CD,
       '${LOAD_ID}' as DWH_LOAD_ID 
FROM ${TEMP_DB}.t_${SRC_INPUT_TABLE} SRC
--FROM ETL.T_TCACHE_SAPHANA_CV_CUBE_KER_VALUES_CDWH_SNAP SRC
QUALIFY ROW_NUMBER() OVER (PARTITION BY reporting_country_cd, CALMONTH, PLANNED_VAL_TYPE_NATURAL_KEY, PLAN_POS_NR
order by extraction_date desc)=1
UNION ALL
SELECT
        UPPER(SUBSTR(VLXMLCNTR, 1, 2)) reporting_country_cd,
        SRC.calmonth ,
        '257|CTR' as PLANNED_VAL_TYPE_NATURAL_KEY,
        'PVAL' as PLANNED_VAL_TYPE_KEY_TYPE_CD,
        '' as plan_pos_nr,
        SRC.rvg_plan as planned_kpi_meas,
        SRC.EXTRACTION_DATE as EXTRACTION_DT,        
        CURRENT_TIMESTAMP              AS  DWH_MAPPING_TMSP,
        0                              AS  TF_ERROR_FG,
        0                              AS  DELETED_FG,
        0                              AS  RECORD_ID,
        't_${SRC_INPUT_TABLE}'          AS  FILENAME,
        'SAP_HANA'                     AS  DWH_NODE_CD,
       '${LOAD_ID}' as DWH_LOAD_ID 
FROM ${TEMP_DB}.t_${SRC_INPUT_TABLE} SRC
--FROM ETL.T_TCACHE_SAPHANA_CV_CUBE_KER_VALUES_CDWH_SNAP SRC
QUALIFY ROW_NUMBER() OVER (PARTITION BY reporting_country_cd, CALMONTH, PLANNED_VAL_TYPE_NATURAL_KEY, PLAN_POS_NR
order by extraction_date desc)=1

UNION ALL
SELECT
        UPPER(SUBSTR(VLXMLCNTR, 1, 2)) reporting_country_cd,
        SRC.calmonth ,
        '258|CTR' as PLANNED_VAL_TYPE_NATURAL_KEY,
        'PVAL' as PLANNED_VAL_TYPE_KEY_TYPE_CD,
        '' as plan_pos_nr,
        SRC.nrv_plan as planned_kpi_meas,
        SRC.EXTRACTION_DATE as EXTRACTION_DT,        
        CURRENT_TIMESTAMP              AS  DWH_MAPPING_TMSP,
        0                              AS  TF_ERROR_FG,
        0                              AS  DELETED_FG,
        0                              AS  RECORD_ID,
        't_${SRC_INPUT_TABLE}'          AS  FILENAME,
        'SAP_HANA'                     AS  DWH_NODE_CD,
       '${LOAD_ID}' as DWH_LOAD_ID 
FROM ${TEMP_DB}.t_${SRC_INPUT_TABLE} SRC
--FROM ETL.T_TCACHE_SAPHANA_CV_CUBE_KER_VALUES_CDWH_SNAP SRC
QUALIFY ROW_NUMBER() OVER (PARTITION BY reporting_country_cd, CALMONTH, PLANNED_VAL_TYPE_NATURAL_KEY, PLAN_POS_NR
order by extraction_date desc)=1

UNION ALL
SELECT
        UPPER(SUBSTR(VLXMLCNTR, 1, 2)) reporting_country_cd,
        SRC.calmonth ,
        '259|CTR' as PLANNED_VAL_TYPE_NATURAL_KEY,
        'PVAL' as PLANNED_VAL_TYPE_KEY_TYPE_CD,
        '' as plan_pos_nr,
        SRC.spedition_plan as planned_kpi_meas,
        SRC.EXTRACTION_DATE as EXTRACTION_DT,        
        CURRENT_TIMESTAMP              AS  DWH_MAPPING_TMSP,
        0                              AS  TF_ERROR_FG,
        0                              AS  DELETED_FG,
        0                              AS  RECORD_ID,
        't_${SRC_INPUT_TABLE}'          AS  FILENAME,
        'SAP_HANA'                     AS  DWH_NODE_CD,
       '${LOAD_ID}' as DWH_LOAD_ID 
FROM ${TEMP_DB}.t_${SRC_INPUT_TABLE} SRC
--FROM ETL.T_TCACHE_SAPHANA_CV_CUBE_KER_VALUES_CDWH_SNAP SRC
QUALIFY ROW_NUMBER() OVER (PARTITION BY reporting_country_cd, CALMONTH, PLANNED_VAL_TYPE_NATURAL_KEY, PLAN_POS_NR
order by extraction_date desc)=1

UNION ALL
SELECT
        UPPER(SUBSTR(VLXMLCNTR, 1, 2)) reporting_country_cd,
        SRC.calmonth ,
        '260|CTR' as PLANNED_VAL_TYPE_NATURAL_KEY,
        'PVAL' as PLANNED_VAL_TYPE_KEY_TYPE_CD,
        '' as plan_pos_nr,
        SRC.whrgdiff_plan as planned_kpi_meas,
        SRC.EXTRACTION_DATE as EXTRACTION_DT,        
        CURRENT_TIMESTAMP              AS  DWH_MAPPING_TMSP,
        0                              AS  TF_ERROR_FG,
        0                              AS  DELETED_FG,
        0                              AS  RECORD_ID,
        't_${SRC_INPUT_TABLE}'          AS  FILENAME,
        'SAP_HANA'                     AS  DWH_NODE_CD,
       '${LOAD_ID}' as DWH_LOAD_ID 
FROM ${TEMP_DB}.t_${SRC_INPUT_TABLE} SRC
--FROM ETL.T_TCACHE_SAPHANA_CV_CUBE_KER_VALUES_CDWH_SNAP SRC
QUALIFY ROW_NUMBER() OVER (PARTITION BY reporting_country_cd, CALMONTH, PLANNED_VAL_TYPE_NATURAL_KEY, PLAN_POS_NR
order by extraction_date desc)=1

UNION ALL
SELECT
        UPPER(SUBSTR(VLXMLCNTR, 1, 2)) reporting_country_cd,
        SRC.calmonth ,
        '261CTR' as PLANNED_VAL_TYPE_NATURAL_KEY,
        'PVAL' as PLANNED_VAL_TYPE_KEY_TYPE_CD,
        '' as plan_pos_nr,
        SRC.kalkulation_plan as planned_kpi_meas,
        SRC.EXTRACTION_DATE as EXTRACTION_DT,        
        CURRENT_TIMESTAMP              AS  DWH_MAPPING_TMSP,
        0                              AS  TF_ERROR_FG,
        0                              AS  DELETED_FG,
        0                              AS  RECORD_ID,
        't_${SRC_INPUT_TABLE}'          AS  FILENAME,
        'SAP_HANA'                     AS  DWH_NODE_CD,
       '${LOAD_ID}' as DWH_LOAD_ID 
FROM ${TEMP_DB}.t_${SRC_INPUT_TABLE} SRC
--FROM ETL.T_TCACHE_SAPHANA_CV_CUBE_KER_VALUES_CDWH_SNAP SRC
QUALIFY ROW_NUMBER() OVER (PARTITION BY reporting_country_cd, CALMONTH, PLANNED_VAL_TYPE_NATURAL_KEY, PLAN_POS_NR
order by extraction_date desc)=1
