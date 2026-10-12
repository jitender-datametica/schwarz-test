create or replace view LDL_PRODUCTION.P_LEW_PROCESS.V_WFM_LAST_EXPORT(
	PROCESS_NAME,
	PROCESS_SPECIFICATION,
	EXPORT_SPECIFICATION,
	LAST_EXPORT_TMSP,
	LAST_EXPORT_LOAD_ID,
	DWH_CREATED,
	DWH_UPDATED
) as
   SELECT
       v.process_name,
   v.process_specification,
   v.export_specification,
   v.last_export_tmsp,
   v.last_export_load_id,
   v.dwh_created,
   v.dwh_updated
  FROM p_lew_process.t_wfm_last_export AS v
;
