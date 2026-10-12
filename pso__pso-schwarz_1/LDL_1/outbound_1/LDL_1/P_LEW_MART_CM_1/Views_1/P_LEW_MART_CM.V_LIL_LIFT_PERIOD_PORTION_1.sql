CREATE OR REPLACE VIEW ldl_p_lew_mart_cm.v_lil_lift_period_portion_1 (client_id, per_id, lift_cat_id, rtl_id, rtl_lvl,
prom_id, period_portion_id, currency_iso_cd, household_in_country_cnt, turnover_val, pot_turnover_val,
household_penetrate_pct, buyer_cnt, pot_buyer_cnt, trip_cnt, buy_freq, spend_per_buyer_val, spend_per_trip_val,
category_lidl_val, pot_turnover_exploit_pct, loyalty_pct, closure_rate_pct, buyer_quality, lidl_market_share_pct,
py_household_in_country_cnt, py_turnover_val, py_pot_turnover_val, py_household_penetrate_pct, py_buyer_cnt,
py_pot_buyer_cnt, py_trip_cnt, py_buy_freq, py_spend_per_buyer_val, py_spend_per_trip_val, py_category_lidl_val,
py_pot_turnover_exploit_pct, py_loyalty_pct, py_closure_rate_pct, py_buyer_quality, py_lidl_market_share_pct,
raw_buyer_id, per_desc, per_desc_en, py_per_desc, py_per_desc_en) AS SELECT REG.region_id AS client_id,
 PER.period_id AS per_id,
 GFK.gfk_cat_id AS lift_cat_id,
 RTL.rtl_id,
 CAST(CASE
   WHEN RTLPER.retailer_sid_parent IS NOT NULL
   THEN 15
   ELSE RTL.rtl_lvl
   END AS BIGNUMERIC) AS rtl_lvl,
 DT.promotion_brand_id AS prom_id,
 DT.period_portion_id,
 CERDT.to_currency_iso_cd AS currency_iso_cd,
 ROUND(CAST(DT.household_in_country_cnt / 1000 AS NUMERIC), 5) AS household_in_country_cnt,
 CAST(DT.turnover_val * CERDT.rate_currency_exchange / 1000 AS NUMERIC) AS turnover_val,
 CAST(DT.pot_turnover_val * CERDT.rate_currency_exchange / 1000 AS NUMERIC) AS pot_turnover_val,
 DT.household_penetrate_pct,
 ROUND(CAST(DT.buyer_cnt / 1000 AS NUMERIC), 5) AS buyer_cnt,
 ROUND(CAST(DT.pot_buyer_cnt / 1000 AS NUMERIC), 5) AS pot_buyer_cnt,
 ROUND(CAST(DT.trip_cnt / 1000 AS NUMERIC), 5) AS trip_cnt,
 DT.buy_freq,
 ROUND(CAST(DT.spend_per_buyer_val * CERDT.rate_currency_exchange AS NUMERIC), 5) AS spend_per_buyer_val,
 ROUND(CAST(DT.spend_per_trip_val * CERDT.rate_currency_exchange AS NUMERIC), 5) AS spend_per_trip_val,
 CAST(DT.category_lidl_val * CERDT.rate_currency_exchange / 1000 AS NUMERIC) AS category_lidl_val,
 DT.pot_turnover_exploit_pct,
 DT.loyalty_pct,
 DT.closure_rate_pct,
 DT.buyer_quality,
 DT.lidl_market_share_pct,
 ROUND(CAST(PY.household_in_country_cnt / 1000 AS NUMERIC), 5) AS py_household_in_country_cnt,
 CAST(PY.turnover_val * CERPY.rate_currency_exchange / 1000 AS NUMERIC) AS py_turnover_val,
 CAST(PY.pot_turnover_val * CERPY.rate_currency_exchange / 1000 AS NUMERIC) AS py_pot_turnover_val,
 PY.household_penetrate_pct AS py_household_penetrate_pct,
 ROUND(CAST(PY.buyer_cnt / 1000 AS NUMERIC), 5) AS py_buyer_cnt,
 ROUND(CAST(PY.pot_buyer_cnt / 1000 AS NUMERIC), 5) AS py_pot_buyer_cnt,
 ROUND(CAST(PY.trip_cnt / 1000 AS NUMERIC), 5) AS py_trip_cnt,
 PY.buy_freq AS py_buy_freq,
 ROUND(CAST(PY.spend_per_buyer_val * CERPY.rate_currency_exchange AS NUMERIC), 5) AS py_spend_per_buyer_val,
 ROUND(CAST(PY.spend_per_trip_val * CERPY.rate_currency_exchange AS NUMERIC), 5) AS py_spend_per_trip_val,
 CAST(PY.category_lidl_val * CERPY.rate_currency_exchange / 1000 AS NUMERIC) AS py_category_lidl_val,
 PY.pot_turnover_exploit_pct AS py_pot_turnover_exploit_pct,
 PY.loyalty_pct AS py_loyalty_pct,
 PY.closure_rate_pct AS py_closure_rate_pct,
 PY.buyer_quality AS py_buyer_quality,
 PY.lidl_market_share_pct AS py_lidl_market_share_pct,
 CAST(TRUNC(CASE
    WHEN DT.data_confidence_fg = 1
    THEN 101
    ELSE 0
    END) AS BIGNUMERIC) AS raw_buyer_id,
 CAST(COALESCE(DSDE.period_name, CPER.period_name) AS STRING) AS per_desc,
 CAST(COALESCE(DSEN.period_name, CPER.period_name) AS STRING) AS per_desc_en,
 CAST(COALESCE(PYDSDE.period_name, PYPER.period_name) AS STRING) AS py_per_desc,
 CAST(COALESCE(PYDSEN.period_name, PYPER.period_name) AS STRING) AS py_per_desc_en
