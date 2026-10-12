--Treat Belgium and Luxembourg as one country_1
CREATE TEMPORARY TABLE ${TEMP_DB}.t_${SRC_INPUT_TABLE}_temp
as 
(
select CASE WHEN VLXMLCNTR='LU' then 'BE' else VLXMLCNTR end as VLXMLCNTR,
EXTRACTION_DATE,
calmonth,
SUM(kalk_repr_plan) as kalk_repr_plan,
SUM(steuern_plan) as steuern_plan,
SUM(rvg_plan) as rvg_plan,
SUM(nrv_plan) as nrv_plan,
SUM(spedition_plan) as spedition_plan,
SUM(whrgdiff_plan) as whrgdiff_plan,
SUM(kalkulation_plan) as kalkulation_plan
from ${TEMP_DB}.t_${SRC_INPUT_TABLE}
group by CASE WHEN VLXMLCNTR='LU' then 'BE' else VLXMLCNTR end, EXTRACTION_DATE, calmonth
);



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
        UPPER(SUBSTR(VLXMLCNTR, 1, 2)) AS INT_ORG_NATURAL_KEY,
        'COUNTRY_1' as INT_ORG_KEY_TYPE_CD,
        'COUNTRY_1' as INT_ORG_TYPE_CD ,
        'DUMMY_1|DUMMY_1' REAL_ESTATE_NATURAL_KEY,
        'DUMMY_1' REAL_ESTATE_KEY_TYPE_CD,
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
FROM ${TEMP_DB}.t_${SRC_INPUT_TABLE}_temp SRC
--FROM ETL.T_TCACHE_SAPHANA_CV_CUBE_KER_VALUES_CDWH_SNAP_1 SRC
QUALIFY ROW_NUMBER() OVER (PARTITION BY INT_ORG_NATURAL_KEY, INT_ORG_TYPE_CD, REAL_ESTATE_NATURAL_KEY, CALMONTH, PLANNED_VAL_TYPE_NATURAL_KEY, PLAN_POS_NR
order by extraction_date desc)=1
UNION ALL
SELECT
        UPPER(SUBSTR(VLXMLCNTR, 1, 2)) AS INT_ORG_NATURAL_KEY,
        'COUNTRY_1' as INT_ORG_KEY_TYPE_CD,
        'COUNTRY_1' as INT_ORG_TYPE_CD ,
        'DUMMY_1|DUMMY_1' REAL_ESTATE_NATURAL_KEY,
        'DUMMY_1' REAL_ESTATE_KEY_TYPE_CD,
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
FROM ${TEMP_DB}.t_${SRC_INPUT_TABLE}_temp SRC
--FROM ETL.T_TCACHE_SAPHANA_CV_CUBE_KER_VALUES_CDWH_SNAP_1 SRC
QUALIFY ROW_NUMBER() OVER (PARTITION BY INT_ORG_NATURAL_KEY, INT_ORG_TYPE_CD, REAL_ESTATE_NATURAL_KEY, CALMONTH, PLANNED_VAL_TYPE_NATURAL_KEY, PLAN_POS_NR
order by extraction_date desc)=1
UNION ALL
SELECT
        UPPER(SUBSTR(VLXMLCNTR, 1, 2)) AS INT_ORG_NATURAL_KEY,
        'COUNTRY_1' as INT_ORG_KEY_TYPE_CD,
        'COUNTRY_1' as INT_ORG_TYPE_CD ,
        'DUMMY_1|DUMMY_1' REAL_ESTATE_NATURAL_KEY,
        'DUMMY_1' REAL_ESTATE_KEY_TYPE_CD,
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
FROM ${TEMP_DB}.t_${SRC_INPUT_TABLE}_temp SRC
--FROM ETL.T_TCACHE_SAPHANA_CV_CUBE_KER_VALUES_CDWH_SNAP_1 SRC
QUALIFY ROW_NUMBER() OVER (PARTITION BY INT_ORG_NATURAL_KEY, INT_ORG_TYPE_CD, REAL_ESTATE_NATURAL_KEY, CALMONTH, PLANNED_VAL_TYPE_NATURAL_KEY, PLAN_POS_NR
order by extraction_date desc)=1

