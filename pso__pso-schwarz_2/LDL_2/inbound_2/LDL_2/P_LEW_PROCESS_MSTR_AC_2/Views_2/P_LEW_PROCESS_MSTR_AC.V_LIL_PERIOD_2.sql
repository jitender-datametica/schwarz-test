create or replace view LDL_PRODUCTION.P_LEW_PROCESS_MSTR_AC.V_LIL_PERIOD_2(
	CLIENT_ID,
	PERIOD_SID,
	PERIOD_ID,
	PERIOD_LVL,
	LIAM_AVBL_FG,
	LIFT_AVBL_FG,
	ACTIVE_FG,
	DWH_LOAD_ID,
	DWH_CREATED,
	DWH_UPDATED
) as
   SELECT
       client_id,
   period_sid,
   period_id,
   period_lvl,
   liam_avbl_fg,
   lift_avbl_fg,
   active_fg,
   dwh_load_id,
   dwh_created,
   dwh_updated
  FROM p_lew_process_mstr.t_lil_period_2 ;
