create or replace view LDL_PRODUCTION_CLONE_GOOGLE_20260608_1030.P_LEW_MART_LEAD.V_MISS_ITM_STORE_DAY_ASIS_2(
	CLIENT_ID,
	LOC_SID_STORE,
	ITEM_SID,
	WH_LOC_SID,
	DAT_FORMDATE
) as
SELECT 
	asis.client_id
	, asis.loc_sid_store
	, asis.item_sid
	, org.loc_sid_wh AS wh_loc_sid
	, asis.dat_formdate
	--, asis.cy_month -- All five columns are obsolete. These have been removed in the underlying table on 22.03.2022.
	--, asis.cy_partial_week_id
	--, asis.cy_week
	--, asis.busyear
	--, asis.miss_item_fg
FROM p_lew_mart_lead.t_miss_itm_store_day_asis_2 asis
	INNER JOIN p_lew_bil_ac.v_org_store_merge_2 AS org
		ON asis.client_id = org.client_id
			AND asis.loc_sid_store = org.loc_sid_store
			AND org.aspect_id = 1
	INNER JOIN (
		SELECT client_id
			, loc_sid AS wh_loc_sid
			, item_sid
			, dwh_valid_from
			, dwh_valid_to
		FROM p_lew_core_ac.v_item_info_per_location_hist_2
		WHERE item_status_cd IN ('40', '45', '50', 'S1', 'S4')
		UNION ALL
		SELECT client_id
			, wh_loc_sid
			, item_sid
			, dat_rec_start AS dwh_valid_from
			, dat_rec_end AS dwh_valid_to
		FROM p_lew_core_ac.v_wawi_itm_item_wh_2
		WHERE item_status IN (7, 8, 9)
		) wh
		ON asis.client_id = wh.client_id
			AND org.loc_sid_wh = wh.wh_loc_sid
			AND asis.item_sid = wh.item_sid
			AND asis.dat_formdate BETWEEN wh.dwh_valid_from AND wh.dwh_valid_to
;
