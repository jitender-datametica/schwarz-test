create or replace view LDL_PRODUCTION.P_LEW_PROCESS_AC.V_AGC_CORE_TABLE_UPDATE_1(
	CORE_TABLE_NAME,
	CLIENT_ID,
	DWH_CAL_DT,
	RECALC_FG,
	CREATE_TIMESTAMP,
	DWH_LOAD_ID
) as
   SELECT
       core_table_name,
   client_id,
   dwh_cal_dt,
   recalc_fg,
   create_timestamp,
   dwh_load_id
  FROM p_lew_process.v_agc_core_table_update_1
;