FROM ldl_p_lew_core_ac.v_market_period_portion_1 AS DT
 INNER JOIN ldl_p_lew_process_mstr_ac.v_lil_region_1 AS REG ON DT.region_sid = REG.region_sid
 INNER JOIN ldl_p_lew_process_mstr_ac.v_lil_period_1 AS PER ON DT.client_id = PER.client_id AND DT.period_sid = PER.period_sid
   
 INNER JOIN ldl_p_lew_core_ac.v_lil_period_1 AS CPER ON PER.client_id = CPER.client_id AND PER.period_sid = CPER.period_sid
   
 INNER JOIN ldl_p_lew_core_ac.v_lil_period_1 AS PYPER ON CPER.client_id = PYPER.client_id AND CPER.period_sid_py = PYPER.period_sid
   
 INNER JOIN ldl_p_lew_mart_cm.v_lil_currency_exch_rt_1 AS CERDT ON DT.curr_cd = CERDT.from_currency_iso_cd
 LEFT JOIN ldl_p_lew_core_ac.v_market_period_portion_1 AS PY ON DT.client_id = PY.client_id AND DT.region_sid = PY.region_sid
          AND CPER.period_sid_py = PY.period_sid AND DT.gfk_cat_sid = PY.gfk_cat_sid AND DT.retailer_sid = PY.retailer_sid
       AND DT.promotion_brand_id = PY.promotion_brand_id AND DT.period_portion_id = PY.period_portion_id AND DT.curr_cd
   = PY.curr_cd
 LEFT JOIN ldl_p_lew_mart_cm.v_lil_currency_exch_rt_1 AS CERPY ON PY.curr_cd = CERPY.from_currency_iso_cd AND CERDT.to_currency_iso_cd
    = CERPY.to_currency_iso_cd
 LEFT JOIN ldl_p_lew_core_ac.v_lil_period_descr_1 AS DSDE ON CPER.period_sid = DSDE.period_sid AND DSDE.lang_cd = 'DE'
 LEFT JOIN ldl_p_lew_core_ac.v_lil_period_descr_1 AS DSEN ON CPER.period_sid = DSEN.period_sid AND DSEN.lang_cd = 'EN'
 LEFT JOIN ldl_p_lew_core_ac.v_lil_period_descr_1 AS PYDSDE ON PYPER.period_sid = PYDSDE.period_sid AND PYDSDE.lang_cd =
   'DE'
 LEFT JOIN ldl_p_lew_core_ac.v_lil_period_descr_1 AS PYDSEN ON PYPER.period_sid = PYDSEN.period_sid AND PYDSEN.lang_cd =
   'EN'
 LEFT JOIN ldl_p_lew_core_ac.v_lil_retailer_period_1 AS RTLPER ON DT.client_id = RTLPER.client_id AND DT.retailer_sid =
      RTLPER.retailer_sid AND DT.period_sid = RTLPER.period_sid AND RTLPER.deleted_fg = 0 AND RTLPER.interface_name =
   'LIFT_FMCG_Period_Portion'
 INNER JOIN ldl_p_lew_process_mstr_ac.v_lil_gfk_category_1 AS GFK ON DT.client_id = GFK.client_id AND DT.gfk_cat_sid = GFK
   .gfk_cat_sid
 INNER JOIN ldl_p_lew_process_mstr_ac.v_lil_region_retailer_1 AS RTL ON DT.retailer_sid = RTL.retailer_sid AND DT.region_sid
    = RTL.region_sid
 LEFT JOIN (SELECT client_id,
   region_sid,
   period_sid
  FROM ldl_p_lew_process_mstr_ac.v_lil_data_mask_1 AS DM
  WHERE interface_name = 'LIFT_FMCG_Period_Portion'
   AND mask_data_fg = 1) AS dtm ON DT.client_id = dtm.client_id AND DT.region_sid = dtm.region_sid AND DT.period_sid =
   dtm.period_sid
