UPDATE etl_process.t_wawi_extract_control_status_2
SET last_scn = max_scn
    ,dwh_updated_tmsp = CURRENT_TIMESTAMP
    ,dwh_load_id = ${LOAD_ID}
;
