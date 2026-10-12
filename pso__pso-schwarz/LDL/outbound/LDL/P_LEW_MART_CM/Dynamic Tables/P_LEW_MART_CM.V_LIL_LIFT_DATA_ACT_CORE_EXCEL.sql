
CREATE OR REPLACE TABLE ldl_p_lew_mart_cm.v_lil_lift_data_act_core_excel
 AS
WITH PERIODS_BASE AS (SELECT T1.client_id,
   T1.per_id,
   T1.application_id,
   T1.active_fg,
   COALESCE(T3.active_fg, 0) AS active_fg_py,
   T1.transaction_tmsp
  FROM ldl_p_lew_mart_cm.t_lil_historical_periods_per_client_and_application AS T1
   INNER JOIN ldl_p_lew_mart_cm.v_lil_period AS T2 ON T1.per_id = T2.per_id
   INNER JOIN ldl_p_lew_mart_cm.t_lil_historical_periods_per_client_and_application AS T3 ON T2.py_per_id = T3.per_id
     AND T1.client_id = T3.client_id AND T1.application_id = T3.application_id), PERIODS AS (SELECT *
   FROM PERIODS_BASE
   UNION ALL
   SELECT DISTINCT 7 AS client_id,
    per_id,
    application_id,
    active_fg,
    1 AS active_fg_py,
    transaction_tmsp
   FROM PERIODS_BASE), BASE AS (SELECT CAST(ROUND(REG.region_id) AS INTEGER) AS client_id,
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
      WHEN DT.data_confidence_fg = 1 OR (DT.data_confidence_fg IS NULL OR DT.data_confidence_fg = 0) AND meas.meas_id IN
          (49, 50, 51, 52, 53)
      THEN 101
      ELSE 0
      END) AS raw_buyer_id,
    CAST(CER.to_currency_iso_cd AS STRING) AS currency_iso_cd,
    meas.meas_id,
    CAST(CASE
       WHEN meas.meas_cd = 'turnover_val'
       THEN CAST(CAST(DT.turnover_val AS BIGNUMERIC) / 1000 AS NUMERIC)
       ELSE NULL
       END * CASE
       WHEN meas.monetary_fg = 1
       THEN CER.rate_currency_exchange
       ELSE 1
       END AS NUMERIC) AS turnover_val,
    CAST(CASE
       WHEN meas.meas_cd = 'pot_turnover_val'
       THEN ROUND(CAST(DT.pot_turnover_val / 1000 AS NUMERIC), 5)
       ELSE NULL
       END * CASE
       WHEN meas.monetary_fg = 1
       THEN CER.rate_currency_exchange
       ELSE 1
       END AS NUMERIC) AS pot_turnover_val,
    CAST(CASE
       WHEN meas.meas_cd = 'turnover_category_val'
       THEN ROUND(CAST(DT.turnover_category_val / 1000 AS NUMERIC), 5)
       ELSE NULL
       END * CASE
       WHEN meas.monetary_fg = 1
       THEN CER.rate_currency_exchange
       ELSE 1
       END AS NUMERIC) AS turnover_category_val,
    CAST(CASE
       WHEN meas.meas_cd = 'trip_cnt'
       THEN ROUND(CAST(DT.trip_cnt / 1000 AS NUMERIC), 5)
       ELSE NULL
       END * CASE
       WHEN meas.monetary_fg = 1
       THEN CER.rate_currency_exchange
       ELSE 1
       END AS NUMERIC) AS trip_cnt,
    CAST(CASE
       WHEN meas.meas_cd = 'buyer_cnt'
       THEN ROUND(CAST(DT.buyer_cnt / 1000 AS NUMERIC), 5)
       ELSE NULL
       END * CASE
       WHEN meas.monetary_fg = 1
       THEN CER.rate_currency_exchange
       ELSE 1
       END AS NUMERIC) AS buyer_cnt,
    CAST(CASE
       WHEN meas.meas_cd = 'pot_buyer_cnt'
       THEN ROUND(CAST(DT.pot_buyer_cnt / 1000 AS NUMERIC), 5)
       ELSE NULL
       END * CASE
       WHEN meas.monetary_fg = 1
       THEN CER.rate_currency_exchange
       ELSE 1
       END AS NUMERIC) AS pot_buyer_cnt,
    CAST(CASE
       WHEN meas.meas_cd = 'household_in_country_cnt'
       THEN ROUND(CAST(DT.household_in_country_cnt / 1000 AS NUMERIC), 5)
       ELSE NULL
       END * CASE
       WHEN meas.monetary_fg = 1
       THEN CER.rate_currency_exchange
       ELSE 1
       END AS NUMERIC) AS household_in_country_cnt,
    CAST(CASE
       WHEN meas.meas_cd = 'spend_per_trip_val'
       THEN DT.spend_per_trip_val
       ELSE NULL
       END * CASE
       WHEN meas.monetary_fg = 1
       THEN CER.rate_currency_exchange
       ELSE 1
       END AS NUMERIC) AS spend_per_trip_val,
    CAST(CASE
       WHEN meas.meas_cd = 'spend_per_buyer_val'
       THEN DT.spend_per_buyer_val
       ELSE NULL
       END * CASE
       WHEN meas.monetary_fg = 1
       THEN CER.rate_currency_exchange
       ELSE 1
       END AS NUMERIC) AS spend_per_buyer_val,
    CAST(CASE
       WHEN meas.meas_cd = 'buy_freq'
       THEN DT.buy_freq
       ELSE NULL
       END * CASE
       WHEN meas.monetary_fg = 1
       THEN CER.rate_currency_exchange
       ELSE 1
       END AS NUMERIC) AS buy_freq,
    CAST(CASE
       WHEN meas.meas_cd = 'buyer_quality'
       THEN DT.buyer_quality
       ELSE NULL
       END * CASE
       WHEN meas.monetary_fg = 1
       THEN CER.rate_currency_exchange
       ELSE 1
       END AS NUMERIC) AS buyer_quality,
    CAST(CASE
       WHEN meas.meas_cd = 'lidl_buyer_turnover_val'
       THEN ROUND(CAST(DT.lidl_buyer_turnover_val / 1000 AS NUMERIC), 5)
       ELSE NULL
       END * CASE
       WHEN meas.monetary_fg = 1
       THEN CER.rate_currency_exchange
       ELSE 1
       END AS NUMERIC) AS lidl_buyer_turnover_val,
    CAST(CASE
       WHEN meas.meas_cd = 'loyalty_pct'
       THEN DT.loyalty_pct
       ELSE NULL
       END * CASE
       WHEN meas.monetary_fg = 1
       THEN CER.rate_currency_exchange
       ELSE 1
       END AS NUMERIC) AS loyalty_pct,
    CAST(CASE
       WHEN meas.meas_cd = 'category_lidl_val'
       THEN DT.category_lidl_val
       ELSE NULL
       END * CASE
       WHEN meas.monetary_fg = 1
       THEN CER.rate_currency_exchange
       ELSE 1
       END AS NUMERIC) AS category_lidl_val,
    CAST(CASE
       WHEN meas.meas_cd = 'turnover_val'
       THEN CAST(CAST(PY.turnover_val AS BIGNUMERIC) / 1000 AS NUMERIC)
       ELSE NULL
       END * CASE
       WHEN meas.monetary_fg = 1
       THEN CER.rate_currency_exchange
       ELSE 1
       END AS NUMERIC) AS turnover_val_py,
    CAST(CASE
       WHEN meas.meas_cd = 'pot_turnover_val'
       THEN ROUND(CAST(PY.pot_turnover_val / 1000 AS NUMERIC), 5)
       ELSE NULL
       END * CASE
       WHEN meas.monetary_fg = 1
       THEN CER.rate_currency_exchange
       ELSE 1
       END AS NUMERIC) AS pot_turnover_val_py,
    CAST(CASE
       WHEN meas.meas_cd = 'turnover_category_val'
       THEN ROUND(CAST(PY.turnover_category_val / 1000 AS NUMERIC), 5)
       ELSE NULL
       END * CASE
       WHEN meas.monetary_fg = 1
       THEN CER.rate_currency_exchange
       ELSE 1
       END AS NUMERIC) AS turnover_category_val_py,
    CAST(CASE
       WHEN meas.meas_cd = 'trip_cnt'
       THEN ROUND(CAST(PY.trip_cnt / 1000 AS NUMERIC), 5)
       ELSE NULL
       END * CASE
       WHEN meas.monetary_fg = 1
       THEN CER.rate_currency_exchange
       ELSE 1
       END AS NUMERIC) AS trip_cnt_py,
    CAST(CASE
       WHEN meas.meas_cd = 'buyer_cnt'
       THEN ROUND(CAST(PY.buyer_cnt / 1000 AS NUMERIC), 5)
       ELSE NULL
       END * CASE
       WHEN meas.monetary_fg = 1
       THEN CER.rate_currency_exchange
       ELSE 1
       END AS NUMERIC) AS buyer_cnt_py,
    CAST(CASE
       WHEN meas.meas_cd = 'pot_buyer_cnt'
       THEN ROUND(CAST(PY.pot_buyer_cnt / 1000 AS NUMERIC), 5)
       ELSE NULL
       END * CASE
       WHEN meas.monetary_fg = 1
       THEN CER.rate_currency_exchange
       ELSE 1
       END AS NUMERIC) AS pot_buyer_cnt_py,
    CAST(CASE
       WHEN meas.meas_cd = 'household_in_country_cnt'
       THEN ROUND(CAST(PY.household_in_country_cnt / 1000 AS NUMERIC), 5)
       ELSE NULL
       END * CASE
       WHEN meas.monetary_fg = 1
       THEN CER.rate_currency_exchange
       ELSE 1
       END AS NUMERIC) AS household_in_country_cnt_py,
    CAST(CASE
       WHEN meas.meas_cd = 'spend_per_trip_val'
       THEN PY.spend_per_trip_val
       ELSE NULL
       END * CASE
       WHEN meas.monetary_fg = 1
       THEN CER.rate_currency_exchange
       ELSE 1
       END AS NUMERIC) AS spend_per_trip_val_py,
    CAST(CASE
       WHEN meas.meas_cd = 'spend_per_buyer_val'
       THEN PY.spend_per_buyer_val
       ELSE NULL
       END * CASE
       WHEN meas.monetary_fg = 1
       THEN CER.rate_currency_exchange
       ELSE 1
       END AS NUMERIC) AS spend_per_buyer_val_py,
    CAST(CASE
       WHEN meas.meas_cd = 'buy_freq'
       THEN PY.buy_freq
       ELSE NULL
       END * CASE
       WHEN meas.monetary_fg = 1
       THEN CER.rate_currency_exchange
       ELSE 1
       END AS NUMERIC) AS buy_freq_py,
    CAST(CASE
       WHEN meas.meas_cd = 'buyer_quality'
       THEN PY.buyer_quality
       ELSE NULL
       END * CASE
       WHEN meas.monetary_fg = 1
       THEN CER.rate_currency_exchange
       ELSE 1
       END AS NUMERIC) AS buyer_quality_py,
    CAST(CASE
       WHEN meas.meas_cd = 'lidl_buyer_turnover_val'
       THEN ROUND(CAST(PY.lidl_buyer_turnover_val / 1000 AS NUMERIC), 5)
       ELSE NULL
       END * CASE
       WHEN meas.monetary_fg = 1
       THEN CER.rate_currency_exchange
       ELSE 1
       END AS NUMERIC) AS lidl_buyer_turnover_val_py,
    CAST(CASE
       WHEN meas.meas_cd = 'loyalty_pct'
       THEN PY.loyalty_pct
       ELSE NULL
       END * CASE
       WHEN meas.monetary_fg = 1
       THEN CER.rate_currency_exchange
       ELSE 1
       END AS NUMERIC) AS loyalty_pct_py,
    CAST(CASE
       WHEN meas.meas_cd = 'category_lidl_val'
       THEN PY.category_lidl_val
       ELSE NULL
       END * CASE
       WHEN meas.monetary_fg = 1
       THEN CER.rate_currency_exchange
       ELSE 1
       END AS NUMERIC) AS category_lidl_val_py,
    NULL AS mat_latest_fg,
    CAST(COALESCE(DSDE.period_name, PER.period_name) AS STRING) AS per_desc,
    CAST(COALESCE(DSEN.period_name, PER.period_name) AS STRING) AS per_desc_en,
    CAST(COALESCE(PYDSDE.period_name, PYPER.period_name) AS STRING) AS py_per_desc,
    CAST(COALESCE(PYDSEN.period_name, PYPER.period_name) AS STRING) AS py_per_desc_en,
    0 AS prot_fg,
    t14.active_fg,
    t14.application_id
   FROM ldl_p_lew_core_ac.v_market_subgroup AS DT
    INNER JOIN ldl_p_lew_process_mstr_ac.v_lil_region AS REG ON DT.region_sid = REG.region_sid
    INNER JOIN ldl_p_lew_process_mstr_ac.v_lil_region_retailer AS RTL ON DT.retailer_sid = RTL.retailer_sid AND DT.region_sid
       = RTL.region_sid
    INNER JOIN ldl_p_lew_core_ac.v_lil_period AS PER ON DT.client_id = PER.client_id AND DT.period_sid = PER.period_sid
    LEFT JOIN ldl_p_lew_core_ac.v_lil_period_descr AS DSDE ON PER.period_sid = DSDE.period_sid AND DSDE.lang_cd = 'DE'
    LEFT JOIN ldl_p_lew_core_ac.v_lil_period_descr AS DSEN ON PER.period_sid = DSEN.period_sid AND DSEN.lang_cd = 'EN'
    INNER JOIN ldl_p_lew_process_mstr_ac.v_lil_period AS PERMS ON DT.client_id = PERMS.client_id AND DT.period_sid =
      PERMS.period_sid
    INNER JOIN ldl_p_lew_process_mstr_ac.v_lil_gfk_category AS GFK ON DT.client_id = GFK.client_id AND DT.gfk_cat_sid =
      GFK.gfk_cat_sid
    INNER JOIN ldl_p_lew_mart_cm.v_lil_currency_exch_rt AS CER ON DT.curr_cd = CER.from_currency_iso_cd
    LEFT JOIN ldl_p_lew_core_ac.v_market_subgroup AS PY ON DT.client_id = PY.client_id AND PER.period_sid_py = PY.period_sid
           AND DT.region_sid = PY.region_sid AND DT.retailer_sid = PY.retailer_sid AND DT.gfk_cat_sid = PY.gfk_cat_sid
     AND DT.promotion_brand_id = PY.promotion_brand_id
    LEFT JOIN ldl_p_lew_core_ac.v_lil_period AS PYPER ON PY.client_id = PYPER.client_id AND PY.period_sid = PYPER.period_sid
      
    LEFT JOIN ldl_p_lew_core_ac.v_lil_period_descr AS PYDSDE ON PYPER.period_sid = PYDSDE.period_sid AND PYDSDE.lang_cd
      = 'DE'
    LEFT JOIN ldl_p_lew_core_ac.v_lil_period_descr AS PYDSEN ON PYPER.period_sid = PYDSEN.period_sid AND PYDSEN.lang_cd
      = 'EN'
    LEFT JOIN ldl_p_lew_core_ac.v_lil_retailer_period AS RTLPER ON DT.client_id = RTLPER.client_id AND DT.retailer_sid =
         RTLPER.retailer_sid AND DT.period_sid = RTLPER.period_sid AND RTLPER.deleted_fg = 0 AND RTLPER.interface_name =
      'LIFT_FMCG_Core'
    INNER JOIN (SELECT meas_id,
      meas_cd,
      monetary_fg
     FROM ldl_p_lew_process_mstr_ac.v_lil_measure
     WHERE meas_cd IN ('turnover_val', 'pot_turnover_val', 'category_lidl_val', 'trip_cnt', 'buyer_cnt', 'pot_buyer_cnt'
        , 'household_in_country_cnt', 'spend_per_trip_val', 'buy_freq', 'pot_turnover_exploit_pct', 'spend_per_trip_val'
        , 'spend_per_buyer_val', 'turnover_category_val', 'household_penetrate_pct', 'loyalty_pct', 'closure_rate_pct',
        'buyer_quality', 'lidl_market_share_pct', 'lidl_buyer_turnover_val', 'new_or_lost_cat_buyer_cnt',
        'incr_or_decr_cat_buy_val', 'switch_between_stores_val', 'net_switch_gain_val', 'net_switch_loss_val',
        'val_k_gl')) AS meas ON TRUE
    LEFT JOIN PERIODS AS t14 ON CAST(ROUND(REG.region_id) AS INTEGER) = t14.client_id AND PERMS.period_id = t14.per_id
   WHERE COALESCE(DT.deleted_fg, 0) = 0
    AND (DT.turnover_val IS NOT NULL OR DT.turnover_category_val IS NOT NULL OR DT.pot_turnover_val IS NOT NULL OR DT.trip_cnt
                            IS NOT NULL OR DT.buyer_cnt IS NOT NULL OR DT.pot_buyer_cnt IS NOT NULL OR DT.household_in_country_cnt
                         IS NOT NULL OR DT.spend_per_trip_val IS NOT NULL OR DT.spend_per_buyer_val IS NOT NULL OR DT.buy_freq
                      IS NOT NULL OR DT.buyer_quality IS NOT NULL OR DT.lidl_buyer_turnover_val IS NOT NULL OR PY.turnover_val
                   IS NOT NULL OR PY.pot_turnover_val IS NOT NULL OR PY.turnover_category_val IS NOT NULL OR PY.trip_cnt
                IS NOT NULL OR PY.buyer_cnt IS NOT NULL OR PY.pot_buyer_cnt IS NOT NULL OR PY.household_in_country_cnt
             IS NOT NULL OR PY.spend_per_trip_val IS NOT NULL OR PY.spend_per_buyer_val IS NOT NULL OR PY.buy_freq
          IS NOT NULL OR PY.buyer_quality IS NOT NULL OR PY.lidl_buyer_turnover_val IS NOT NULL OR DT.loyalty_pct
       IS NOT NULL OR PY.loyalty_pct IS NOT NULL)
    AND meas.meas_id NOT IN (44)
    AND NOT EXISTS (SELECT NULL
     FROM ldl_p_lew_process_mstr_ac.v_lil_data_mask AS DM
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
      WHEN DT.data_confidence_fg = 1 OR (DT.data_confidence_fg IS NULL OR DT.data_confidence_fg = 0) AND meas.meas_id IN
          (49, 50, 51, 52, 53)
      THEN 101
      ELSE 0
      END) AS raw_buyer_id,
    CAST(CER.to_currency_iso_cd AS STRING) AS currency_iso_cd,
    meas.meas_id,
    CAST(CASE
       WHEN meas.meas_cd = 'turnover_val'
       THEN CAST(CAST(DT.turnover_val AS BIGNUMERIC) / 1000 AS NUMERIC)
       ELSE NULL
       END * CASE
       WHEN meas.monetary_fg = 1
       THEN CER.rate_currency_exchange
       ELSE 1
       END AS NUMERIC) AS turnover_val,
    CAST(CASE
       WHEN meas.meas_cd = 'pot_turnover_val'
       THEN ROUND(CAST(DT.pot_turnover_val / 1000 AS NUMERIC), 5)
       ELSE NULL
       END * CASE
       WHEN meas.monetary_fg = 1
       THEN CER.rate_currency_exchange
       ELSE 1
       END AS NUMERIC) AS pot_turnover_val,
    CAST(CASE
       WHEN meas.meas_cd = 'turnover_category_val'
       THEN ROUND(CAST(DT.turnover_category_val / 1000 AS NUMERIC), 5)
       ELSE NULL
       END * CASE
       WHEN meas.monetary_fg = 1
       THEN CER.rate_currency_exchange
       ELSE 1
       END AS NUMERIC) AS turnover_category_val,
    CAST(CASE
       WHEN meas.meas_cd = 'trip_cnt'
       THEN ROUND(CAST(DT.trip_cnt / 1000 AS NUMERIC), 5)
       ELSE NULL
       END * CASE
       WHEN meas.monetary_fg = 1
       THEN CER.rate_currency_exchange
       ELSE 1
       END AS NUMERIC) AS trip_cnt,
    CAST(CASE
       WHEN meas.meas_cd = 'buyer_cnt'
       THEN ROUND(CAST(DT.buyer_cnt / 1000 AS NUMERIC), 5)
       ELSE NULL
       END * CASE
       WHEN meas.monetary_fg = 1
       THEN CER.rate_currency_exchange
       ELSE 1
       END AS NUMERIC) AS buyer_cnt,
    CAST(CASE
       WHEN meas.meas_cd = 'pot_buyer_cnt'
       THEN ROUND(CAST(DT.pot_buyer_cnt / 1000 AS NUMERIC), 5)
       ELSE NULL
       END * CASE
       WHEN meas.monetary_fg = 1
       THEN CER.rate_currency_exchange
       ELSE 1
       END AS NUMERIC) AS pot_buyer_cnt,
    CAST(CASE
       WHEN meas.meas_cd = 'household_in_country_cnt'
       THEN ROUND(CAST(DT.household_in_country_cnt / 1000 AS NUMERIC), 5)
       ELSE NULL
       END * CASE
       WHEN meas.monetary_fg = 1
       THEN CER.rate_currency_exchange
       ELSE 1
       END AS NUMERIC) AS household_in_country_cnt,
    CAST(CASE
       WHEN meas.meas_cd = 'spend_per_trip_val'
       THEN DT.spend_per_trip_val
       ELSE NULL
       END * CASE
       WHEN meas.monetary_fg = 1
       THEN CER.rate_currency_exchange
       ELSE 1
       END AS NUMERIC) AS spend_per_trip_val,
    CAST(CASE
       WHEN meas.meas_cd = 'spend_per_buyer_val'
       THEN DT.spend_per_buyer_val
       ELSE NULL
       END * CASE
       WHEN meas.monetary_fg = 1
       THEN CER.rate_currency_exchange
       ELSE 1
       END AS NUMERIC) AS spend_per_buyer_val,
    CAST(CASE
       WHEN meas.meas_cd = 'buy_freq'
       THEN DT.buy_freq
       ELSE NULL
       END * CASE
       WHEN meas.monetary_fg = 1
       THEN CER.rate_currency_exchange
       ELSE 1
       END AS NUMERIC) AS buy_freq,
    CAST(CASE
       WHEN meas.meas_cd = 'buyer_quality'
       THEN DT.buyer_quality
       ELSE NULL
       END * CASE
       WHEN meas.monetary_fg = 1
       THEN CER.rate_currency_exchange
       ELSE 1
       END AS NUMERIC) AS buyer_quality,
    CAST(CASE
       WHEN meas.meas_cd = 'lidl_buyer_turnover_val'
       THEN ROUND(CAST(DT.lidl_buyer_turnover_val / 1000 AS NUMERIC), 5)
       ELSE NULL
       END * CASE
       WHEN meas.monetary_fg = 1
       THEN CER.rate_currency_exchange
       ELSE 1
       END AS NUMERIC) AS lidl_buyer_turnover_val,
    CAST(CASE
       WHEN meas.meas_cd = 'loyalty_pct'
       THEN DT.loyalty_pct
       ELSE NULL
       END * CASE
       WHEN meas.monetary_fg = 1
       THEN CER.rate_currency_exchange
       ELSE 1
       END AS NUMERIC) AS loyalty_pct,
    CAST(CASE
       WHEN meas.meas_cd = 'category_lidl_val'
       THEN DT.category_lidl_val
       ELSE NULL
       END * CASE
       WHEN meas.monetary_fg = 1
       THEN CER.rate_currency_exchange
       ELSE 1
       END AS NUMERIC) AS category_lidl_val,
    CAST(CASE
       WHEN meas.meas_cd = 'turnover_val'
       THEN CAST(CAST(PY.turnover_val AS BIGNUMERIC) / 1000 AS NUMERIC)
       ELSE NULL
       END * CASE
       WHEN meas.monetary_fg = 1
       THEN CER.rate_currency_exchange
       ELSE 1
       END AS NUMERIC) AS turnover_val_py,
    CAST(CASE
       WHEN meas.meas_cd = 'pot_turnover_val'
       THEN ROUND(CAST(PY.pot_turnover_val / 1000 AS NUMERIC), 5)
       ELSE NULL
       END * CASE
       WHEN meas.monetary_fg = 1
       THEN CER.rate_currency_exchange
       ELSE 1
       END AS NUMERIC) AS pot_turnover_val_py,
    CAST(CASE
       WHEN meas.meas_cd = 'turnover_category_val'
       THEN ROUND(CAST(PY.turnover_category_val / 1000 AS NUMERIC), 5)
       ELSE NULL
       END * CASE
       WHEN meas.monetary_fg = 1
       THEN CER.rate_currency_exchange
       ELSE 1
       END AS NUMERIC) AS turnover_category_val_py,
    CAST(CASE
       WHEN meas.meas_cd = 'trip_cnt'
       THEN ROUND(CAST(PY.trip_cnt / 1000 AS NUMERIC), 5)
       ELSE NULL
       END * CASE
       WHEN meas.monetary_fg = 1
       THEN CER.rate_currency_exchange
       ELSE 1
       END AS NUMERIC) AS trip_cnt_py,
    CAST(CASE
       WHEN meas.meas_cd = 'buyer_cnt'
       THEN ROUND(CAST(PY.buyer_cnt / 1000 AS NUMERIC), 5)
       ELSE NULL
       END * CASE
       WHEN meas.monetary_fg = 1
       THEN CER.rate_currency_exchange
       ELSE 1
       END AS NUMERIC) AS buyer_cnt_py,
    CAST(CASE
       WHEN meas.meas_cd = 'pot_buyer_cnt'
       THEN ROUND(CAST(PY.pot_buyer_cnt / 1000 AS NUMERIC), 5)
       ELSE NULL
       END * CASE
       WHEN meas.monetary_fg = 1
       THEN CER.rate_currency_exchange
       ELSE 1
       END AS NUMERIC) AS pot_buyer_cnt_py,
    CAST(CASE
       WHEN meas.meas_cd = 'household_in_country_cnt'
       THEN ROUND(CAST(PY.household_in_country_cnt / 1000 AS NUMERIC), 5)
       ELSE NULL
       END * CASE
       WHEN meas.monetary_fg = 1
       THEN CER.rate_currency_exchange
       ELSE 1
       END AS NUMERIC) AS household_in_country_cnt_py,
    CAST(CASE
       WHEN meas.meas_cd = 'spend_per_trip_val'
       THEN PY.spend_per_trip_val
       ELSE NULL
       END * CASE
       WHEN meas.monetary_fg = 1
       THEN CER.rate_currency_exchange
       ELSE 1
       END AS NUMERIC) AS spend_per_trip_val_py,
    CAST(CASE
       WHEN meas.meas_cd = 'spend_per_buyer_val'
       THEN PY.spend_per_buyer_val
       ELSE NULL
       END * CASE
       WHEN meas.monetary_fg = 1
       THEN CER.rate_currency_exchange
       ELSE 1
       END AS NUMERIC) AS spend_per_buyer_val_py,
    CAST(CASE
       WHEN meas.meas_cd = 'buy_freq'
       THEN PY.buy_freq
       ELSE NULL
       END * CASE
       WHEN meas.monetary_fg = 1
       THEN CER.rate_currency_exchange
       ELSE 1
       END AS NUMERIC) AS buy_freq_py,
    CAST(CASE
       WHEN meas.meas_cd = 'buyer_quality'
       THEN PY.buyer_quality
       ELSE NULL
       END * CASE
       WHEN meas.monetary_fg = 1
       THEN CER.rate_currency_exchange
       ELSE 1
       END AS NUMERIC) AS buyer_quality_py,
    CAST(CASE
       WHEN meas.meas_cd = 'lidl_buyer_turnover_val'
       THEN ROUND(CAST(PY.lidl_buyer_turnover_val / 1000 AS NUMERIC), 5)
       ELSE NULL
       END * CASE
       WHEN meas.monetary_fg = 1
       THEN CER.rate_currency_exchange
       ELSE 1
       END AS NUMERIC) AS lidl_buyer_turnover_val_py,
    CAST(CASE
       WHEN meas.meas_cd = 'loyalty_pct'
       THEN PY.loyalty_pct
       ELSE NULL
       END * CASE
       WHEN meas.monetary_fg = 1
       THEN CER.rate_currency_exchange
       ELSE 1
       END AS NUMERIC) AS loyalty_pct_py,
    CAST(CASE
       WHEN meas.meas_cd = 'category_lidl_val'
       THEN PY.category_lidl_val
       ELSE NULL
       END * CASE
       WHEN meas.monetary_fg = 1
       THEN CER.rate_currency_exchange
       ELSE 1
       END AS NUMERIC) AS category_lidl_val_py,
    NULL AS mat_latest_fg,
    CAST(COALESCE(DSDE.period_name, PER.period_name) AS STRING) AS per_desc,
    CAST(COALESCE(DSEN.period_name, PER.period_name) AS STRING) AS per_desc_en,
    CAST(COALESCE(PYDSDE.period_name, PYPER.period_name) AS STRING) AS py_per_desc,
    CAST(COALESCE(PYDSEN.period_name, PYPER.period_name) AS STRING) AS py_per_desc_en,
    0 AS prot_fg,
    t31.active_fg,
    t31.application_id
   FROM ldl_p_lew_core_ac.v_market_subgroup AS DT
    INNER JOIN ldl_p_lew_process_mstr_ac.v_lil_region AS REG ON DT.region_sid = REG.region_sid
    INNER JOIN ldl_p_lew_process_mstr_ac.v_lil_region_retailer AS RTL ON DT.client_id = RTL.client_id AND DT.retailer_sid
        = RTL.retailer_sid AND DT.region_sid = RTL.region_sid
    INNER JOIN (SELECT meas_id,
      meas_cd,
      monetary_fg
     FROM ldl_p_lew_process_mstr_ac.v_lil_measure
     WHERE meas_cd IN ('turnover_val', 'pot_turnover_val', 'category_lidl_val', 'trip_cnt', 'buyer_cnt', 'pot_buyer_cnt'
        , 'household_in_country_cnt', 'spend_per_trip_val', 'buy_freq', 'pot_turnover_exploit_pct', 'spend_per_trip_val'
        , 'spend_per_buyer_val', 'turnover_category_val', 'household_penetrate_pct', 'loyalty_pct', 'closure_rate_pct',
        'buyer_quality', 'lidl_market_share_pct', 'lidl_buyer_turnover_val', 'new_or_lost_cat_buyer_cnt',
        'incr_or_decr_cat_buy_val', 'switch_between_stores_val', 'net_switch_gain_val', 'net_switch_loss_val',
        'val_k_gl')) AS meas ON TRUE
    INNER JOIN ldl_p_lew_process_mstr_ac.v_lil_measure_class AS MC ON meas.meas_id = MC.meas_id AND MC.class_cd IN ('LIFT1'
       , 'LIFTGL')
    INNER JOIN ldl_p_lew_core_ac.v_lil_period AS PER ON DT.client_id = PER.client_id AND DT.period_sid = PER.period_sid
    LEFT JOIN ldl_p_lew_core_ac.v_lil_period_descr AS DSDE ON PER.period_sid = DSDE.period_sid AND DSDE.lang_cd = 'DE'
    LEFT JOIN ldl_p_lew_core_ac.v_lil_period_descr AS DSEN ON PER.period_sid = DSEN.period_sid AND DSEN.lang_cd = 'EN'
    INNER JOIN ldl_p_lew_process_mstr_ac.v_lil_period AS PERMS ON DT.client_id = PERMS.client_id AND DT.period_sid =
      PERMS.period_sid
    INNER JOIN ldl_p_lew_process_mstr_ac.v_lil_region_per_latest AS RPL ON DT.client_id = RPL.client_id AND DT.region_sid
         = RPL.region_sid AND MC.class_cd = RPL.class_cd AND PERMS.period_id = RPL.ltst_per_id
    INNER JOIN ldl_p_lew_process_mstr_ac.v_lil_period_type AS PTP ON RPL.per_tp_id = PTP.period_type_id AND PTP.ltst_pseudo_period_id
     IS NOT NULL
    INNER JOIN ldl_p_lew_process_mstr_ac.v_lil_gfk_category AS GFK ON DT.client_id = GFK.client_id AND DT.gfk_cat_sid =
      GFK.gfk_cat_sid
    INNER JOIN ldl_p_lew_mart_cm.v_lil_currency_exch_rt AS CER ON DT.curr_cd = CER.from_currency_iso_cd
    LEFT JOIN ldl_p_lew_core_ac.v_market_subgroup AS PY ON DT.client_id = PY.client_id AND PER.period_sid_py = PY.period_sid
           AND DT.region_sid = PY.region_sid AND DT.retailer_sid = PY.retailer_sid AND DT.gfk_cat_sid = PY.gfk_cat_sid
     AND DT.promotion_brand_id = PY.promotion_brand_id
    LEFT JOIN ldl_p_lew_core_ac.v_lil_period AS PYPER ON PY.client_id = PYPER.client_id AND PY.period_sid = PYPER.period_sid
      
    LEFT JOIN ldl_p_lew_core_ac.v_lil_period_descr AS PYDSDE ON PYPER.period_sid = PYDSDE.period_sid AND PYDSDE.lang_cd
      = 'DE'
    LEFT JOIN ldl_p_lew_core_ac.v_lil_period_descr AS PYDSEN ON PYPER.period_sid = PYDSEN.period_sid AND PYDSEN.lang_cd
      = 'EN'
    LEFT JOIN ldl_p_lew_core_ac.v_lil_retailer_period AS RTLPER ON DT.client_id = RTLPER.client_id AND DT.retailer_sid =
         RTLPER.retailer_sid AND DT.period_sid = RTLPER.period_sid AND RTLPER.deleted_fg = 0 AND RTLPER.interface_name =
      'LIFT_FMCG_Core'
    LEFT JOIN PERIODS AS t31 ON CAST(ROUND(REG.region_id) AS INTEGER) = t31.client_id AND PTP.ltst_pseudo_period_id =
      t31.per_id
   WHERE COALESCE(DT.deleted_fg, 0) = 0
    AND (DT.turnover_val IS NOT NULL OR DT.turnover_category_val IS NOT NULL OR DT.pot_turnover_val IS NOT NULL OR DT.trip_cnt
                            IS NOT NULL OR DT.buyer_cnt IS NOT NULL OR DT.pot_buyer_cnt IS NOT NULL OR DT.household_in_country_cnt
                         IS NOT NULL OR DT.spend_per_trip_val IS NOT NULL OR DT.spend_per_buyer_val IS NOT NULL OR DT.buy_freq
                      IS NOT NULL OR DT.buyer_quality IS NOT NULL OR DT.lidl_buyer_turnover_val IS NOT NULL OR PY.turnover_val
                   IS NOT NULL OR PY.pot_turnover_val IS NOT NULL OR PY.turnover_category_val IS NOT NULL OR PY.trip_cnt
                IS NOT NULL OR PY.buyer_cnt IS NOT NULL OR PY.pot_buyer_cnt IS NOT NULL OR PY.household_in_country_cnt
             IS NOT NULL OR PY.spend_per_trip_val IS NOT NULL OR PY.spend_per_buyer_val IS NOT NULL OR PY.buy_freq
          IS NOT NULL OR PY.buyer_quality IS NOT NULL OR PY.lidl_buyer_turnover_val IS NOT NULL OR DT.loyalty_pct
       IS NOT NULL OR PY.loyalty_pct IS NOT NULL)
    AND meas.meas_id NOT IN (44)
    AND NOT EXISTS (SELECT NULL
     FROM ldl_p_lew_process_mstr_ac.v_lil_data_mask AS DM
     WHERE client_id = DT.client_id
      AND region_sid = DT.region_sid
      AND period_sid = DT.period_sid
      AND interface_name = 'LIFT_FMCG_Core'
      AND mask_data_fg = 1)) (SELECT *
  FROM (SELECT client_id,
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
     FROM BASE
     WHERE client_id NOT IN (3301, 3303, 3302)
     UNION ALL
     SELECT act.client_id,
       CASE
       WHEN CC.competitor_rank_id = 1
       THEN 1010
       WHEN CC.competitor_rank_id = 2
       THEN 1020
       WHEN CC.competitor_rank_id = 3
       THEN 1030
       ELSE 0
       END AS rtl_id,
      act.rtl_lvl,
      act.per_id,
      act.period_year,
      act.lift_cat_id,
      act.prom_id,
      act.raw_buyer_id,
      act.currency_iso_cd,
      act.meas_id,
      act.turnover_val,
      act.turnover_category_val,
      act.pot_turnover_val,
      act.trip_cnt,
      act.buyer_cnt,
      act.pot_buyer_cnt,
      act.household_in_country_cnt,
      act.spend_per_trip_val,
      act.spend_per_buyer_val,
      act.buy_freq,
      act.buyer_quality,
      act.lidl_buyer_turnover_val,
      act.turnover_val_py,
      act.pot_turnover_val_py,
      act.turnover_category_val_py,
      act.trip_cnt_py,
      act.buyer_cnt_py,
      act.pot_buyer_cnt_py,
      act.household_in_country_cnt_py,
      act.spend_per_trip_val_py,
      act.spend_per_buyer_val_py,
      act.buy_freq_py,
      act.buyer_quality_py,
      act.lidl_buyer_turnover_val_py,
      act.loyalty_pct,
      act.loyalty_pct_py,
      act.category_lidl_val,
      act.category_lidl_val_py,
      act.mat_latest_fg,
      act.per_desc,
      act.per_desc_en,
      act.py_per_desc,
      act.py_per_desc_en,
      act.prot_fg,
      act.active_fg,
      act.application_id
     FROM BASE AS act
      INNER JOIN ldl_p_lew_mart_cm.t_lil_country_based_competitors AS CC ON act.client_id = CC.client_id AND act.rtl_id
        = CC.retailer_id
     UNION ALL
     SELECT 7 AS client_id,
       CASE
       WHEN CC0.competitor_rank_id = 1
       THEN 1010
       WHEN CC0.competitor_rank_id = 2
       THEN 1020
       WHEN CC0.competitor_rank_id = 3
       THEN 1030
       ELSE 0
       END AS rtl_id,
      act.rtl_lvl,
      act.per_id,
      act.period_year,
      act.lift_cat_id,
      act.prom_id,
      act.raw_buyer_id,
      act.currency_iso_cd,
      act.meas_id,
      act.turnover_val,
      act.turnover_category_val,
      act.pot_turnover_val,
      act.trip_cnt,
      act.buyer_cnt,
      act.pot_buyer_cnt,
      act.household_in_country_cnt,
      act.spend_per_trip_val,
      act.spend_per_buyer_val,
      act.buy_freq,
      act.buyer_quality,
      act.lidl_buyer_turnover_val,
      act.turnover_val_py,
      act.pot_turnover_val_py,
      act.turnover_category_val_py,
      act.trip_cnt_py,
      act.buyer_cnt_py,
      act.pot_buyer_cnt_py,
      act.household_in_country_cnt_py,
      act.spend_per_trip_val_py,
      act.spend_per_buyer_val_py,
      act.buy_freq_py,
      act.buyer_quality_py,
      act.lidl_buyer_turnover_val_py,
      act.loyalty_pct,
      act.loyalty_pct_py,
      act.category_lidl_val,
      act.category_lidl_val_py,
      act.mat_latest_fg,
      act.per_desc,
      act.per_desc_en,
      act.py_per_desc,
      act.py_per_desc_en,
      act.prot_fg,
      act.active_fg,
      act.application_id
     FROM BASE AS act
      INNER JOIN ldl_p_lew_mart_cm.t_lil_country_based_competitors AS CC0 ON act.client_id = CC0.client_id AND act.rtl_id
         = CC0.retailer_id
     WHERE act.client_id NOT IN (3301, 3303, 3302)));