WHERE COALESCE(DT.deleted_fg, 0) = 0
 AND dtm.client_id IS NULL
UNION ALL
SELECT REG.region_id AS client_id,
 PTP.ltst_pseudo_period_id AS per_id,
 GFK.gfk_cat_id AS lift_cat_id,
 RTL.rtl_id,
 CAST(CASE
   WHEN RTLPER.retailer_sid_parent IS NOT NULL
   THEN 15
   ELSE RTL.rtl_lvl
   END AS BIGNUMERIC) AS rtl_lvl,
 DT.promotion_brand_id AS prom_id,
 DT.period_portion_id,
 CERDT.to_currency_iso_cd AS currency_iso_cd,
 ROUND(CAST(DT.household_in_country_cnt / 1000 AS NUMERIC), 5) AS household_in_country_cnt,
 CAST(DT.turnover_val * CERDT.rate_currency_exchange / 1000 AS NUMERIC) AS turnover_val,
 CAST(DT.pot_turnover_val * CERDT.rate_currency_exchange / 1000 AS NUMERIC) AS pot_turnover_val,
 DT.household_penetrate_pct,
 ROUND(CAST(DT.buyer_cnt / 1000 AS NUMERIC), 5) AS buyer_cnt,
 ROUND(CAST(DT.pot_buyer_cnt / 1000 AS NUMERIC), 5) AS pot_buyer_cnt,
 ROUND(CAST(DT.trip_cnt / 1000 AS NUMERIC), 5) AS trip_cnt,
 DT.buy_freq,
 ROUND(CAST(DT.spend_per_buyer_val * CERDT.rate_currency_exchange AS NUMERIC), 5) AS spend_per_buyer_val,
 ROUND(CAST(DT.spend_per_trip_val * CERDT.rate_currency_exchange AS NUMERIC), 5) AS spend_per_trip_val,
 CAST(DT.category_lidl_val * CERDT.rate_currency_exchange / 1000 AS NUMERIC) AS category_lidl_val,
 DT.pot_turnover_exploit_pct,
 DT.loyalty_pct,
 DT.closure_rate_pct,
 DT.buyer_quality,
 DT.lidl_market_share_pct,
 ROUND(CAST(PY.household_in_country_cnt / 1000 AS NUMERIC), 5) AS py_household_in_country_cnt,
 CAST(PY.turnover_val * CERPY.rate_currency_exchange / 1000 AS NUMERIC) AS py_turnover_val,
 CAST(PY.pot_turnover_val * CERPY.rate_currency_exchange / 1000 AS NUMERIC) AS py_pot_turnover_val,
 PY.household_penetrate_pct AS py_household_penetrate_pct,
 ROUND(CAST(PY.buyer_cnt / 1000 AS NUMERIC), 5) AS py_buyer_cnt,
 ROUND(CAST(PY.pot_buyer_cnt / 1000 AS NUMERIC), 5) AS py_pot_buyer_cnt,
 ROUND(CAST(PY.trip_cnt / 1000 AS NUMERIC), 5) AS py_trip_cnt,
 PY.buy_freq AS py_buy_freq,
 ROUND(CAST(PY.spend_per_buyer_val * CERPY.rate_currency_exchange AS NUMERIC), 5) AS py_spend_per_buyer_val,
 ROUND(CAST(PY.spend_per_trip_val * CERPY.rate_currency_exchange AS NUMERIC), 5) AS py_spend_per_trip_val,
 CAST(PY.category_lidl_val * CERPY.rate_currency_exchange / 1000 AS NUMERIC) AS py_category_lidl_val,
 PY.pot_turnover_exploit_pct AS py_pot_turnover_exploit_pct,
 PY.loyalty_pct AS py_loyalty_pct,
 PY.closure_rate_pct AS py_closure_rate_pct,
 PY.buyer_quality AS py_buyer_quality,
 PY.lidl_market_share_pct AS py_lidl_market_share_pct,
 CAST(TRUNC(CASE
    WHEN DT.data_confidence_fg = 1
    THEN 101
    ELSE 0
    END) AS BIGNUMERIC) AS raw_buyer_id,
 CAST(COALESCE(DSDE.period_name, CPER.period_name) AS STRING) AS per_desc,
 CAST(COALESCE(DSEN.period_name, CPER.period_name) AS STRING) AS per_desc_en,
 CAST(COALESCE(PYDSDE.period_name, PYPER.period_name) AS STRING) AS py_per_desc,
 CAST(COALESCE(PYDSEN.period_name, PYPER.period_name) AS STRING) AS py_per_desc_en
