create or replace view LDL_PRODUCTION.P_LEW_CORE_AC.V_LIL_PERIOD_2(
	CLIENT_ID,
	PERIOD_SID,
	SRC_PERIOD_CD,
	PERIOD_NAME,
	PERIOD_TYPE_ID,
	PERIOD_TYPE_NAME,
	PERIOD_YEAR,
	PERIOD_SID_PY,
	PERIOD_SID_PQ,
	DWH_LOAD_ID,
	DWH_CREATED,
	DWH_UPDATED
) as
   SELECT
       client_id,
   period_sid,
   src_period_cd,
   period_name,
   period_type_id,
   period_type_name,
   period_year,
   period_sid_py,
   period_sid_pq,
   dwh_load_id,
   dwh_created,
   dwh_updated
  FROM p_lew_core.t_lil_period_2 ;
