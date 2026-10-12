-- curr_stat_fg shoudl be set to false for writes-off loaded before the current load

UPDATE ldl_data_production_core_rel.t_write_off_event SET
 curr_stat_fg = FALSE,
 dwh_updated_tmsp = CURRENT_TIMESTAMP()
WHERE (int_org_sid, bus_dt, receipt_nr, receipt_line_nr) IN (SELECT (int_org_sid, bus_dt, receipt_nr, t_write_off_event
       .receipt_line_nr)
    FROM ${temp_db}.${src2tgt_temp_table2}_{src_context_area}) AND dwh_load_id < CAST(${load_id} AS FLOAT64) AND
 curr_stat_fg;


UPDATE ldl_data_production_etl_process.t_wawi_extract_control_status 
SET last_scn = t_wawi_extract_control_status.max_scn,
 	dwh_updated_tmsp = CURRENT_TIMESTAMP(),
 	dwh_load_id = t_wawi_extract_control_status.${load_id}
WHERE schema_name = UPPER(SPLIT('${SRC_INPUT_TABLE}', '.')[OFFSET(0)]) AND table_name = UPPER(SPLIT('${SRC_INPUT_TABLE}'
     , '.')[OFFSET(1)]) AND ai_graph_name = '${AI_GRAPH_NAME}';