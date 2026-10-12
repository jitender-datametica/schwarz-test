create or replace view LDL_PRODUCTION.P_LEW_PROCESS_MSTR_AC.V_LIL_PERIOD_TYPE_1(
	PERIOD_TYPE_ID,
	PERIOD_TYPE_DESC,
	LTST_PSEUDO_PERIOD_ID,
	DWH_LOAD_ID,
	DWH_CREATED,
	DWH_UPDATED
) as
     SELECT
         period_type_id,
     period_type_desc,
     ltst_pseudo_period_id,
     dwh_load_id,
     dwh_created,
     dwh_updated
 FROM p_lew_process_mstr.t_lil_period_type_1 ;
