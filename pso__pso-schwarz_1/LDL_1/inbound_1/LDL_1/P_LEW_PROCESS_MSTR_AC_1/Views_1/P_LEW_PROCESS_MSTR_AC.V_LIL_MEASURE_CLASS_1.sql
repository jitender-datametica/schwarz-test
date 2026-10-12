create or replace view LDL_PRODUCTION.P_LEW_PROCESS_MSTR_AC.V_LIL_MEASURE_CLASS_1(
	MEAS_ID,
	CLASS_CD,
	DWH_LOAD_ID,
	DWH_CREATED,
	DWH_UPDATED
) as
   SELECT
       meas_id,
   class_cd,
   dwh_load_id,
   dwh_created,
   dwh_updated
  FROM p_lew_process_mstr.t_lil_measure_class_1 ;
