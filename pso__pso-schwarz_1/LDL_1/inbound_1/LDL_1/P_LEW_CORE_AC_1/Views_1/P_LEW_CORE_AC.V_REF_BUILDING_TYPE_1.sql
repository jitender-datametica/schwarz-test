create or replace view LDL_PRODUCTION.P_LEW_CORE_AC.V_REF_BUILDING_TYPE_1(
	CLIENT_ID,
	BUILDING_TYPE_ID,
	BUILDING_TYPE_DESCR,
	DWH_LOAD_ID,
	DWH_CREATED,
	DWH_UPDATED
) as
   SELECT
       client_id,
   building_type_id,
   building_type_descr,
   dwh_load_id,
   dwh_created,
   dwh_updated
  FROM p_lew_core.t_ref_building_type_1
;
