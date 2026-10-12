CREATE OR REPLACE VIEW ldl_p_lew_mart_cm_ac.v_lil_lift_data_act_core_excel(
	client_id,
	rtl_id,
	rtl_lvl,
	per_id,
	period_year,
	lift_cat_id,
	prom_id,
	raw_buyer_id,
	currency_iso_cd,
	meas_id,
	turnover_val,
	turnover_category_val,
	pot_turnover_val,
	trip_cnt,
	buyer_cnt,
	pot_buyer_cnt,
	household_in_country_cnt,
	spend_per_trip_val,
	spend_per_buyer_val,
	buy_freq,
	buyer_quality,
	lidl_buyer_turnover_val,
	turnover_val_py,
	pot_turnover_val_py,
	turnover_category_val_py,
	trip_cnt_py,
	buyer_cnt_py,
	pot_buyer_cnt_py,
	household_in_country_cnt_py,
	spend_per_trip_val_py,
	spend_per_buyer_val_py,
	buy_freq_py,
	buyer_quality_py,
	lidl_buyer_turnover_val_py,
	loyalty_pct,
	loyalty_pct_py,
	category_lidl_val,
	category_lidl_val_py,
	mat_latest_fg,
	per_desc,
	per_desc_en,
	py_per_desc,
	py_per_desc_en,
	prot_fg,
	active_fg,
	application_id
) AS
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
FROM ldl_p_lew_mart_cm.v_lil_lift_data_act_core_excel 
;