CREATE OR REPLACE VIEW ldl_p_lew_process.v_wfm_export_agg_delta AS SELECT TBL_UPD.aggregate_name,
 LAST_EXP.process_name,
 LAST_EXP.process_specification,
 LAST_EXP.export_specification,
 LAST_EXP.last_export_tmsp,
 LAST_EXP.last_export_load_id,
 TBL_UPD.client_id,
 TBL_UPD.loc_sid,
 TBL_UPD.dwh_cal_dt,
 TBL_UPD.create_timestamp,
 TBL_UPD.update_timestamp
FROM ldl_p_lew_process.t_agc_run_log_location AS TBL_UPD
 INNER JOIN ldl_p_lew_process.v_wfm_last_export AS LAST_EXP ON TBL_UPD.update_timestamp > LAST_EXP.last_export_tmsp
 INNER JOIN ldl_p_lew_process.v_wfm_export_specification AS EXPO_SPEC ON LAST_EXP.export_specification = EXPO_SPEC.export_specification
    AND TBL_UPD.client_id = EXPO_SPEC.client_id
WHERE TBL_UPD.recalc_fg = 0
 AND TBL_UPD.status = 'DONE';