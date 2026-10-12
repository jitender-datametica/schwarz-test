-- curr_stat_fg shoudl be set to false for statistics loaded before the current load
UPDATE core_rel.t_revenue_statistics_1
SET curr_stat_fg = FALSE, dwh_updated_tmsp = CURRENT_TIMESTAMP()
WHERE (store_sid,bus_dt,receipt_nr) 
      IN
      (SELECT 
	   store_sid,bus_dt,receipt_nr
	   FROM  ${TEMP_DB}.${SRC2TGT_TEMP_TABLE2}_${SRC_CONTEXT_AREA}
	   )
      AND dwh_load_id < ${LOAD_ID} AND curr_stat_fg = TRUE
;

UPDATE etl_process.t_wawi_extract_control_status_1
SET last_scn = max_scn
    ,dwh_updated_tmsp = CURRENT_TIMESTAMP
    ,dwh_load_id = ${LOAD_ID}
WHERE schema_name=UPPER(SPLIT('${SRC_INPUT_TABLE}','.')[0]) AND table_name=UPPER(SPLIT('${SRC_INPUT_TABLE}','.')[1]) AND ai_graph_name='${AI_GRAPH_NAME}'
;

