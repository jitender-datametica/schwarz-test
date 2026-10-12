create or replace view LDL_PRODUCTION_CLONE_GOOGLE_20260608_1030.P_LEW_PROCESS_AC.V_AGG_EJR_LOAD_2(
	CLIENT_ID,
	LOC_SID,
	ASPECT_ID,
	DWH_CAL_DT,
	SCENARIO,
	CORE,
	SOLACE,
	DAYEND_COMPLETION,
	LADEQUOTE,
	LADEQUOTE_SOLACE
) as
SELECT 
client_id
,loc_sid
,aspect_id
,dwh_cal_dt
,scenario
,core
,solace
,dayend_completion
,ladequote
,ladequote_solace
FROM
p_lew_process.t_agg_ejr_load_2
;
