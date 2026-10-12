create or replace dynamic table LDL_PRODUCTION.P_LEW_MART_LEAD.V_ORG_STORE_MERGE_2(
	STORE_ID,
	CLIENT_ID,
	COUNTRY_CD,
	DAT_OPENING,
	DAT_REAL_OPENING,
	DAT_CLOSING,
	DAT_VALID_FROM,
	REGION_CD,
	OBJECT_NR,
	LICENCE_NR,
	PST_LANG_CD,
	MDE_PRINT_CD,
	CLOSED_FG,
	MDE_LANG_CD,
	ORD_UNIT_VALID_STORE_CD,
	TEST_STORE_FG,
	TRANSFER_FG,
	STORE_DESC,
	ORIG_STORE_NR,
	WH_ID,
	LOC_SID_WH,
	CNT_OPEN_DAYS,
	QTY_MIN_DFLT,
	DAT_CALC_START_PY,
	DAT_CALC_END_PY,
	DAT_CALC_START_PPY,
	DAT_OPENING_OVIS,
	DAT_CLOSING_OVIS,
	OBJECTSTATUS_ID,
	MIS_STORE_ACTIVE_FG,
	MOVE_TO_STORE_ID,
	MOVE_FG,
	ASPECT_ID
) target_lag = '1 hour, 30 minutes' refresh_mode = FULL initialize = ON_CREATE warehouse = WH_LDL_P_DYNAMIC_TABLE_P_LEW_MART_LEAD
 as
SELECT
  osm.loc_sid_store           AS store_id
 ,osm.client_id
 ,osm.country_cd
 ,osm.dat_opening
 ,osm.dat_real_opening
 ,osm.dat_closing
 ,osm.dat_valid_from
 ,osm.region_cd
 ,osm.object_nr
 ,osm.licence_nr
 ,osm.pst_lang_cd
 ,osm.mde_print_cd
 ,osm.closed_fg
 ,osm.mde_lang_cd
 ,osm.ord_unit_valid_store_cd
 ,osm.test_store_fg
 ,osm.transfer_fg
 ,osm.store_desc
 ,osm.src_orig_store_nr       AS orig_store_nr
 ,wh.src_wh_id                AS wh_id
 ,wh.loc_sid_wh
 ,osm.cnt_open_days
 ,osm.qty_min_dflt
 ,osm.dat_calc_start_py
 ,osm.dat_calc_end_py
 ,osm.dat_calc_start_ppy
 ,osm.dat_opening_ovis
 ,osm.dat_closing_ovis
 ,osm.objectstatus_id
 ,osm.mis_store_active_fg
 ,osm.loc_sid_store_move_to   AS move_to_store_id
 ,osm.move_fg
 ,osm.aspect_id
FROM p_lew_bil_ac.v_org_store_merge_2 AS osm
INNER JOIN p_lew_bil_ac.v_warehouse_2 AS wh
ON osm.loc_sid_wh = wh.loc_sid_wh
AND osm.client_id = wh.client_id
AND wh.dwh_actual_fg = 1
/* analog MART_MSI */
WHERE NOT(osm.client_id IN (18) AND (osm.src_orig_store_nr BETWEEN 7501 AND 7599 OR osm.src_orig_store_nr=9988))
;
