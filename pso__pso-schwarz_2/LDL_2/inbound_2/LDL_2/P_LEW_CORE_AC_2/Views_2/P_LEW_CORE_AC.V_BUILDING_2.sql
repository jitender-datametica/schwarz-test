create or replace view LDL_PRODUCTION.P_LEW_CORE_AC.V_BUILDING_2(
	CLIENT_ID,
	BUILDING_SID,
	SRC_OBJECT_NO,
	BUILDING_TYPE_ID,
	BUILDING_NAME,
	DWH_LOAD_ID,
	DWH_CREATED,
	DWH_UPDATED
) as
   SELECT
       v.client_id,
   v.building_sid,
   v.src_object_no,
   v.building_type_id,
   v.building_name,
   v.dwh_load_id,
   v.dwh_created,
   v.dwh_updated
  FROM p_lew_core.t_building_2 AS v
;
