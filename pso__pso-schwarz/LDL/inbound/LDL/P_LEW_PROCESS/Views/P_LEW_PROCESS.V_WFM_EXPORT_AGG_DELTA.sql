create or replace view LDL_PRODUCTION.P_LEW_PROCESS.V_WFM_EXPORT_AGG_DELTA(
	AGGREGATE_NAME,
	PROCESS_NAME,
	PROCESS_SPECIFICATION,
	EXPORT_SPECIFICATION,
	LAST_EXPORT_TMSP,
	LAST_EXPORT_LOAD_ID,
	CLIENT_ID,
	LOC_SID,
	DWH_CAL_DT,
	CREATE_TIMESTAMP,
	UPDATE_TIMESTAMP
) as
            SELECT
                tbl_upd.aggregate_name,
            last_exp.process_name,
            last_exp.process_specification,
            last_exp.export_specification,
            last_exp.last_export_tmsp,
            last_exp.last_export_load_id,
            tbl_upd.client_id,
            tbl_upd.loc_sid,
            tbl_upd.dwh_cal_dt,
            tbl_upd.create_timestamp,
            tbl_upd.update_timestamp
            FROM p_lew_process.t_agc_run_log_location tbl_upd
            INNER JOIN p_lew_process.v_wfm_last_export last_exp
            ON tbl_upd.update_timestamp > last_exp.last_export_tmsp
            INNER JOIN p_lew_process.v_wfm_export_specification expo_spec
            ON last_exp.export_specification = expo_spec.export_specification
            AND tbl_upd.client_id = expo_spec.client_id
           WHERE tbl_upd.recalc_fg = 0
                 AND status = 'DONE'
;
