create or replace view LDL_PRODUCTION.P_LEW_PROCESS.V_AGC_RUN_LOG_1(
	RUN_LOG_SID,
	AGGREGATE_NAME,
	CLIENT_ID,
	DWH_CAL_DT,
	RECALC_FG,
	STATUS_1,
	RUN_ID,
	RUN_CLUSTER_CD,
	CREATE_TIMESTAMP,
	UPDATE_TIMESTAMP,
	START_PROCESSING,
	END_PROCESSING
) as
   SELECT
    run_log_sid,
   aggregate_name,
   client_id,
   dwh_cal_dt,
   recalc_fg,
   status_1,
   run_id,
   run_cluster_cd,
   create_timestamp,
   update_timestamp,
   start_processing,
   end_processing
   FROM p_lew_process.t_agc_run_log_1
;