UNION ALL
SELECT
        UPPER(SUBSTR(VLXMLCNTR, 1, 2)) AS INT_ORG_NATURAL_KEY,
        'COUNTRY_1' as INT_ORG_KEY_TYPE_CD,
        'COUNTRY_1' as INT_ORG_TYPE_CD ,
        'DUMMY_1|DUMMY_1' REAL_ESTATE_NATURAL_KEY,
        'DUMMY_1' REAL_ESTATE_KEY_TYPE_CD,
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
FROM ${TEMP_DB}.t_${SRC_INPUT_TABLE}_temp SRC
--FROM ETL.T_TCACHE_SAPHANA_CV_CUBE_KER_VALUES_CDWH_SNAP_1 SRC
QUALIFY ROW_NUMBER() OVER (PARTITION BY INT_ORG_NATURAL_KEY, INT_ORG_TYPE_CD, REAL_ESTATE_NATURAL_KEY, CALMONTH, PLANNED_VAL_TYPE_NATURAL_KEY, PLAN_POS_NR
order by extraction_date desc)=1

UNION ALL
SELECT
        UPPER(SUBSTR(VLXMLCNTR, 1, 2)) AS INT_ORG_NATURAL_KEY,
        'COUNTRY_1' as INT_ORG_KEY_TYPE_CD,
        'COUNTRY_1' as INT_ORG_TYPE_CD ,
        'DUMMY_1|DUMMY_1' REAL_ESTATE_NATURAL_KEY,
        'DUMMY_1' REAL_ESTATE_KEY_TYPE_CD,
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
FROM ${TEMP_DB}.t_${SRC_INPUT_TABLE}_temp SRC
--FROM ETL.T_TCACHE_SAPHANA_CV_CUBE_KER_VALUES_CDWH_SNAP_1 SRC
QUALIFY ROW_NUMBER() OVER (PARTITION BY INT_ORG_NATURAL_KEY, INT_ORG_TYPE_CD, REAL_ESTATE_NATURAL_KEY, CALMONTH, PLANNED_VAL_TYPE_NATURAL_KEY, PLAN_POS_NR
order by extraction_date desc)=1

UNION ALL
SELECT
        UPPER(SUBSTR(VLXMLCNTR, 1, 2)) AS INT_ORG_NATURAL_KEY,
        'COUNTRY_1' as INT_ORG_KEY_TYPE_CD,
        'COUNTRY_1' as INT_ORG_TYPE_CD ,
        'DUMMY_1|DUMMY_1' REAL_ESTATE_NATURAL_KEY,
        'DUMMY_1' REAL_ESTATE_KEY_TYPE_CD,
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
FROM ${TEMP_DB}.t_${SRC_INPUT_TABLE}_temp SRC
--FROM ETL.T_TCACHE_SAPHANA_CV_CUBE_KER_VALUES_CDWH_SNAP_1 SRC
QUALIFY ROW_NUMBER() OVER (PARTITION BY INT_ORG_NATURAL_KEY, INT_ORG_TYPE_CD, REAL_ESTATE_NATURAL_KEY, CALMONTH, PLANNED_VAL_TYPE_NATURAL_KEY, PLAN_POS_NR
order by extraction_date desc)=1

UNION ALL
SELECT
        UPPER(SUBSTR(VLXMLCNTR, 1, 2)) AS INT_ORG_NATURAL_KEY,
        'COUNTRY_1' as INT_ORG_KEY_TYPE_CD,
        'COUNTRY_1' as INT_ORG_TYPE_CD ,
        'DUMMY_1|DUMMY_1' REAL_ESTATE_NATURAL_KEY,
        'DUMMY_1' REAL_ESTATE_KEY_TYPE_CD,
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
FROM ${TEMP_DB}.t_${SRC_INPUT_TABLE}_temp SRC
--FROM ETL.T_TCACHE_SAPHANA_CV_CUBE_KER_VALUES_CDWH_SNAP_1 SRC
QUALIFY ROW_NUMBER() OVER (PARTITION BY INT_ORG_NATURAL_KEY, INT_ORG_TYPE_CD, REAL_ESTATE_NATURAL_KEY, CALMONTH, PLANNED_VAL_TYPE_NATURAL_KEY, PLAN_POS_NR
order by extraction_date desc)=1
