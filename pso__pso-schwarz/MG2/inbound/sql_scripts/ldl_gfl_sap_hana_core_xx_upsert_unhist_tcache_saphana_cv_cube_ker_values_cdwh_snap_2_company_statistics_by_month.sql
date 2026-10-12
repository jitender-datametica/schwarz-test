--Treat Belgium and Luxembourg as one country
CREATE TEMPORARY TABLE ${TEMP_DB}.t_${SRC_INPUT_TABLE}_temp
as 
(
select CASE WHEN VLXMLCNTR='LU' then 'BE' else VLXMLCNTR end as VLXMLCNTR,
EXTRACTION_DATE,
calmonth,
SUM(KALK_REPR_IST) as KALK_REPR_IST,
SUM(STEUERN_IST) as STEUERN_IST,
SUM(RVG_IST) as RVG_IST,
SUM(NRV_IST) as NRV_IST,
SUM(SPEDITION_IST) as SPEDITION_IST,
SUM(WHRGDIFF_IST) as WHRGDIFF_IST,
SUM(KALKULATION_IST) as KALKULATION_IST,
VLXECUKYL
from ${TEMP_DB}.t_${SRC_INPUT_TABLE}
group by CASE WHEN VLXMLCNTR='LU' then 'BE' else VLXMLCNTR end, EXTRACTION_DATE, calmonth, VLXECUKYL -- if there are two different currencies for one country, the script should fail
);





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
        UPPER(SUBSTR(VLXMLCNTR, 1, 2)) AS INT_COMPANY_NATURAL_KEY,
        'COUNTRY' as INT_COMPANY_KEY_TYPE_CD,
        '255' as stat_type_cd,
        SRC.EXTRACTION_DATE as STAT_DT,--?
        SRC.calmonth ,
        1 as CURR_STAT_FG,
        KALK_REPR_IST as stat_val,
        VLXECUKYL as CURR_CD,
        NULl as STAT_CNT,
        NULL as STAT_QTY,
        NULL as STAT_MEAS,
        NULL as UOM_CD,
        SRC.EXTRACTION_DATE as EXTRACTION_DT,        
        CURRENT_TIMESTAMP              AS  DWH_MAPPING_TMSP,
        0                              AS  TF_ERROR_FG,
        0                              AS  DELETED_FG,
        0                              AS  RECORD_ID,
        't_${SRC_INPUT_TABLE}'          AS  FILENAME,
        'SAP_HANA'                     AS  DWH_NODE_CD,
       '${LOAD_ID}' as DWH_LOAD_ID 
FROM ${TEMP_DB}.t_${SRC_INPUT_TABLE}_temp SRC
--FROM ETL.T_TCACHE_SAPHANA_CV_CUBE_KER_VALUES_CDWH_SNAP SRC
UNION ALL
SELECT
        UPPER(SUBSTR(VLXMLCNTR, 1, 2)) AS INT_COMPANY_NATURAL_KEY,
        'COUNTRY' as INT_COMPANY_KEY_TYPE_CD,
        '256' as stat_type_cd,
        SRC.EXTRACTION_DATE as STAT_DT,--?
        SRC.calmonth ,
        1 as CURR_STAT_FG,
        STEUERN_IST as stat_val,
        VLXECUKYL as CURR_CD,
        NULl as STAT_CNT,
        NULL as STAT_QTY,
        NULL as STAT_MEAS,
        NULL as UOM_CD,
        SRC.EXTRACTION_DATE as EXTRACTION_DT,        
        CURRENT_TIMESTAMP              AS  DWH_MAPPING_TMSP,
        0                              AS  TF_ERROR_FG,
        0                              AS  DELETED_FG,
        0                              AS  RECORD_ID,
        't_${SRC_INPUT_TABLE}'          AS  FILENAME,
        'SAP_HANA'                     AS  DWH_NODE_CD,
       '${LOAD_ID}' as DWH_LOAD_ID 
FROM ${TEMP_DB}.t_${SRC_INPUT_TABLE}_temp SRC
--FROM ETL.T_TCACHE_SAPHANA_CV_CUBE_KER_VALUES_CDWH_SNAP SRC
UNION ALL
SELECT
        UPPER(SUBSTR(VLXMLCNTR, 1, 2)) AS INT_COMPANY_NATURAL_KEY,
        'COUNTRY' as INT_COMPANY_KEY_TYPE_CD,
        '257' as stat_type_cd,
        SRC.EXTRACTION_DATE as STAT_DT,--?
        SRC.calmonth ,
        1 as CURR_STAT_FG,
        RVG_IST as stat_val,
        VLXECUKYL as CURR_CD,
        NULl as STAT_CNT,
        NULL as STAT_QTY,
        NULL as STAT_MEAS,
        NULL as UOM_CD,
        SRC.EXTRACTION_DATE as EXTRACTION_DT,        
        CURRENT_TIMESTAMP              AS  DWH_MAPPING_TMSP,
        0                              AS  TF_ERROR_FG,
        0                              AS  DELETED_FG,
        0                              AS  RECORD_ID,
        't_${SRC_INPUT_TABLE}'          AS  FILENAME,
        'SAP_HANA'                     AS  DWH_NODE_CD,
       '${LOAD_ID}' as DWH_LOAD_ID 
