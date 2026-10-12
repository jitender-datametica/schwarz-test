create or replace view LDL_PRODUCTION.P_LEW_PROCESS_AC.V_WFM_EXPORT_AGG_DELTA_2(
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
                aggregate_name,
            process_name,
            process_specification,
            export_specification,
            last_export_tmsp,
            last_export_load_id,
            client_id,
            loc_sid,
            dwh_cal_dt,
            create_timestamp,
            update_timestamp
           FROM p_lew_process.v_wfm_export_agg_delta_2
;
