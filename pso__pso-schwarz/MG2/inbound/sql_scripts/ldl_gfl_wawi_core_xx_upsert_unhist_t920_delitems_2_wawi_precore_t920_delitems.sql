TRUNCATE TABLE etl.t_wawi_precore_t920_delitems;

INSERT INTO  ${TEMP_DB}.${SRC2TGT_TEMP_TABLE1}_${SRC_CONTEXT_AREA}
(
   ctrcode,
  c920_batchnr,
  c920_batchdate,
  c920_batchitemnr,
  c920_itemnr_short,
  c920_state,
  c920_closed,
  c920_moddate,
  c920_moduser,
  c920_itemdesc,
  c920_errortable,
  c920_error_message,
  c920_released_by,
  c920_created_by,
  c920_idvalue,
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
  c920_batchnr,
  c920_batchdate,
  c920_batchitemnr,
  c920_itemnr_short,
  c920_state,
  c920_closed,
  c920_moddate,
  c920_moduser,
  NULL as c920_itemdesc,
  c920_errortable,
  c920_error_message,
  c920_released_by,
  c920_created_by,
  c920_idvalue,
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
FROM etl.t920_delitems src
INNER JOIN etl.wawi_control_table ctrl ON ctrl.source_table_name = UPPER('etl.t920_delitems')
                                          AND ctrl.source_status = 'A'
                                          AND src.extraction_tmsp between ctrl.begin_tmsp and ctrl.end_tmsp
QUALIFY ROW_NUMBER() OVER (PARTITION BY LEFT( src.CTRCODE, 2), src.C920_BATCHNR, src.C920_BATCHITEMNR ORDER BY src.extraction_tmsp DESC ) = 1;


