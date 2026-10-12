--sum values AS we receive double records for Croatia
CREATE TEMPORARY TABLE ${TEMP_DB}.t_${SRC_INPUT_TABLE}_temp AS
SELECT 
        vlxmlcntr,
        extraction_date,
        calmonth,
        SUM(kalk_repr_ist) AS kalk_repr_ist,
        SUM(steuern_ist) AS steuern_ist,
        SUM(rvg_ist) AS rvg_ist,
        SUM(nrv_ist) AS nrv_ist,
        SUM(spedition_ist) AS spedition_ist,
        SUM(whrgdiff_ist) AS whrgdiff_ist,
        SUM(kalkulation_ist) AS kalkulation_ist,
        vlxecukyl
FROM ${TEMP_DB}.t_${SRC_INPUT_TABLE}
GROUP BY vlxmlcntr,extraction_date,calmonth,vlxecukyl;

INSERT INTO ${TEMP_DB}.${SRC2TGT_TEMP_TABLE1}_${SRC_CONTEXT_AREA}
(
        geo_area_natural_key,
        reporting_country_key_type_cd,
        stat_type_cd,
        stat_dt,
        cal_month,
        curr_stat_fg ,
        stat_val,
        curr_cd ,
        stat_cnt,
        stat_qty,
        stat_meas,
        uom_cd,    
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
        UPPER(SUBSTR(VLXMLCNTR, 1, 2)) geo_area_natural_key,
        'REP_CTRY' AS reporting_country_key_type_cd,
        '255' AS stat_type_cd,
        SRC.EXTRACTION_DATE AS STAT_DT,--?
        SRC.calmonth ,
        1 AS CURR_STAT_FG,
        KALK_REPR_IST AS stat_val,
        VLXECUKYL AS CURR_CD,
        NULl AS STAT_CNT,
        NULL AS STAT_QTY,
        NULL AS STAT_MEAS,
        NULL AS UOM_CD,
        SRC.EXTRACTION_DATE AS EXTRACTION_DT,        
        CURRENT_TIMESTAMP              AS  DWH_MAPPING_TMSP,
        0                              AS  TF_ERROR_FG,
        0                              AS  DELETED_FG,
        0                              AS  RECORD_ID,
        't_${SRC_INPUT_TABLE}'          AS  FILENAME,
        'SAP_HANA'                     AS  DWH_NODE_CD,
       '${LOAD_ID}' AS DWH_LOAD_ID 
FROM ${TEMP_DB}.t_${SRC_INPUT_TABLE}_temp SRC
UNION ALL
SELECT
        UPPER(SUBSTR(VLXMLCNTR, 1, 2)) geo_area_natural_key,
        'REP_CTRY' AS reporting_country_key_type_cd,
        '256' AS stat_type_cd,
        SRC.EXTRACTION_DATE AS STAT_DT,--?
        SRC.calmonth ,
        1 AS CURR_STAT_FG,
        STEUERN_IST AS stat_val,
        VLXECUKYL AS CURR_CD,
        NULl AS STAT_CNT,
        NULL AS STAT_QTY,
        NULL AS STAT_MEAS,
        NULL AS UOM_CD,
        SRC.EXTRACTION_DATE AS EXTRACTION_DT,        
        CURRENT_TIMESTAMP              AS  DWH_MAPPING_TMSP,
        0                              AS  TF_ERROR_FG,
        0                              AS  DELETED_FG,
        0                              AS  RECORD_ID,
        't_${SRC_INPUT_TABLE}'          AS  FILENAME,
        'SAP_HANA'                     AS  DWH_NODE_CD,
       '${LOAD_ID}' AS DWH_LOAD_ID 
FROM ${TEMP_DB}.t_${SRC_INPUT_TABLE}_temp SRC
UNION ALL
SELECT
        UPPER(SUBSTR(VLXMLCNTR, 1, 2)) geo_area_natural_key,
        'REP_CTRY' AS reporting_country_key_type_cd,
        '257' AS stat_type_cd,
        SRC.EXTRACTION_DATE AS STAT_DT,--?
        SRC.calmonth ,
        1 AS CURR_STAT_FG,
        RVG_IST AS stat_val,
        VLXECUKYL AS CURR_CD,
        NULl AS STAT_CNT,
        NULL AS STAT_QTY,
        NULL AS STAT_MEAS,
        NULL AS UOM_CD,
        SRC.EXTRACTION_DATE AS EXTRACTION_DT,        
        CURRENT_TIMESTAMP              AS  DWH_MAPPING_TMSP,
        0                              AS  TF_ERROR_FG,
        0                              AS  DELETED_FG,
        0                              AS  RECORD_ID,
        't_${SRC_INPUT_TABLE}'          AS  FILENAME,
        'SAP_HANA'                     AS  DWH_NODE_CD,
       '${LOAD_ID}' AS DWH_LOAD_ID 
FROM ${TEMP_DB}.t_${SRC_INPUT_TABLE}_temp SRC
UNION ALL
SELECT
        UPPER(SUBSTR(VLXMLCNTR, 1, 2)) geo_area_natural_key,
        'REP_CTRY' AS reporting_country_key_type_cd,
        '258' AS stat_type_cd,
        SRC.EXTRACTION_DATE AS STAT_DT,--?
        SRC.calmonth ,
        1 AS CURR_STAT_FG,
        NRV_IST AS stat_val,
        VLXECUKYL AS CURR_CD,
        NULl AS STAT_CNT,
        NULL AS STAT_QTY,
        NULL AS STAT_MEAS,
        NULL AS UOM_CD,
        SRC.EXTRACTION_DATE AS EXTRACTION_DT,        
        CURRENT_TIMESTAMP              AS  DWH_MAPPING_TMSP,
        0                              AS  TF_ERROR_FG,
        0                              AS  DELETED_FG,
        0                              AS  RECORD_ID,
        't_${SRC_INPUT_TABLE}'          AS  FILENAME,
        'SAP_HANA'                     AS  DWH_NODE_CD,
       '${LOAD_ID}' AS DWH_LOAD_ID 
FROM ${TEMP_DB}.t_${SRC_INPUT_TABLE}_temp SRC
UNION ALL
SELECT
        UPPER(SUBSTR(VLXMLCNTR, 1, 2)) geo_area_natural_key,
        'REP_CTRY' AS reporting_country_key_type_cd,
        '259' AS stat_type_cd,
        SRC.EXTRACTION_DATE AS STAT_DT,--?
        SRC.calmonth ,
        1 AS CURR_STAT_FG,
        SPEDITION_IST AS stat_val,
        VLXECUKYL AS CURR_CD,
        NULl AS STAT_CNT,
        NULL AS STAT_QTY,
        NULL AS STAT_MEAS,
        NULL AS UOM_CD,
        SRC.EXTRACTION_DATE AS EXTRACTION_DT,        
        CURRENT_TIMESTAMP              AS  DWH_MAPPING_TMSP,
        0                              AS  TF_ERROR_FG,
        0                              AS  DELETED_FG,
        0                              AS  RECORD_ID,
        't_${SRC_INPUT_TABLE}'          AS  FILENAME,
        'SAP_HANA'                     AS  DWH_NODE_CD,
       '${LOAD_ID}' AS DWH_LOAD_ID 
FROM ${TEMP_DB}.t_${SRC_INPUT_TABLE}_temp SRC
UNION ALL
SELECT
        UPPER(SUBSTR(VLXMLCNTR, 1, 2)) geo_area_natural_key,
        'REP_CTRY' AS reporting_country_key_type_cd,
        '260' AS stat_type_cd,
        SRC.EXTRACTION_DATE AS STAT_DT,--?
        SRC.calmonth ,
        1 AS CURR_STAT_FG,
        WHRGDIFF_IST AS stat_val,
        VLXECUKYL AS CURR_CD,
        NULl AS STAT_CNT,
        NULL AS STAT_QTY,
        NULL AS STAT_MEAS,
        NULL AS UOM_CD,
        SRC.EXTRACTION_DATE AS EXTRACTION_DT,        
        CURRENT_TIMESTAMP              AS  DWH_MAPPING_TMSP,
        0                              AS  TF_ERROR_FG,
        0                              AS  DELETED_FG,
        0                              AS  RECORD_ID,
        't_${SRC_INPUT_TABLE}'          AS  FILENAME,
        'SAP_HANA'                     AS  DWH_NODE_CD,
       '${LOAD_ID}' AS DWH_LOAD_ID 
FROM ${TEMP_DB}.t_${SRC_INPUT_TABLE}_temp SRC
UNION ALL
SELECT
        UPPER(SUBSTR(VLXMLCNTR, 1, 2)) geo_area_natural_key,
        'REP_CTRY' AS reporting_country_key_type_cd,
        '261' AS stat_type_cd,
        SRC.EXTRACTION_DATE AS STAT_DT,--?
        SRC.calmonth ,
        1 AS CURR_STAT_FG,
        KALKULATION_IST AS stat_val, 
        VLXECUKYL AS CURR_CD,
        NULl AS STAT_CNT,
        NULL AS STAT_QTY,
        NULL AS STAT_MEAS,
        NULL AS UOM_CD,
        SRC.EXTRACTION_DATE AS EXTRACTION_DT,        
        CURRENT_TIMESTAMP              AS  DWH_MAPPING_TMSP,
        0                              AS  TF_ERROR_FG,
        0                              AS  DELETED_FG,
        0                              AS  RECORD_ID,
        't_${SRC_INPUT_TABLE}'          AS  FILENAME,
        'SAP_HANA'                     AS  DWH_NODE_CD,
       '${LOAD_ID}' AS DWH_LOAD_ID 
FROM ${TEMP_DB}.t_${SRC_INPUT_TABLE}_temp SRC
;
