create or replace view LDL_PRODUCTION.P_LEW_BIL.V_ORG_ALL_STORE_MERGE(
	ASPECT_ID,
	CLIENT_ID,
	MOVE_TO_STORE_ID,
	MOVE_STORE_DESC,
	WH_ID,
	LOC_SID_WH,
	WH_ID_EXP,
	LOC_SID_WH_EXP,
	SALES_MANAGER_ID,
	DAT_CLOSING_OVIS,
	DAT_OPENING_OVIS,
	MIS_STORE_ACTIVE_FG,
	DAT_OPENING,
	DAT_CLOSING,
	ORIG_STORE_NR,
	DAT_CALC_START_PY,
	DAT_CALC_END_PY,
	OBJECTSTATUS_ID,
	DAT_CALC_START_PPY,
	MOVE_FG,
	STREET,
	ZIPCODE,
	CITY,
	PHONE,
	LONGITUDE,
	LATITUDE
) as	
   SELECT	
     osm.aspect_id,	
   osm.client_id,	
   osm.move_to_st_loc_sid            AS move_to_store_id,	
   osm.move_store_desc,	
   wh.src_wh_id                      AS wh_id,	
   wh.loc_sid_wh                     AS loc_sid_wh,	
   wh2.src_wh_id                     AS wh_id_exp,	
   wh2.loc_sid_wh                    AS loc_sid_wh_exp,	
   osm.sales_manager_id,	
   osm.dat_closing_ovis,	
   osm.dat_opening_ovis,	
   osm.mis_store_active_fg,	
   osm.dat_opening,	
   osm.dat_closing,	
   osm.orig_store_nr,	
   osm.dat_calc_start_py,	
   osm.dat_calc_end_py,	
   osm.objectstatus_id,	
   osm.dat_calc_start_ppy,	
   osm.move_fg,	
   osm.street,	
   osm.zipcode,	
   osm.city,	
   osm.phone,	
   osm.longitude,	
   osm.latitude	
  FROM p_lew_core_ac.v_wawi_org_all_store_merge_act AS osm	
   INNER JOIN p_lew_bil_ac.v_warehouse AS wh	
   ON osm.wh_loc_sid = wh.loc_sid_wh	
   AND osm.client_id = wh.client_id	
   AND wh.dwh_actual_fg = 1	
   INNER JOIN p_lew_bil_ac.v_warehouse AS wh2	
   ON osm.wh_loc_sid_exp = wh2.loc_sid_wh	
   AND osm.client_id = wh2.client_id	
   AND wh2.dwh_actual_fg = 1	
;
