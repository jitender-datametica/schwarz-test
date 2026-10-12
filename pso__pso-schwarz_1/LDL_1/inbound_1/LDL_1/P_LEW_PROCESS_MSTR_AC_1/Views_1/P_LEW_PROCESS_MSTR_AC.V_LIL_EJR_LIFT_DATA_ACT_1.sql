create or replace view LDL_PRODUCTION_CLONE_GOOGLE_20260608_1030.P_LEW_PROCESS_MSTR_AC.V_LIL_EJR_LIFT_DATA_ACT_1(
	DATA_SRC_ID,
	CLIENT_ID,
	RTL_ID,
	RTL_LVL,
	PERIOD_ID,
	PERIOD_SID,
	PERIOD_NAME,
	PERIOD_NAME_PY,
	GFK_CAT_ID,
	PROMOTION_BRAND_ID,
	CURR_CD,
	MEAS_ID,
	VAL,
	PY_VAL,
	COUNT_CUSTOMER,
	COUNT_CUSTOMER_PY,
	PROT_FG
) as	
SELECT
    data_src_id
    , client_id
    , rtl_id
    , rtl_lvl
    , period_id
    , period_sid
    , period_name
    , period_name_py
    , gfk_cat_id
    , promotion_brand_id
    , curr_cd
    , meas_id
    , val
    , py_val
	, count_customer
	, count_customer_py
    , prot_fg
FROM P_LEW_PROCESS_MSTR.T_LIL_EJR_LIFT_DATA_ACT_1 ;
