create or replace view LDL_PRODUCTION.P_LEW_PROCESS_MSTR_AC.V_LIL_REGISTRY_FILES(
	FILE_ID,
	FILE_NAME,
	INTERFACE_NAME,
	DATA_PROVIDER,
	DELIVERY_CD,
	CHECKSUM,
	PROCESSING_TS,
	COMMAND,
	NOTE,
	STATUS,
	DWH_LOAD_ID,
	DWH_CREATED,
	DWH_UPDATED
) as
   SELECT
       file_id,
   file_name,
   interface_name,
   data_provider,
   delivery_cd,
   checksum,
   processing_ts,
   command,
   note,
   status,
   dwh_load_id,
   dwh_created,
   dwh_updated
  FROM p_lew_process_mstr.t_lil_registry_files ;
