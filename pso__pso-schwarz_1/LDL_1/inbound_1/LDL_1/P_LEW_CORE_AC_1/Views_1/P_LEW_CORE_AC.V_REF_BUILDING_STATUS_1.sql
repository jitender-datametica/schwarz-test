create or replace view LDL_PRODUCTION.P_LEW_CORE_AC.V_REF_BUILDING_STATUS_1(
	CLIENT_ID,
	BUILDING_STATUS_ID,
	BUILDING_STATUS_DESCR,
	DWH_LOAD_ID,
	DWH_CREATED,
	DWH_UPDATED
) as
   SELECT
       client_id,
   building_status_id,
   building_status_descr,
   dwh_load_id,
   dwh_created,
   dwh_updated
  FROM p_lew_core.t_ref_building_status_1
;
