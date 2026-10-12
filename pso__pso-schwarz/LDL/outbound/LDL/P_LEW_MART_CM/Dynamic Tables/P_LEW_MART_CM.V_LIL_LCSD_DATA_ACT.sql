
CREATE TABLE IF NOT EXISTS ldl_p_lew_mart_cm.v_lil_lcsd_data_act
 AS
SELECT CAST(REG.region_id AS BIGNUMERIC) AS client_id,
 NULL AS clnt_rtl_id,
 RTL.rtl_id,
 CAST(CASE
   WHEN RTLPER.retailer_sid_parent IS NOT NULL
   THEN 15
   ELSE RTL.rtl_lvl
   END AS BIGNUMERIC) AS rtl_lvl,
 PERMS.period_id AS per_id,
 GFK.gfk_cat_id AS lift_cat_id,
 1 AS prom_id,
 DT.lcsd_id,
 CAST(TRUNC(CASE
    WHEN DT.data_confidence_fg = 1
    THEN 101
    ELSE 0
    END) AS BIGNUMERIC) AS raw_buyer_id,
 SUBSTR(CAST(CER.to_currency_iso_cd AS STRING), 1, 3) AS currency_iso_cd,
 meas.meas_id,
 CAST(CASE
    WHEN meas.meas_cd = 'turnover_val'
    THEN CAST(CAST(DT.turnover_val AS NUMERIC) / 1000 AS NUMERIC)
    WHEN meas.meas_cd = 'pot_turnover_val'
    THEN ROUND(CAST(DT.pot_turnover_val / 1000 AS NUMERIC), 5)
    WHEN meas.meas_cd = 'trip_cnt'
    THEN ROUND(CAST(DT.trip_cnt / 1000 AS NUMERIC), 5)
    WHEN meas.meas_cd = 'buyer_cnt'
    THEN ROUND(CAST(DT.buyer_cnt / 1000 AS NUMERIC), 5)
    WHEN meas.meas_cd = 'household_in_country_cnt'
    THEN ROUND(CAST(DT.household_in_country_cnt / 1000 AS NUMERIC), 5)
    WHEN meas.meas_cd = 'spend_per_trip_val'
    THEN DT.spend_per_trip_val
    WHEN meas.meas_cd = 'buy_freq'
    THEN DT.buy_freq
    WHEN meas.meas_cd = 'pot_turnover_exploit_pct'
    THEN DT.pot_turnover_exploit_pct
    WHEN meas.meas_cd = 'household_penetrate_pct'
    THEN DT.household_penetrate_pct
    WHEN meas.meas_cd = 'turnover_total_val'
    THEN DT.turnover_total_val
    WHEN meas.meas_cd = 'buyer_of_retailer_cnt'
    THEN DT.buyer_of_retailer_cnt
    WHEN meas.meas_cd = 'turnover_share_pct'
    THEN DT.turnover_share_pct
    WHEN meas.meas_cd = 'buyer_share_pct'
    THEN DT.buyer_share_pct
    WHEN meas.meas_cd = 'turnover_change_pct'
    THEN DT.turnover_change_pct
    WHEN meas.meas_cd = 'pot_turnover_change_pct'
    THEN DT.pot_turnover_change_pct
    WHEN meas.meas_cd = 'trip_cnt_change_pct'
    THEN DT.trip_cnt_change_pct
    WHEN meas.meas_cd = 'buyer_cnt_change_pct'
    THEN DT.buyer_cnt_change_pct
    WHEN meas.meas_cd = 'household_in_country_cnt_change_pct'
    THEN DT.household_in_country_cnt_change_pct
    WHEN meas.meas_cd = 'raw_buyer_change_pct'
    THEN DT.raw_buyer_change_pct
    WHEN meas.meas_cd = 'spend_per_trip_change_pct'
    THEN DT.spend_per_trip_change_pct
    WHEN meas.meas_cd = 'buy_freq_change_pct'
    THEN DT.buy_freq_change_pct
    WHEN meas.meas_cd = 'pot_turnover_exploit_change_pct'
    THEN DT.pot_turnover_exploit_change_pct
    WHEN meas.meas_cd = 'turnover_share_change_pct'
    THEN DT.turnover_share_change_pct
    WHEN meas.meas_cd = 'buyer_share_change_pct'
    THEN DT.buyer_share_change_pct
    WHEN meas.meas_cd = 'household_penetrate_change_pct'
    THEN DT.household_penetrate_change_pct
    ELSE NULL
    END * CASE
    WHEN meas.monetary_fg = 1
    THEN CER.rate_currency_exchange
    ELSE 1
    END AS NUMERIC) AS val,
 CAST(CASE
    WHEN meas.meas_cd = 'turnover_val'
    THEN CAST(CAST(PY.turnover_val AS NUMERIC) / 1000 AS NUMERIC)
    WHEN meas.meas_cd = 'pot_turnover_val'
    THEN ROUND(CAST(PY.pot_turnover_val / 1000 AS NUMERIC), 5)
    WHEN meas.meas_cd = 'trip_cnt'
    THEN ROUND(CAST(PY.trip_cnt / 1000 AS NUMERIC), 5)
    WHEN meas.meas_cd = 'buyer_cnt'
    THEN ROUND(CAST(PY.buyer_cnt / 1000 AS NUMERIC), 5)
    WHEN meas.meas_cd = 'household_in_country_cnt'
    THEN ROUND(CAST(PY.household_in_country_cnt / 1000 AS NUMERIC), 5)
    WHEN meas.meas_cd = 'spend_per_trip_val'
    THEN PY.spend_per_trip_val
    WHEN meas.meas_cd = 'buy_freq'
    THEN PY.buy_freq
    WHEN meas.meas_cd = 'pot_turnover_exploit_pct'
    THEN PY.pot_turnover_exploit_pct
    WHEN meas.meas_cd = 'household_penetrate_pct'
    THEN PY.household_penetrate_pct
    WHEN meas.meas_cd = 'turnover_total_val'
    THEN PY.turnover_total_val
    WHEN meas.meas_cd = 'buyer_of_retailer_cnt'
    THEN PY.buyer_of_retailer_cnt
    WHEN meas.meas_cd = 'turnover_share_pct'
    THEN PY.turnover_share_pct
    WHEN meas.meas_cd = 'buyer_share_pct'
    THEN PY.buyer_share_pct
    WHEN meas.meas_cd = 'turnover_change_pct'
    THEN PY.turnover_change_pct
    WHEN meas.meas_cd = 'pot_turnover_change_pct'
    THEN PY.pot_turnover_change_pct
    WHEN meas.meas_cd = 'trip_cnt_change_pct'
    THEN PY.trip_cnt_change_pct
    WHEN meas.meas_cd = 'buyer_cnt_change_pct'
    THEN PY.buyer_cnt_change_pct
    WHEN meas.meas_cd = 'household_in_country_cnt_change_pct'
    THEN PY.household_in_country_cnt_change_pct
    WHEN meas.meas_cd = 'raw_buyer_change_pct'
    THEN PY.raw_buyer_change_pct
    WHEN meas.meas_cd = 'spend_per_trip_change_pct'
    THEN PY.spend_per_trip_change_pct
    WHEN meas.meas_cd = 'buy_freq_change_pct'
    THEN PY.buy_freq_change_pct
    WHEN meas.meas_cd = 'pot_turnover_exploit_change_pct'
    THEN PY.pot_turnover_exploit_change_pct
    WHEN meas.meas_cd = 'turnover_share_change_pct'
    THEN PY.turnover_share_change_pct
    WHEN meas.meas_cd = 'buyer_share_change_pct'
    THEN PY.buyer_share_change_pct
    WHEN meas.meas_cd = 'household_penetrate_change_pct'
    THEN PY.household_penetrate_change_pct
    ELSE NULL
    END * CASE
    WHEN meas.monetary_fg = 1
    THEN CER.rate_currency_exchange
    ELSE 1
    END AS NUMERIC) AS py_val,
 CAST(COALESCE(DSDE.period_name, PER.period_name) AS STRING) AS per_desc,
 CAST(COALESCE(DSEN.period_name, PER.period_name) AS STRING) AS per_desc_en,
 CAST(COALESCE(PYDSDE.period_name, PYPER.period_name) AS STRING) AS py_per_desc,
 CAST(COALESCE(PYDSEN.period_name, PYPER.period_name) AS STRING) AS py_per_desc_en,
 0 AS prot_fg
