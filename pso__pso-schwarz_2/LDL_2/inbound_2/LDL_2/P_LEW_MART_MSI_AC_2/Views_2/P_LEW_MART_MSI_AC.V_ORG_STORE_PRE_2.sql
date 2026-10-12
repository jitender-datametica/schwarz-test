create or replace view LDL_PRODUCTION.P_LEW_MART_MSI_AC.V_ORG_STORE_PRE_2(
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
	CNT_OPEN_DAYS,
	QTY_MIN_DFLT,
	DAT_CALC_START_PY,
	DAT_CALC_END_PY,
	DAT_CALC_START_PPY,
	DAT_CALC_END_PPY,
	DAT_CALC_START_PPPY,
	DAT_CALC_END_PPPY,
	DAT_OPENING_OVIS,
	DAT_CLOSING_OVIS,
	DAT_OPENING_OVIS_MOVE,
	DAT_CLOSING_OVIS_MOVE,
	OBJECTSTATUS_ID,
	MIS_STORE_ACTIVE_FG,
	MOVE_TO_STORE_ID,
	MOVE_FG
) as
   SELECT
    store_id
    , client_id
    , country_cd
    , dat_opening
    , dat_real_opening
    , dat_closing
    , dat_valid_from
    , region_cd
    , object_nr
    , licence_nr
    , pst_lang_cd
    , mde_print_cd
    , closed_fg
    , mde_lang_cd
    , ord_unit_valid_store_cd
    , test_store_fg
    , transfer_fg
    , store_desc
    , orig_store_nr
    , wh_id
    , cnt_open_days
    , qty_min_dflt
    , dat_calc_start_py
    , dat_calc_end_py
    , dat_calc_start_ppy
    , dat_calc_end_ppy
    , dat_calc_start_pppy
    , dat_calc_end_pppy
    , dat_opening_ovis
    , dat_closing_ovis
    , dat_opening_ovis_move
    , dat_closing_ovis_move
    , objectstatus_id
    , mis_store_active_fg
    , move_to_store_id
    , move_fg
   FROM p_lew_mart_msi.v_org_store_pre_2;
