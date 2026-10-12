-- curr_stat_fg shoudl be set to false for writes-off loaded before the current load
UPDATE core_rel.t_write_off_event
SET curr_stat_fg = FALSE, dwh_updated_tmsp = CURRENT_TIMESTAMP()
WHERE (int_org_sid,bus_dt,receipt_nr,receipt_line_nr) 
      IN
      (SELECT 
	   int_org_sid,bus_dt,receipt_nr,receipt_line_nr
	   FROM  ${TEMP_DB}.${SRC2TGT_TEMP_TABLE2}_${SRC_CONTEXT_AREA}
	   )
      AND dwh_load_id < ${LOAD_ID} AND curr_stat_fg = TRUE
;

UPDATE etl_process.t_wawi_extract_control_status
SET last_scn = max_scn
    ,dwh_updated_tmsp = CURRENT_TIMESTAMP
    ,dwh_load_id = ${LOAD_ID}
WHERE schema_name=UPPER(SPLIT('${SRC_INPUT_TABLE}','.')[0]) AND table_name=UPPER(SPLIT('${SRC_INPUT_TABLE}','.')[1]) AND ai_graph_name='${AI_GRAPH_NAME}'
;

