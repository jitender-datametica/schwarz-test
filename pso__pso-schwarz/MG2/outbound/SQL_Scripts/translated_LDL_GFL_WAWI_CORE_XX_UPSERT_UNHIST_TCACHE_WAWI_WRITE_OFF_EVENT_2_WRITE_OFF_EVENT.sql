
-- curr_stat_fg shoudl be set to false for writes-off loaded before the current load



UPDATE ldl_data_production_core_rel.t_write_off_event SET
 curr_stat_fg = FALSE,
 dwh_updated_tmsp = CURRENT_TIMESTAMP()
WHERE (int_org_sid, bus_dt, receipt_nr) IN (SELECT (int_org_sid, bus_dt, receipt_nr)
    FROM ${temp_db}.${src2tgt_temp_table2}_${src_context_area}) AND dwh_load_id < CAST(${load_id} AS FLOAT64) AND
 curr_stat_fg = TRUE;