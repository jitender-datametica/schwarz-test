
CREATE OR REPLACE TABLE ldl_p_lew_mart_cm.v_lil_lift_data_act_2
 AS
WITH BASE AS (SELECT CAST(ROUND(REG.region_id) AS INTEGER) AS client_id,
    RTL.rtl_id,
    CAST(ROUND(CASE
       WHEN RTLPER.retailer_sid_parent IS NOT NULL
       THEN 15
       ELSE RTL.rtl_lvl
       END) AS INTEGER) AS rtl_lvl,
    PERMS.period_id AS per_id,
    PER.period_year,
    GFK.gfk_cat_id AS lift_cat_id,
    DT.promotion_brand_id AS prom_id,
    TRUNC(CASE
      WHEN DT.data_confidence_fg = 1 OR (DT.data_confidence_fg IS NULL OR DT.data_confidence_fg = 0) AND MEAS.meas_id IN
          (49, 50, 51, 52, 53)
      THEN 101
      ELSE 0
      END) AS raw_buyer_id,
    CAST(CER.to_currency_iso_cd AS STRING) AS currency_iso_cd,
    MEAS.meas_id,
    CAST(CASE
       WHEN MEAS.meas_cd = 'turnover_val'
       THEN CAST(CAST(DT.turnover_val AS BIGNUMERIC) / 1000 AS NUMERIC)
       WHEN MEAS.meas_cd = 'pot_turnover_val'
       THEN ROUND(CAST(DT.pot_turnover_val / 1000 AS NUMERIC), 5)
       WHEN MEAS.meas_cd = 'category_lidl_val'
       THEN ROUND(CAST(DT.category_lidl_val / 1000 AS NUMERIC), 5)
       WHEN MEAS.meas_cd = 'trip_cnt'
       THEN ROUND(CAST(DT.trip_cnt / 1000 AS NUMERIC), 5)
       WHEN MEAS.meas_cd = 'buyer_cnt'
       THEN ROUND(CAST(DT.buyer_cnt / 1000 AS NUMERIC), 5)
       WHEN MEAS.meas_cd = 'pot_buyer_cnt'
       THEN ROUND(CAST(DT.pot_buyer_cnt / 1000 AS NUMERIC), 5)
       WHEN MEAS.meas_cd = 'household_in_country_cnt'
       THEN ROUND(CAST(DT.household_in_country_cnt / 1000 AS NUMERIC), 5)
       WHEN MEAS.meas_cd = 'spend_per_trip_val'
       THEN DT.spend_per_trip_val
       WHEN MEAS.meas_cd = 'buy_freq'
       THEN DT.buy_freq
       WHEN MEAS.meas_cd = 'pot_turnover_exploit_pct'
       THEN DT.pot_turnover_exploit_pct
       WHEN MEAS.meas_cd = 'spend_per_trip_val'
       THEN DT.spend_per_trip_val
       WHEN MEAS.meas_cd = 'spend_per_buyer_val'
       THEN DT.spend_per_buyer_val
       WHEN MEAS.meas_cd = 'turnover_category_val'
       THEN ROUND(CAST(DT.turnover_category_val / 1000 AS NUMERIC), 5)
       WHEN MEAS.meas_cd = 'household_penetrate_pct'
       THEN DT.household_penetrate_pct
       WHEN MEAS.meas_cd = 'loyalty_pct'
       THEN DT.loyalty_pct
       WHEN MEAS.meas_cd = 'closure_rate_pct'
       THEN DT.closure_rate_pct
       WHEN MEAS.meas_cd = 'buyer_quality'
       THEN DT.buyer_quality
       WHEN MEAS.meas_cd = 'lidl_market_share_pct'
       THEN DT.lidl_market_share_pct
       WHEN MEAS.meas_cd = 'lidl_buyer_turnover_val'
       THEN ROUND(CAST(DT.lidl_buyer_turnover_val / 1000 AS NUMERIC), 5)
       WHEN MEAS.meas_cd = 'new_or_lost_cat_buyer_cnt'
       THEN DT.new_or_lost_cat_buyer_cnt
       WHEN MEAS.meas_cd = 'incr_or_decr_cat_buy_val'
       THEN DT.incr_or_decr_cat_buy_val
       WHEN MEAS.meas_cd = 'switch_between_stores_val'
       THEN DT.switch_between_stores_val
       WHEN MEAS.meas_cd = 'net_switch_gain_val'
       THEN DT.net_switch_gain_val
       WHEN MEAS.meas_cd = 'net_switch_loss_val'
       THEN DT.net_switch_loss_val
       WHEN MEAS.meas_cd = 'val_k_gl' AND RTL.rtl_id = 1000
       THEN ROUND(CAST(DT.turnover_val / 1000 AS NUMERIC), 5)
       ELSE NULL
       END * CASE
       WHEN MEAS.monetary_fg = 1
       THEN CER.rate_currency_exchange
       ELSE 1
       END AS NUMERIC) AS val,
    CAST(CASE
       WHEN MEAS.meas_cd = 'turnover_val'
       THEN CAST(CAST(PY.turnover_val AS BIGNUMERIC) / 1000 AS NUMERIC)
       WHEN MEAS.meas_cd = 'pot_turnover_val'
       THEN ROUND(CAST(PY.pot_turnover_val / 1000 AS NUMERIC), 5)
       WHEN MEAS.meas_cd = 'category_lidl_val'
       THEN ROUND(CAST(PY.category_lidl_val / 1000 AS NUMERIC), 5)
       WHEN MEAS.meas_cd = 'trip_cnt'
       THEN ROUND(CAST(PY.trip_cnt / 1000 AS NUMERIC), 5)
       WHEN MEAS.meas_cd = 'buyer_cnt'
       THEN ROUND(CAST(PY.buyer_cnt / 1000 AS NUMERIC), 5)
       WHEN MEAS.meas_cd = 'pot_buyer_cnt'
       THEN ROUND(CAST(PY.pot_buyer_cnt / 1000 AS NUMERIC), 5)
       WHEN MEAS.meas_cd = 'household_in_country_cnt'
       THEN ROUND(CAST(PY.household_in_country_cnt / 1000 AS NUMERIC), 5)
       WHEN MEAS.meas_cd = 'spend_per_trip_val'
       THEN PY.spend_per_trip_val
       WHEN MEAS.meas_cd = 'buy_freq'
       THEN PY.buy_freq
       WHEN MEAS.meas_cd = 'pot_turnover_exploit_pct'
       THEN PY.pot_turnover_exploit_pct
       WHEN MEAS.meas_cd = 'spend_per_trip_val'
       THEN PY.spend_per_trip_val
       WHEN MEAS.meas_cd = 'spend_per_buyer_val'
       THEN PY.spend_per_buyer_val
       WHEN MEAS.meas_cd = 'turnover_category_val'
       THEN ROUND(CAST(PY.turnover_category_val / 1000 AS NUMERIC), 5)
       WHEN MEAS.meas_cd = 'household_penetrate_pct'
       THEN PY.household_penetrate_pct
       WHEN MEAS.meas_cd = 'loyalty_pct'
       THEN PY.loyalty_pct
       WHEN MEAS.meas_cd = 'closure_rate_pct'
       THEN PY.closure_rate_pct
       WHEN MEAS.meas_cd = 'buyer_quality'
       THEN PY.buyer_quality
       WHEN MEAS.meas_cd = 'lidl_market_share_pct'
       THEN PY.lidl_market_share_pct
       WHEN MEAS.meas_cd = 'lidl_buyer_turnover_val'
       THEN ROUND(CAST(PY.lidl_buyer_turnover_val / 1000 AS NUMERIC), 5)
       WHEN MEAS.meas_cd = 'new_or_lost_cat_buyer_cnt'
       THEN PY.new_or_lost_cat_buyer_cnt
       WHEN MEAS.meas_cd = 'incr_or_decr_cat_buy_val'
       THEN PY.incr_or_decr_cat_buy_val
       WHEN MEAS.meas_cd = 'switch_between_stores_val'
       THEN PY.switch_between_stores_val
       WHEN MEAS.meas_cd = 'net_switch_gain_val'
       THEN PY.net_switch_gain_val
       WHEN MEAS.meas_cd = 'net_switch_loss_val'
       THEN PY.net_switch_loss_val
       WHEN MEAS.meas_cd = 'val_k_gl' AND RTL.rtl_id = 1000
       THEN ROUND(CAST(PY.turnover_val / 1000 AS NUMERIC), 5)
       ELSE NULL
       END * CASE
       WHEN MEAS.monetary_fg = 1
       THEN CER.rate_currency_exchange
       ELSE 1
       END AS NUMERIC) AS py_val,
    NULL AS mat_latest_fg,
    CAST(COALESCE(DSDE.period_name, PER.period_name) AS STRING) AS per_desc,
    CAST(COALESCE(DSEN.period_name, PER.period_name) AS STRING) AS per_desc_en,
    CAST(COALESCE(PYDSDE.period_name, PYPER.period_name) AS STRING) AS py_per_desc,
    CAST(COALESCE(PYDSEN.period_name, PYPER.period_name) AS STRING) AS py_per_desc_en,
    0 AS prot_fg
   FROM ldl_p_lew_core_ac.v_market_subgroup_2 AS DT
    INNER JOIN ldl_p_lew_process_mstr_ac.v_lil_region_2 AS REG ON DT.region_sid = REG.region_sid
    INNER JOIN ldl_p_lew_process_mstr_ac.v_lil_region_retailer_2 AS RTL ON DT.retailer_sid = RTL.retailer_sid AND DT.region_sid
       = RTL.region_sid
    INNER JOIN ldl_p_lew_core_ac.v_lil_period_2 AS PER ON DT.client_id = PER.client_id AND DT.period_sid = PER.period_sid
    LEFT JOIN ldl_p_lew_core_ac.v_lil_period_descr_2 AS DSDE ON PER.period_sid = DSDE.period_sid AND DSDE.lang_cd = 'DE'
    LEFT JOIN ldl_p_lew_core_ac.v_lil_period_descr_2 AS DSEN ON PER.period_sid = DSEN.period_sid AND DSEN.lang_cd = 'EN'
    INNER JOIN ldl_p_lew_process_mstr_ac.v_lil_period_2 AS PERMS ON DT.client_id = PERMS.client_id AND DT.period_sid =
      PERMS.period_sid
    INNER JOIN ldl_p_lew_process_mstr_ac.v_lil_gfk_category_2 AS GFK ON DT.client_id = GFK.client_id AND DT.gfk_cat_sid =
      GFK.gfk_cat_sid
    INNER JOIN ldl_p_lew_mart_cm.v_lil_currency_exch_rt_2 AS CER ON DT.curr_cd = CER.from_currency_iso_cd
    LEFT JOIN ldl_p_lew_core_ac.v_market_subgroup_2 AS PY ON DT.client_id = PY.client_id AND PER.period_sid_py = PY.period_sid
           AND DT.region_sid = PY.region_sid AND DT.retailer_sid = PY.retailer_sid AND DT.gfk_cat_sid = PY.gfk_cat_sid
     AND DT.promotion_brand_id = PY.promotion_brand_id
    LEFT JOIN ldl_p_lew_core_ac.v_lil_period_2 AS PYPER ON PY.client_id = PYPER.client_id AND PY.period_sid = PYPER.period_sid
      
    LEFT JOIN ldl_p_lew_core_ac.v_lil_period_descr_2 AS PYDSDE ON PYPER.period_sid = PYDSDE.period_sid AND PYDSDE.lang_cd
      = 'DE'
    LEFT JOIN ldl_p_lew_core_ac.v_lil_period_descr_2 AS PYDSEN ON PYPER.period_sid = PYDSEN.period_sid AND PYDSEN.lang_cd
      = 'EN'
    LEFT JOIN ldl_p_lew_core_ac.v_lil_retailer_period_2 AS RTLPER ON DT.client_id = RTLPER.client_id AND DT.retailer_sid =
         RTLPER.retailer_sid AND DT.period_sid = RTLPER.period_sid AND RTLPER.deleted_fg = 0 AND RTLPER.interface_name =
      'LIFT_FMCG_Core'
    INNER JOIN (SELECT meas_id,
      meas_cd,
      monetary_fg
     FROM ldl_p_lew_process_mstr_ac.v_lil_measure_2
     WHERE meas_cd IN ('turnover_val', 'pot_turnover_val', 'category_lidl_val', 'trip_cnt', 'buyer_cnt', 'pot_buyer_cnt'
        , 'household_in_country_cnt', 'spend_per_trip_val', 'buy_freq', 'pot_turnover_exploit_pct', 'spend_per_trip_val'
        , 'spend_per_buyer_val', 'turnover_category_val', 'household_penetrate_pct', 'loyalty_pct', 'closure_rate_pct',
        'buyer_quality', 'lidl_market_share_pct', 'lidl_buyer_turnover_val', 'new_or_lost_cat_buyer_cnt',
        'incr_or_decr_cat_buy_val', 'switch_between_stores_val', 'net_switch_gain_val', 'net_switch_loss_val',
        'val_k_gl')) AS MEAS ON TRUE
   WHERE COALESCE(DT.deleted_fg, 0) = 0
    AND MEAS.meas_id NOT IN (44)
    AND NOT EXISTS (SELECT NULL
     FROM ldl_p_lew_process_mstr_ac.v_lil_data_mask_2 AS DM
     WHERE client_id = DT.client_id
      AND region_sid = DT.region_sid
      AND period_sid = DT.period_sid
      AND interface_name = 'LIFT_FMCG_Core'
      AND mask_data_fg = 1)
   UNION ALL
   SELECT CAST(ROUND(REG.region_id) AS INTEGER) AS client_id,
    RTL.rtl_id,
    CAST(ROUND(CASE
       WHEN RTLPER.retailer_sid_parent IS NOT NULL
       THEN 15
       ELSE RTL.rtl_lvl
       END) AS INTEGER) AS rtl_lvl,
    PTP.ltst_pseudo_period_id AS per_id,
    PER.period_year,
    GFK.gfk_cat_id AS lift_cat_id,
    DT.promotion_brand_id AS prom_id,
    TRUNC(CASE
      WHEN DT.data_confidence_fg = 1 OR (DT.data_confidence_fg IS NULL OR DT.data_confidence_fg = 0) AND MEAS.meas_id IN
          (49, 50, 51, 52, 53)
      THEN 101
      ELSE 0
      END) AS raw_buyer_id,
    CAST(CER.to_currency_iso_cd AS STRING) AS currency_iso_cd,
    MEAS.meas_id,
    CAST(CASE
       WHEN MEAS.meas_cd = 'turnover_val'
       THEN CAST(CAST(DT.turnover_val AS BIGNUMERIC) / 1000 AS NUMERIC)
       WHEN MEAS.meas_cd = 'pot_turnover_val'
       THEN ROUND(CAST(DT.pot_turnover_val / 1000 AS NUMERIC), 5)
       WHEN MEAS.meas_cd = 'category_lidl_val'
       THEN ROUND(CAST(DT.category_lidl_val / 1000 AS NUMERIC), 5)
       WHEN MEAS.meas_cd = 'trip_cnt'
       THEN ROUND(CAST(DT.trip_cnt / 1000 AS NUMERIC), 5)
       WHEN MEAS.meas_cd = 'buyer_cnt'
       THEN ROUND(CAST(DT.buyer_cnt / 1000 AS NUMERIC), 5)
       WHEN MEAS.meas_cd = 'pot_buyer_cnt'
       THEN ROUND(CAST(DT.pot_buyer_cnt / 1000 AS NUMERIC), 5)
       WHEN MEAS.meas_cd = 'household_in_country_cnt'
       THEN ROUND(CAST(DT.household_in_country_cnt / 1000 AS NUMERIC), 5)
       WHEN MEAS.meas_cd = 'spend_per_trip_val'
       THEN DT.spend_per_trip_val
       WHEN MEAS.meas_cd = 'buy_freq'
       THEN DT.buy_freq
       WHEN MEAS.meas_cd = 'pot_turnover_exploit_pct'
       THEN DT.pot_turnover_exploit_pct
       WHEN MEAS.meas_cd = 'spend_per_trip_val'
       THEN DT.spend_per_trip_val
       WHEN MEAS.meas_cd = 'spend_per_buyer_val'
       THEN DT.spend_per_buyer_val
       WHEN MEAS.meas_cd = 'turnover_category_val'
       THEN ROUND(CAST(DT.turnover_category_val / 1000 AS NUMERIC), 5)
       WHEN MEAS.meas_cd = 'household_penetrate_pct'
       THEN DT.household_penetrate_pct
       WHEN MEAS.meas_cd = 'loyalty_pct'
       THEN DT.loyalty_pct
       WHEN MEAS.meas_cd = 'closure_rate_pct'
       THEN DT.closure_rate_pct
       WHEN MEAS.meas_cd = 'buyer_quality'
       THEN DT.buyer_quality
       WHEN MEAS.meas_cd = 'lidl_market_share_pct'
       THEN DT.lidl_market_share_pct
       WHEN MEAS.meas_cd = 'lidl_buyer_turnover_val'
       THEN ROUND(CAST(DT.lidl_buyer_turnover_val / 1000 AS NUMERIC), 5)
       WHEN MEAS.meas_cd = 'new_or_lost_cat_buyer_cnt'
       THEN DT.new_or_lost_cat_buyer_cnt
       WHEN MEAS.meas_cd = 'incr_or_decr_cat_buy_val'
       THEN DT.incr_or_decr_cat_buy_val
       WHEN MEAS.meas_cd = 'switch_between_stores_val'
       THEN DT.switch_between_stores_val
       WHEN MEAS.meas_cd = 'net_switch_gain_val'
       THEN DT.net_switch_gain_val
       WHEN MEAS.meas_cd = 'net_switch_loss_val'
       THEN DT.net_switch_loss_val
       WHEN MEAS.meas_cd = 'val_k_gl' AND RTL.rtl_id = 1000
       THEN ROUND(CAST(DT.turnover_val / 1000 AS NUMERIC), 5)
       ELSE NULL
       END * CASE
       WHEN MEAS.monetary_fg = 1
       THEN CER.rate_currency_exchange
       ELSE 1
       END AS NUMERIC) AS val,
    CAST(CASE
       WHEN MEAS.meas_cd = 'turnover_val'
       THEN CAST(CAST(PY.turnover_val AS BIGNUMERIC) / 1000 AS NUMERIC)
       WHEN MEAS.meas_cd = 'pot_turnover_val'
       THEN ROUND(CAST(PY.pot_turnover_val / 1000 AS NUMERIC), 5)
       WHEN MEAS.meas_cd = 'category_lidl_val'
       THEN ROUND(CAST(PY.category_lidl_val / 1000 AS NUMERIC), 5)
       WHEN MEAS.meas_cd = 'trip_cnt'
       THEN ROUND(CAST(PY.trip_cnt / 1000 AS NUMERIC), 5)
       WHEN MEAS.meas_cd = 'buyer_cnt'
       THEN ROUND(CAST(PY.buyer_cnt / 1000 AS NUMERIC), 5)
       WHEN MEAS.meas_cd = 'pot_buyer_cnt'
       THEN ROUND(CAST(PY.pot_buyer_cnt / 1000 AS NUMERIC), 5)
       WHEN MEAS.meas_cd = 'household_in_country_cnt'
       THEN ROUND(CAST(PY.household_in_country_cnt / 1000 AS NUMERIC), 5)
       WHEN MEAS.meas_cd = 'spend_per_trip_val'
       THEN PY.spend_per_trip_val
       WHEN MEAS.meas_cd = 'buy_freq'
       THEN PY.buy_freq
       WHEN MEAS.meas_cd = 'pot_turnover_exploit_pct'
       THEN PY.pot_turnover_exploit_pct
       WHEN MEAS.meas_cd = 'spend_per_trip_val'
       THEN PY.spend_per_trip_val
       WHEN MEAS.meas_cd = 'spend_per_buyer_val'
       THEN PY.spend_per_buyer_val
       WHEN MEAS.meas_cd = 'turnover_category_val'
       THEN ROUND(CAST(PY.turnover_category_val / 1000 AS NUMERIC), 5)
       WHEN MEAS.meas_cd = 'household_penetrate_pct'
       THEN PY.household_penetrate_pct
       WHEN MEAS.meas_cd = 'loyalty_pct'
       THEN PY.loyalty_pct
       WHEN MEAS.meas_cd = 'closure_rate_pct'
       THEN PY.closure_rate_pct
       WHEN MEAS.meas_cd = 'buyer_quality'
       THEN PY.buyer_quality
       WHEN MEAS.meas_cd = 'lidl_market_share_pct'
       THEN PY.lidl_market_share_pct
       WHEN MEAS.meas_cd = 'lidl_buyer_turnover_val'
       THEN ROUND(CAST(PY.lidl_buyer_turnover_val / 1000 AS NUMERIC), 5)
       WHEN MEAS.meas_cd = 'new_or_lost_cat_buyer_cnt'
       THEN PY.new_or_lost_cat_buyer_cnt
       WHEN MEAS.meas_cd = 'incr_or_decr_cat_buy_val'
       THEN PY.incr_or_decr_cat_buy_val
       WHEN MEAS.meas_cd = 'switch_between_stores_val'
       THEN PY.switch_between_stores_val
       WHEN MEAS.meas_cd = 'net_switch_gain_val'
       THEN PY.net_switch_gain_val
       WHEN MEAS.meas_cd = 'net_switch_loss_val'
       THEN PY.net_switch_loss_val
       WHEN MEAS.meas_cd = 'val_k_gl' AND RTL.rtl_id = 1000
       THEN ROUND(CAST(PY.turnover_val / 1000 AS NUMERIC), 5)
       ELSE NULL
       END * CASE
       WHEN MEAS.monetary_fg = 1
       THEN CER.rate_currency_exchange
       ELSE 1
       END AS NUMERIC) AS py_val,
    NULL AS mat_latest_fg,
    CAST(COALESCE(DSDE.period_name, PER.period_name) AS STRING) AS per_desc,
    CAST(COALESCE(DSEN.period_name, PER.period_name) AS STRING) AS per_desc_en,
    CAST(COALESCE(PYDSDE.period_name, PYPER.period_name) AS STRING) AS py_per_desc,
    CAST(COALESCE(PYDSEN.period_name, PYPER.period_name) AS STRING) AS py_per_desc_en,
    0 AS prot_fg
   FROM ldl_p_lew_core_ac.v_market_subgroup_2 AS DT
    INNER JOIN ldl_p_lew_process_mstr_ac.v_lil_region_2 AS REG ON DT.region_sid = REG.region_sid
    INNER JOIN ldl_p_lew_process_mstr_ac.v_lil_region_retailer_2 AS RTL ON DT.client_id = RTL.client_id AND DT.retailer_sid
        = RTL.retailer_sid AND DT.region_sid = RTL.region_sid
    INNER JOIN (SELECT meas_id,
      meas_cd,
      monetary_fg
     FROM ldl_p_lew_process_mstr_ac.v_lil_measure_2
     WHERE meas_cd IN ('turnover_val', 'pot_turnover_val', 'category_lidl_val', 'trip_cnt', 'buyer_cnt', 'pot_buyer_cnt'
        , 'household_in_country_cnt', 'spend_per_trip_val', 'buy_freq', 'pot_turnover_exploit_pct', 'spend_per_trip_val'
        , 'spend_per_buyer_val', 'turnover_category_val', 'household_penetrate_pct', 'loyalty_pct', 'closure_rate_pct',
        'buyer_quality', 'lidl_market_share_pct', 'lidl_buyer_turnover_val', 'new_or_lost_cat_buyer_cnt',
        'incr_or_decr_cat_buy_val', 'switch_between_stores_val', 'net_switch_gain_val', 'net_switch_loss_val',
        'val_k_gl')) AS MEAS ON TRUE
    INNER JOIN ldl_p_lew_process_mstr_ac.v_lil_measure_class_2 AS MC ON MEAS.meas_id = MC.meas_id AND MC.class_cd IN ('LIFT1'
       , 'LIFTGL')
    INNER JOIN ldl_p_lew_core_ac.v_lil_period_2 AS PER ON DT.client_id = PER.client_id AND DT.period_sid = PER.period_sid
    LEFT JOIN ldl_p_lew_core_ac.v_lil_period_descr_2 AS DSDE ON PER.period_sid = DSDE.period_sid AND DSDE.lang_cd = 'DE'
    LEFT JOIN ldl_p_lew_core_ac.v_lil_period_descr_2 AS DSEN ON PER.period_sid = DSEN.period_sid AND DSEN.lang_cd = 'EN'
    INNER JOIN ldl_p_lew_process_mstr_ac.v_lil_period_2 AS PERMS ON DT.client_id = PERMS.client_id AND DT.period_sid =
      PERMS.period_sid
    INNER JOIN ldl_p_lew_process_mstr_ac.v_lil_region_per_latest_2 AS RPL ON DT.client_id = RPL.client_id AND DT.region_sid
         = RPL.region_sid AND MC.class_cd = RPL.class_cd AND PERMS.period_id = RPL.ltst_per_id
    INNER JOIN ldl_p_lew_process_mstr_ac.v_lil_period_type_2 AS PTP ON RPL.per_tp_id = PTP.period_type_id AND PTP.ltst_pseudo_period_id
     IS NOT NULL
    INNER JOIN ldl_p_lew_process_mstr_ac.v_lil_gfk_category_2 AS GFK ON DT.client_id = GFK.client_id AND DT.gfk_cat_sid =
      GFK.gfk_cat_sid
    INNER JOIN ldl_p_lew_mart_cm.v_lil_currency_exch_rt_2 AS CER ON DT.curr_cd = CER.from_currency_iso_cd
    LEFT JOIN ldl_p_lew_core_ac.v_market_subgroup_2 AS PY ON DT.client_id = PY.client_id AND PER.period_sid_py = PY.period_sid
           AND DT.region_sid = PY.region_sid AND DT.retailer_sid = PY.retailer_sid AND DT.gfk_cat_sid = PY.gfk_cat_sid
     AND DT.promotion_brand_id = PY.promotion_brand_id
    LEFT JOIN ldl_p_lew_core_ac.v_lil_period_2 AS PYPER ON PY.client_id = PYPER.client_id AND PY.period_sid = PYPER.period_sid
      
    LEFT JOIN ldl_p_lew_core_ac.v_lil_period_descr_2 AS PYDSDE ON PYPER.period_sid = PYDSDE.period_sid AND PYDSDE.lang_cd
      = 'DE'
    LEFT JOIN ldl_p_lew_core_ac.v_lil_period_descr_2 AS PYDSEN ON PYPER.period_sid = PYDSEN.period_sid AND PYDSEN.lang_cd
      = 'EN'
    LEFT JOIN ldl_p_lew_core_ac.v_lil_retailer_period_2 AS RTLPER ON DT.client_id = RTLPER.client_id AND DT.retailer_sid =
         RTLPER.retailer_sid AND DT.period_sid = RTLPER.period_sid AND RTLPER.deleted_fg = 0 AND RTLPER.interface_name =
      'LIFT_FMCG_Core'
   WHERE COALESCE(DT.deleted_fg, 0) = 0
    AND MEAS.meas_id NOT IN (44)
    AND NOT EXISTS (SELECT NULL
     FROM ldl_p_lew_process_mstr_ac.v_lil_data_mask_2 AS DM
     WHERE client_id = DT.client_id
      AND region_sid = DT.region_sid
      AND period_sid = DT.period_sid
      AND interface_name = 'LIFT_FMCG_Core'
      AND mask_data_fg = 1)) (SELECT *
  FROM (SELECT *
     FROM BASE
     UNION ALL
     SELECT 7 AS client_id,
      rtl_id,
      rtl_lvl,
      per_id,
      period_year,
      lift_cat_id,
      prom_id,
      raw_buyer_id,
      currency_iso_cd,
      meas_id,
      val,
      py_val,
      mat_latest_fg,
      per_desc,
      per_desc_en,
      py_per_desc,
      py_per_desc_en,
      prot_fg
     FROM BASE
     WHERE client_id NOT IN (3301, 3303, 3302)
     UNION ALL
     SELECT ACT.client_id,
       CASE
       WHEN CC.competitor_rank_id = 1
       THEN 1010
       WHEN CC.competitor_rank_id = 2
       THEN 1020
       WHEN CC.competitor_rank_id = 3
       THEN 1030
       ELSE 0
       END AS rtl_id,
      ACT.rtl_lvl,
      ACT.per_id,
      ACT.period_year,
      ACT.lift_cat_id,
      ACT.prom_id,
      ACT.raw_buyer_id,
      ACT.currency_iso_cd,
      ACT.meas_id,
      ACT.val,
      ACT.py_val,
      ACT.mat_latest_fg,
      ACT.per_desc,
      ACT.per_desc_en,
      ACT.py_per_desc,
      ACT.py_per_desc_en,
      ACT.prot_fg
     FROM BASE AS ACT
      INNER JOIN ldl_p_lew_mart_cm.t_lil_country_based_competitors_2 AS CC ON ACT.client_id = CC.client_id AND ACT.rtl_id
        = CC.retailer_id));



