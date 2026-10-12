create or replace view LDL_PRODUCTION.P_LEW_CORE_AC.V_BUILDING_REPLACEMENT_1(
	CLIENT_ID,
	BUILDING_SID,
	BUILDING_SID_SUCCESSOR,
	DELETED_FG,
	DWH_LOAD_ID,
	DWH_CREATED,
	DWH_UPDATED
) as
   SELECT
       client_id,
   building_sid,
   building_sid_successor,
   deleted_fg,
   dwh_load_id,
   dwh_created,
   dwh_updated
  FROM p_lew_core.t_building_replacement_1
;
