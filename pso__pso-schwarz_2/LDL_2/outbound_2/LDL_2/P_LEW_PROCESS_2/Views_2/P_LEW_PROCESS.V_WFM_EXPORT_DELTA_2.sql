CREATE OR REPLACE VIEW ldl_p_lew_process.v_wfm_export_delta_2 AS SELECT TBL_UPD.core_table_name,
 LAST_EXP.process_name,
 LAST_EXP.process_specification,
 LAST_EXP.export_specification,
 LAST_EXP.last_export_tmsp,
 LAST_EXP.last_export_load_id,
 TBL_UPD.client_id,
 TBL_UPD.dwh_cal_dt,
 TBL_UPD.create_timestamp
FROM ldl_p_lew_process.t_agc_core_table_update_2 AS TBL_UPD
 INNER JOIN ldl_p_lew_process.v_wfm_last_export_2 AS LAST_EXP ON TBL_UPD.create_timestamp > LAST_EXP.last_export_tmsp
 INNER JOIN ldl_p_lew_process.v_wfm_export_specification_2 AS EXPO_SPEC ON LAST_EXP.export_specification = EXPO_SPEC.export_specification
    AND TBL_UPD.client_id = EXPO_SPEC.client_id
WHERE TBL_UPD.recalc_fg = 0;