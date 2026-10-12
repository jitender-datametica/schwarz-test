create or replace view LDL_PRODUCTION.P_LEW_CORE_AC.V_REF_PICK_AREA_DESCR(
	CLIENT_ID,
	LOC_SID,
	LANG_SID,
	LANG_CD,
	PICK_AREA_ID,
	PICK_AREA_DESCR,
	PICK_MAIN_AREA_ID,
	PICK_MAIN_AREA_DESCR,
	DWH_LOAD_ID,
	DWH_CREATED,
	DWH_UPDATED
) as
   SELECT
       client_id,
   loc_sid,
   lang_sid,
   lang_cd,
   pick_area_id,
   pick_area_descr,
   pick_main_area_id,
   pick_main_area_descr,
   dwh_load_id,
   dwh_created,
   dwh_updated
  FROM p_lew_core.t_ref_pick_area_descr
;