FROM ldl_p_lew_core_ac.v_market_period_portion_1 AS DT
 INNER JOIN ldl_p_lew_process_mstr_ac.v_lil_region_1 AS REG ON DT.region_sid = REG.region_sid
 INNER JOIN ldl_p_lew_process_mstr_ac.v_lil_period_1 AS PER ON DT.client_id = PER.client_id AND DT.period_sid = PER.period_sid
   
 INNER JOIN ldl_p_lew_core_ac.v_lil_period_1 AS CPER ON PER.client_id = CPER.client_id AND PER.period_sid = CPER.period_sid
   
 INNER JOIN ldl_p_lew_process_mstr_ac.v_lil_region_per_latest_1 AS RPL ON DT.client_id = RPL.client_id AND DT.region_sid =
     RPL.region_sid AND RPL.class_cd = 'LIFTPP' AND PER.period_id = RPL.ltst_per_id
 INNER JOIN ldl_p_lew_process_mstr_ac.v_lil_period_type_1 AS PTP ON RPL.per_tp_id = PTP.period_type_id AND PTP.ltst_pseudo_period_id
  IS NOT NULL
 INNER JOIN ldl_p_lew_core_ac.v_lil_period_1 AS PYPER ON CPER.client_id = PYPER.client_id AND CPER.period_sid_py = PYPER.period_sid
   
 INNER JOIN ldl_p_lew_mart_cm.v_lil_currency_exch_rt_1 AS CERDT ON DT.curr_cd = CERDT.from_currency_iso_cd
 LEFT JOIN ldl_p_lew_core_ac.v_market_period_portion_1 AS PY ON DT.client_id = PY.client_id AND DT.region_sid = PY.region_sid
          AND CPER.period_sid_py = PY.period_sid AND DT.gfk_cat_sid = PY.gfk_cat_sid AND DT.retailer_sid = PY.retailer_sid
       AND DT.promotion_brand_id = PY.promotion_brand_id AND DT.period_portion_id = PY.period_portion_id AND DT.curr_cd
   = PY.curr_cd
 LEFT JOIN ldl_p_lew_mart_cm.v_lil_currency_exch_rt_1 AS CERPY ON PY.curr_cd = CERPY.from_currency_iso_cd AND CERDT.to_currency_iso_cd
    = CERPY.to_currency_iso_cd
 LEFT JOIN ldl_p_lew_core_ac.v_lil_period_descr_1 AS DSDE ON CPER.period_sid = DSDE.period_sid AND DSDE.lang_cd = 'DE'
 LEFT JOIN ldl_p_lew_core_ac.v_lil_period_descr_1 AS DSEN ON CPER.period_sid = DSEN.period_sid AND DSEN.lang_cd = 'EN'
 LEFT JOIN ldl_p_lew_core_ac.v_lil_period_descr_1 AS PYDSDE ON PYPER.period_sid = PYDSDE.period_sid AND PYDSDE.lang_cd =
   'DE'
 LEFT JOIN ldl_p_lew_core_ac.v_lil_period_descr_1 AS PYDSEN ON PYPER.period_sid = PYDSEN.period_sid AND PYDSEN.lang_cd =
   'EN'
 LEFT JOIN ldl_p_lew_core_ac.v_lil_retailer_period_1 AS RTLPER ON DT.client_id = RTLPER.client_id AND DT.retailer_sid =
      RTLPER.retailer_sid AND DT.period_sid = RTLPER.period_sid AND RTLPER.deleted_fg = 0 AND RTLPER.interface_name =
   'LIFT_FMCG_Period_Portion'
 INNER JOIN ldl_p_lew_process_mstr_ac.v_lil_gfk_category_1 AS GFK ON DT.client_id = GFK.client_id AND DT.gfk_cat_sid = GFK
   .gfk_cat_sid
 INNER JOIN ldl_p_lew_process_mstr_ac.v_lil_region_retailer_1 AS RTL ON DT.retailer_sid = RTL.retailer_sid AND DT.region_sid
    = RTL.region_sid
 LEFT JOIN (SELECT client_id,
   region_sid,
   period_sid
  FROM ldl_p_lew_process_mstr_ac.v_lil_data_mask_1 AS DM
  WHERE interface_name = 'LIFT_FMCG_Period_Portion'
   AND mask_data_fg = 1) AS dtm ON DT.client_id = dtm.client_id AND DT.region_sid = dtm.region_sid AND DT.period_sid =
   dtm.period_sid
WHERE COALESCE(DT.deleted_fg, 0) = 0
 AND dtm.client_id IS NULL;