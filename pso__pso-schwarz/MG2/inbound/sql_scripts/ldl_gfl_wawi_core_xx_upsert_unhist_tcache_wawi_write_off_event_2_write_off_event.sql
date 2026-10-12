-- curr_stat_fg shoudl be set to false for writes-off loaded before the current load
UPDATE core_rel.t_write_off_event
SET curr_stat_fg = FALSE, dwh_updated_tmsp = CURRENT_TIMESTAMP()
WHERE (int_org_sid,bus_dt,receipt_nr) 
      IN
      (SELECT 
	   int_org_sid,bus_dt,receipt_nr
	   FROM  ${TEMP_DB}.${SRC2TGT_TEMP_TABLE2}_${SRC_CONTEXT_AREA}
	   )
      AND dwh_load_id < ${LOAD_ID} AND curr_stat_fg = TRUE
;
