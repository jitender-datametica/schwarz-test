create or replace view LDL_PRODUCTION.P_LEW_CORE_AC.V_LOCATION_BUILDING_HIST_2(
	CLIENT_ID,
	LOC_SID,
	BUILDING_SID,
	DELETED_FG,
	DWH_VALID_FROM,
	DWH_VALID_TO,
	DWH_LOAD_ID,
	DWH_CREATED,
	DWH_UPDATED
) as
   SELECT
       v.client_id,
   v.loc_sid,
   v.building_sid,
   v.deleted_fg,
   v.dwh_valid_from,
   v.dwh_valid_to,
   v.dwh_load_id,
   v.dwh_created,
   v.dwh_updated
  FROM p_lew_core.t_location_building_hist_2 AS v
;
