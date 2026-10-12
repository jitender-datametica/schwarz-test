TRUNCATE TABLE etl.t_wawi_precore_t88_sformhead;

INSERT INTO  ${TEMP_DB}.${SRC2TGT_TEMP_TABLE1}_${SRC_CONTEXT_AREA}
(
  ctrcode,
  wh_nr,
  c88_formcount,
  c88_storeno,
  c88_formtype,
  c88_formdate,
  c88_warehouseno,
  c88_towarehouse,
  c88_tostore,
  c88_pl_pv_date,
  c88_pl_bereich,
  c88_global,
  c88_correct_count,
  c88_moddate,
  c88_moduser,
  c88_checksumvalue,
  c88_formno,
  c88_whnr,
  c88_adr_export_flag,
  c88_adr_export_date,
  scn,
  extraction_tmsp,  
  --------------------------------
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
  left( src.ctrcode, 2) as ctrcode,
  wh_nr,
  c88_formcount,
  c88_storeno,
  c88_formtype,
  c88_formdate,
  c88_warehouseno,
  c88_towarehouse,
  c88_tostore,
  c88_pl_pv_date,
  c88_pl_bereich,
  c88_global,
  c88_correct_count,
  c88_moddate,
  c88_moduser,
  c88_checksumvalue,
  c88_formno,
  c88_whnr,
  c88_adr_export_flag,
  c88_adr_export_date,
  scn,
  extraction_tmsp,
  --------------------------------
  'WAWI'                             AS SOURCE_SYSTEM,
  CURRENT_DATE                       AS EXTRACTION_DT,
  current_timestamp                  AS DWH_MAPPING_TMSP,
  0                                  AS TF_ERROR_FG,
  0                                  AS DELETED_FG,
  0                                  AS RECORD_ID,
  '${SRC_INPUT_TABLE}'               AS FILENAME,
  'WAWI_HQ'                          AS DWH_NODE_CD,
  '${LOAD_ID}'                       AS DWH_LOAD_ID
FROM etl.t88_sformhead src
INNER JOIN etl.wawi_control_table ctrl ON ctrl.source_table_name = UPPER('etl.t88_sformhead')
                                          AND ctrl.source_status = 'A'
                                          AND src.extraction_tmsp between ctrl.begin_tmsp and ctrl.end_tmsp
QUALIFY ROW_NUMBER() OVER (PARTITION BY c88_formcount, c88_whnr ORDER BY src.extraction_tmsp DESC ) = 1;
