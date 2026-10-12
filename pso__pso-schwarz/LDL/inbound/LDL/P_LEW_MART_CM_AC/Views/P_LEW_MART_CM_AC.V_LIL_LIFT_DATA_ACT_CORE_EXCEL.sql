create or replace view LDL_PRODUCTION_CLONE_GOOGLE_20260608_1030.P_LEW_MART_CM_AC.V_LIL_LIFT_DATA_ACT_CORE_EXCEL(
	CLIENT_ID,
	RTL_ID,
	RTL_LVL,
	PER_ID,
	PERIOD_YEAR,
	LIFT_CAT_ID,
	PROM_ID,
	RAW_BUYER_ID,
	CURRENCY_ISO_CD,
	MEAS_ID,
	TURNOVER_VAL,
	TURNOVER_CATEGORY_VAL,
	POT_TURNOVER_VAL,
	TRIP_CNT,
	BUYER_CNT,
	POT_BUYER_CNT,
	HOUSEHOLD_IN_COUNTRY_CNT,
	SPEND_PER_TRIP_VAL,
	SPEND_PER_BUYER_VAL,
	BUY_FREQ,
	BUYER_QUALITY,
	LIDL_BUYER_TURNOVER_VAL,
	TURNOVER_VAL_PY,
	POT_TURNOVER_VAL_PY,
	TURNOVER_CATEGORY_VAL_PY,
	TRIP_CNT_PY,
	BUYER_CNT_PY,
	POT_BUYER_CNT_PY,
	HOUSEHOLD_IN_COUNTRY_CNT_PY,
	SPEND_PER_TRIP_VAL_PY,
	SPEND_PER_BUYER_VAL_PY,
	BUY_FREQ_PY,
	BUYER_QUALITY_PY,
	LIDL_BUYER_TURNOVER_VAL_PY,
	LOYALTY_PCT,
	LOYALTY_PCT_PY,
	CATEGORY_LIDL_VAL,
	CATEGORY_LIDL_VAL_PY,
	MAT_LATEST_FG,
	PER_DESC,
	PER_DESC_EN,
	PY_PER_DESC,
	PY_PER_DESC_EN,
	PROT_FG,
	ACTIVE_FG,
	APPLICATION_ID
) as
SELECT
  client_id
, rtl_id
, rtl_lvl
, per_id
, period_year
, lift_cat_id
, prom_id
, raw_buyer_id
, currency_iso_cd
, meas_id
, turnover_val
, turnover_category_val
, pot_turnover_val
, trip_cnt
, buyer_cnt
, pot_buyer_cnt
, household_in_country_cnt
, spend_per_trip_val
, spend_per_buyer_val
, buy_freq
, buyer_quality
, lidl_buyer_turnover_val
, turnover_val_py
, pot_turnover_val_py
, turnover_category_val_py
, trip_cnt_py
, buyer_cnt_py
, pot_buyer_cnt_py
, household_in_country_cnt_py
, spend_per_trip_val_py
, spend_per_buyer_val_py
, buy_freq_py
, buyer_quality_py
, lidl_buyer_turnover_val_py
, loyalty_pct
, loyalty_pct_py
, category_lidl_val
, category_lidl_val_py
, mat_latest_fg
, per_desc
, per_desc_EN
, py_per_desc
, py_per_desc_EN
, prot_fg
, active_fg
, application_id
FROM P_LEW_MART_CM.V_LIL_LIFT_DATA_ACT_CORE_EXCEL 
;
