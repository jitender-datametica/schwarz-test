create or replace view LDL_PRODUCTION.P_LEW_PROCESS_MSTR_AC.V_LIL_REGION_PER_LATEST(
	CLIENT_ID,
	REGION_SID,
	PER_TP_ID,
	CLASS_CD,
	LTST_PER_ID,
	DWH_LOAD_ID,
	DWH_CREATED,
	DWH_UPDATED
) as
     SELECT
         client_id,
     region_sid,
     per_tp_id,
     class_cd,
     ltst_per_id,
     dwh_load_id,
     dwh_created,
     dwh_updated
 FROM p_lew_process_mstr.t_lil_region_per_latest ;