FROM ldl_p_lew_core_ac.v_market_household_loyalty AS DT
 INNER JOIN ldl_p_lew_process_mstr_ac.v_lil_region AS REG ON DT.region_sid = REG.region_sid
 INNER JOIN ldl_p_lew_process_mstr_ac.v_lil_region_retailer AS RTL ON DT.client_id = RTL.client_id AND DT.retailer_sid =
    RTL.retailer_sid AND DT.region_sid = RTL.region_sid
 INNER JOIN ldl_p_lew_core_ac.v_lil_period AS PER ON DT.client_id = PER.client_id AND DT.period_sid = PER.period_sid
 LEFT JOIN ldl_p_lew_core_ac.v_lil_period_descr AS DSDE ON PER.period_sid = DSDE.period_sid AND DSDE.lang_cd = 'DE'
 LEFT JOIN ldl_p_lew_core_ac.v_lil_period_descr AS DSEN ON PER.period_sid = DSEN.period_sid AND DSEN.lang_cd = 'EN'
 INNER JOIN ldl_p_lew_process_mstr_ac.v_lil_period AS PERMS ON DT.client_id = PERMS.client_id AND DT.period_sid = PERMS
   .period_sid
 INNER JOIN ldl_p_lew_process_mstr_ac.v_lil_gfk_category AS GFK ON DT.client_id = GFK.client_id AND DT.gfk_cat_sid = GFK
   .gfk_cat_sid
 INNER JOIN ldl_p_lew_mart_cm.v_lil_currency_exch_rt AS CER ON DT.curr_cd = CER.from_currency_iso_cd
 LEFT JOIN ldl_p_lew_core_ac.v_market_household_loyalty AS PY ON DT.client_id = PY.client_id AND PER.period_sid_py = PY
       .period_sid AND DT.region_sid = PY.region_sid AND DT.retailer_sid = PY.retailer_sid AND DT.gfk_cat_sid = PY.gfk_cat_sid
     AND DT.lcsd_id = PY.lcsd_id
 LEFT JOIN ldl_p_lew_core_ac.v_lil_period AS PYPER ON PY.client_id = PYPER.client_id AND PY.period_sid = PYPER.period_sid
   
 LEFT JOIN ldl_p_lew_core_ac.v_lil_period_descr AS PYDSDE ON PYPER.period_sid = PYDSDE.period_sid AND PYDSDE.lang_cd =
   'DE'
 LEFT JOIN ldl_p_lew_core_ac.v_lil_period_descr AS PYDSEN ON PYPER.period_sid = PYDSEN.period_sid AND PYDSEN.lang_cd =
   'EN'
 LEFT JOIN ldl_p_lew_core_ac.v_lil_retailer_period AS RTLPER ON DT.client_id = RTLPER.client_id AND DT.retailer_sid =
      RTLPER.retailer_sid AND DT.period_sid = RTLPER.period_sid AND RTLPER.deleted_fg = 0 AND RTLPER.interface_name =
   'LIFT_FMCG_LCSD'
 INNER JOIN (SELECT meas_id,
   meas_cd,
   monetary_fg
  FROM ldl_p_lew_process_mstr_ac.v_lil_measure
  WHERE meas_cd IN ('turnover_val', 'pot_turnover_val', 'trip_cnt', 'buyer_cnt', 'household_in_country_cnt',
     'spend_per_trip_val', 'buy_freq', 'pot_turnover_exploit_pct', 'household_penetrate_pct', 'turnover_total_val',
     'buyer_of_retailer_cnt', 'turnover_share_pct', 'buyer_share_pct', 'turnover_change_pct', 'pot_turnover_change_pct'
     , 'trip_cnt_change_pct', 'buyer_cnt_change_pct', 'household_in_country_cnt_change_pct', 'raw_buyer_change_pct',
     'spend_per_trip_change_pct', 'buy_freq_change_pct', 'pot_turnover_exploit_change_pct', 'turnover_share_change_pct'
     , 'buyer_share_change_pct', 'household_penetrate_change_pct')) AS meas ON meas.meas_id NOT IN (43, 44)
WHERE COALESCE(DT.deleted_fg, 0) = 0 /* AND val IS NOT NULL */
 AND NOT EXISTS (SELECT NULL
  FROM ldl_p_lew_process_mstr_ac.v_lil_data_mask AS DM
  WHERE client_id = DT.client_id
   AND region_sid = DT.region_sid
   AND period_sid = DT.period_sid
   AND interface_name = 'LIFT_FMCG_LCSD'
   AND mask_data_fg = 1);


