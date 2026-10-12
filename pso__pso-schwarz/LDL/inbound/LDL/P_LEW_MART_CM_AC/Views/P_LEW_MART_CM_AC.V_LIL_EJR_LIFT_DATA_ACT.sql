create or replace view LDL_PRODUCTION_CLONE_GOOGLE_20260608_1030.P_LEW_MART_CM_AC.V_LIL_EJR_LIFT_DATA_ACT(
	DATA_SRC_ID,
	CLIENT_ID,
	RTL_ID,
	RTL_LVL,
	PER_ID,
	PER_DESC,
	PER_DESC_EN,
	PY_PER_DESC,
	PY_PER_DESC_EN,
	LIFT_CAT_ID,
	PROM_ID,
	CURRENCY_ISO_CD,
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
   , per_id
   , per_desc
   , per_desc_EN
   , py_per_desc
   , py_per_desc_EN
   , lift_cat_id
   , prom_id
   , currency_iso_cd
   , meas_id
   , val
   , py_val
   , count_customer
   , count_customer_py
   , prot_fg
FROM P_LEW_MART_CM.V_LIL_EJR_LIFT_DATA_ACT ;