FROM ${TEMP_DB}.t_${SRC_INPUT_TABLE}_temp SRC
--FROM ETL.T_TCACHE_SAPHANA_CV_CUBE_KER_VALUES_CDWH_SNAP SRC
UNION ALL
SELECT
        UPPER(SUBSTR(VLXMLCNTR, 1, 2)) AS INT_COMPANY_NATURAL_KEY,
        'COUNTRY' as INT_COMPANY_KEY_TYPE_CD,
        '258' as stat_type_cd,
        SRC.EXTRACTION_DATE as STAT_DT,--?
        SRC.calmonth ,
        1 as CURR_STAT_FG,
        NRV_IST as stat_val,
        VLXECUKYL as CURR_CD,
        NULl as STAT_CNT,
        NULL as STAT_QTY,
        NULL as STAT_MEAS,
        NULL as UOM_CD,
        SRC.EXTRACTION_DATE as EXTRACTION_DT,        
        CURRENT_TIMESTAMP              AS  DWH_MAPPING_TMSP,
        0                              AS  TF_ERROR_FG,
        0                              AS  DELETED_FG,
        0                              AS  RECORD_ID,
        't_${SRC_INPUT_TABLE}'          AS  FILENAME,
        'SAP_HANA'                     AS  DWH_NODE_CD,
       '${LOAD_ID}' as DWH_LOAD_ID 
FROM ${TEMP_DB}.t_${SRC_INPUT_TABLE}_temp SRC
--FROM ETL.T_TCACHE_SAPHANA_CV_CUBE_KER_VALUES_CDWH_SNAP SRC
UNION ALL
SELECT
        UPPER(SUBSTR(VLXMLCNTR, 1, 2)) AS INT_COMPANY_NATURAL_KEY,
        'COUNTRY' as INT_COMPANY_KEY_TYPE_CD,
        '259' as stat_type_cd,
        SRC.EXTRACTION_DATE as STAT_DT,--?
        SRC.calmonth ,
        1 as CURR_STAT_FG,
        SPEDITION_IST as stat_val,
        VLXECUKYL as CURR_CD,
        NULl as STAT_CNT,
        NULL as STAT_QTY,
        NULL as STAT_MEAS,
        NULL as UOM_CD,
        SRC.EXTRACTION_DATE as EXTRACTION_DT,        
        CURRENT_TIMESTAMP              AS  DWH_MAPPING_TMSP,
        0                              AS  TF_ERROR_FG,
        0                              AS  DELETED_FG,
        0                              AS  RECORD_ID,
        't_${SRC_INPUT_TABLE}'          AS  FILENAME,
        'SAP_HANA'                     AS  DWH_NODE_CD,
       '${LOAD_ID}' as DWH_LOAD_ID 
FROM ${TEMP_DB}.t_${SRC_INPUT_TABLE}_temp SRC
--FROM ETL.T_TCACHE_SAPHANA_CV_CUBE_KER_VALUES_CDWH_SNAP SRC
UNION ALL
SELECT
        UPPER(SUBSTR(VLXMLCNTR, 1, 2)) AS INT_COMPANY_NATURAL_KEY,
        'COUNTRY' as INT_COMPANY_KEY_TYPE_CD,
        '260' as stat_type_cd,
        SRC.EXTRACTION_DATE as STAT_DT,--?
        SRC.calmonth ,
        1 as CURR_STAT_FG,
        WHRGDIFF_IST as stat_val,
        VLXECUKYL as CURR_CD,
        NULl as STAT_CNT,
        NULL as STAT_QTY,
        NULL as STAT_MEAS,
        NULL as UOM_CD,
        SRC.EXTRACTION_DATE as EXTRACTION_DT,        
        CURRENT_TIMESTAMP              AS  DWH_MAPPING_TMSP,
        0                              AS  TF_ERROR_FG,
        0                              AS  DELETED_FG,
        0                              AS  RECORD_ID,
        't_${SRC_INPUT_TABLE}'          AS  FILENAME,
        'SAP_HANA'                     AS  DWH_NODE_CD,
       '${LOAD_ID}' as DWH_LOAD_ID 
FROM ${TEMP_DB}.t_${SRC_INPUT_TABLE}_temp SRC
--FROM ETL.T_TCACHE_SAPHANA_CV_CUBE_KER_VALUES_CDWH_SNAP SRC
UNION ALL
SELECT
        UPPER(SUBSTR(VLXMLCNTR, 1, 2)) AS INT_COMPANY_NATURAL_KEY,
        'COUNTRY' as INT_COMPANY_KEY_TYPE_CD,
        '261' as stat_type_cd,
        SRC.EXTRACTION_DATE as STAT_DT,--?
        SRC.calmonth ,
        1 as CURR_STAT_FG,
        KALKULATION_IST as stat_val, 
        VLXECUKYL as CURR_CD,
        NULl as STAT_CNT,
        NULL as STAT_QTY,
        NULL as STAT_MEAS,
        NULL as UOM_CD,
        SRC.EXTRACTION_DATE as EXTRACTION_DT,        
        CURRENT_TIMESTAMP              AS  DWH_MAPPING_TMSP,
        0                              AS  TF_ERROR_FG,
        0                              AS  DELETED_FG,
        0                              AS  RECORD_ID,
        't_${SRC_INPUT_TABLE}'          AS  FILENAME,
        'SAP_HANA'                     AS  DWH_NODE_CD,
       '${LOAD_ID}' as DWH_LOAD_ID 
FROM ${TEMP_DB}.t_${SRC_INPUT_TABLE}_temp SRC
--FROM ETL.T_TCACHE_SAPHANA_CV_CUBE_KER_VALUES_CDWH_SNAP SRC
;
