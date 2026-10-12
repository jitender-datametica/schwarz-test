
CREATE TABLE ldl_p_lew_mart_cm.v_lil_liam_data_act AS
SELECT CAST(REG.region_id AS BIGNUMERIC) AS client_id,
 NULL AS clnt_rtl_id,
 RTL.rtl_id,
 CAST(CASE
   WHEN RTLPER.retailer_sid_parent IS NOT NULL
   THEN 15
   ELSE RTL.rtl_lvl
   END AS BIGNUMERIC) AS rtl_lvl,
 PERMS.period_id AS per_id,
 SUBSTR(CAST(SUBSTR(ASS.assort_region_cat_id, 1, 13) || '00005000000000' AS STRING), 1, 27) AS liam_parnt_clnt_cat_id,
 SUBSTR(CAST(ASS.assort_region_cat_id AS STRING), 1, 27) AS liam_clnt_cat_id,
 DT.promotion_brand_id AS prom_id,
 CAST(CASE
   WHEN DT.data_confidence_fg = 1
   THEN 101
   ELSE 0
   END AS BIGNUMERIC) AS raw_buyer_id,
 SUBSTR(CAST(CER.to_currency_iso_cd AS STRING), 1, 3) AS currency_iso_cd,
 meas.meas_id,
 CAST(meas.meas_tp_id AS BIGNUMERIC) AS meas_tp_id,
 CAST(CASE
    WHEN meas.meas_cd = 'turnover_val'
    THEN CAST(CAST(DT.turnover_val AS NUMERIC) / 1000 AS NUMERIC)
    WHEN meas.meas_cd = 'pot_turnover_val'
    THEN ROUND(CAST(DT.pot_turnover_val / 1000 AS NUMERIC), 5)
    WHEN meas.meas_cd = 'trip_cnt'
    THEN ROUND(CAST(DT.trip_cnt / 1000 AS NUMERIC), 5)
    WHEN meas.meas_cd = 'buyer_cnt'
    THEN ROUND(CAST(DT.buyer_cnt / 1000 AS NUMERIC), 5)
    WHEN meas.meas_cd = 'pot_buyer_cnt'
    THEN ROUND(CAST(DT.pot_buyer_cnt / 1000 AS NUMERIC), 5)
    WHEN meas.meas_cd = 'category_lidl_val'
    THEN ROUND(CAST(DT.category_lidl_val / 1000 AS NUMERIC), 5)
    WHEN meas.meas_cd = 'category_volume_pack_lidl_val'
    THEN ROUND(CAST(DT.category_volume_pack_lidl_val / 1000 AS NUMERIC), 5)
    WHEN meas.meas_cd = 'category_trips_lidl_cnt'
    THEN ROUND(CAST(DT.category_trips_lidl_cnt / 1000 AS NUMERIC), 5)
    WHEN meas.meas_cd = 'household_in_country_cnt'
    THEN ROUND(CAST(DT.household_in_country_cnt / 1000 AS NUMERIC), 5)
    WHEN meas.meas_cd = 'extrapol_qty'
    THEN DT.extrapol_qty
    WHEN meas.meas_cd = 'extrapol_package_cnt'
    THEN ROUND(CAST(DT.extrapol_package_cnt / 1000 AS NUMERIC), 5)
    WHEN meas.meas_cd = 'spend_per_trip_val'
    THEN DT.spend_per_trip_val
    WHEN meas.meas_cd = 'buy_freq'
    THEN DT.buy_freq
    WHEN meas.meas_cd = 'avg_price_per_pack_val'
    THEN DT.avg_price_per_pack_val
    WHEN meas.meas_cd = 'packs_per_trip_cnt'
    THEN DT.packs_per_trip_cnt
    WHEN meas.meas_cd = 'pot_turnover_exploit_pct'
    THEN DT.pot_turnover_exploit_pct
    WHEN meas.meas_cd = 'loyalty_pct'
    THEN DT.loyalty_pct
    WHEN meas.meas_cd = 'closure_rate_pct'
    THEN DT.closure_rate_pct
    WHEN meas.meas_cd = 'buyer_quality'
    THEN DT.buyer_quality
    WHEN meas.meas_cd = 'household_penetrate_pct'
    THEN DT.household_penetrate_pct
    WHEN meas.meas_cd = 'pot_turnover_pct'
    THEN DT.pot_turnover_pct
    WHEN meas.meas_cd = 'lidl_market_share_pct'
    THEN DT.lidl_market_share_pct
    WHEN meas.meas_cd = 'category_share_pct'
    THEN DT.category_share_pct
    WHEN meas.meas_cd = 'category_volume_pack_share_pct'
    THEN DT.category_volume_pack_share_pct
    WHEN meas.meas_cd = 'turnover_share_pct'
    THEN DT.turnover_share_pct
    WHEN meas.meas_cd = 'lidl_buyer_turnover_val'
    THEN ROUND(CAST(DT.lidl_buyer_turnover_val / 1000 AS NUMERIC), 5)
    WHEN meas.meas_cd = 'lidl_buyer_turnover_pot_val'
    THEN ROUND(CAST(DT.lidl_buyer_turnover_pot_val / 1000 AS NUMERIC), 5)
    WHEN meas.meas_cd = 'lidl_buyer_trip_cnt'
    THEN ROUND(CAST(DT.lidl_buyer_trip_cnt / 1000 AS NUMERIC), 5)
    WHEN meas.meas_cd = 'lidl_buyer_trip_pot_cnt'
    THEN ROUND(CAST(DT.lidl_buyer_trip_pot_cnt / 1000 AS NUMERIC), 5)
    WHEN meas.meas_cd = 'lidl_buyer_cnt'
    THEN ROUND(CAST(DT.lidl_buyer_cnt / 1000 AS NUMERIC), 5)
    WHEN meas.meas_cd = 'lidl_buyer_pot_cnt'
    THEN ROUND(CAST(DT.lidl_buyer_pot_cnt / 1000 AS NUMERIC), 5)
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
    WHEN meas.meas_cd = 'pot_buyer_cnt'
    THEN ROUND(CAST(PY.pot_buyer_cnt / 1000 AS NUMERIC), 5)
    WHEN meas.meas_cd = 'category_lidl_val'
    THEN ROUND(CAST(PY.category_lidl_val / 1000 AS NUMERIC), 5)
    WHEN meas.meas_cd = 'category_volume_pack_lidl_val'
    THEN ROUND(CAST(PY.category_volume_pack_lidl_val / 1000 AS NUMERIC), 5)
    WHEN meas.meas_cd = 'category_trips_lidl_cnt'
    THEN ROUND(CAST(PY.category_trips_lidl_cnt / 1000 AS NUMERIC), 5)
    WHEN meas.meas_cd = 'household_in_country_cnt'
    THEN ROUND(CAST(PY.household_in_country_cnt / 1000 AS NUMERIC), 5)
    WHEN meas.meas_cd = 'extrapol_qty'
    THEN PY.extrapol_qty
    WHEN meas.meas_cd = 'extrapol_package_cnt'
    THEN ROUND(CAST(PY.extrapol_package_cnt / 1000 AS NUMERIC), 5)
    WHEN meas.meas_cd = 'spend_per_trip_val'
    THEN PY.spend_per_trip_val
    WHEN meas.meas_cd = 'buy_freq'
    THEN PY.buy_freq
    WHEN meas.meas_cd = 'avg_price_per_pack_val'
    THEN PY.avg_price_per_pack_val
    WHEN meas.meas_cd = 'packs_per_trip_cnt'
    THEN PY.packs_per_trip_cnt
    WHEN meas.meas_cd = 'pot_turnover_exploit_pct'
    THEN PY.pot_turnover_exploit_pct
    WHEN meas.meas_cd = 'loyalty_pct'
    THEN PY.loyalty_pct
    WHEN meas.meas_cd = 'closure_rate_pct'
    THEN PY.closure_rate_pct
    WHEN meas.meas_cd = 'buyer_quality'
    THEN PY.buyer_quality
    WHEN meas.meas_cd = 'household_penetrate_pct'
    THEN PY.household_penetrate_pct
    WHEN meas.meas_cd = 'pot_turnover_pct'
    THEN PY.pot_turnover_pct
    WHEN meas.meas_cd = 'lidl_market_share_pct'
    THEN PY.lidl_market_share_pct
    WHEN meas.meas_cd = 'category_share_pct'
    THEN PY.category_share_pct
    WHEN meas.meas_cd = 'category_volume_pack_share_pct'
    THEN PY.category_volume_pack_share_pct
    WHEN meas.meas_cd = 'turnover_share_pct'
    THEN PY.turnover_share_pct
    WHEN meas.meas_cd = 'lidl_buyer_turnover_val'
    THEN ROUND(CAST(PY.lidl_buyer_turnover_val / 1000 AS NUMERIC), 5)
    WHEN meas.meas_cd = 'lidl_buyer_turnover_pot_val'
    THEN ROUND(CAST(PY.lidl_buyer_turnover_pot_val / 1000 AS NUMERIC), 5)
    WHEN meas.meas_cd = 'lidl_buyer_trip_cnt'
    THEN ROUND(CAST(PY.lidl_buyer_trip_cnt / 1000 AS NUMERIC), 5)
    WHEN meas.meas_cd = 'lidl_buyer_trip_pot_cnt'
    THEN ROUND(CAST(PY.lidl_buyer_trip_pot_cnt / 1000 AS NUMERIC), 5)
    WHEN meas.meas_cd = 'lidl_buyer_cnt'
    THEN ROUND(CAST(PY.lidl_buyer_cnt / 1000 AS NUMERIC), 5)
    WHEN meas.meas_cd = 'lidl_buyer_pot_cnt'
    THEN ROUND(CAST(PY.lidl_buyer_pot_cnt / 1000 AS NUMERIC), 5)
    ELSE NULL
    END * CASE
    WHEN meas.monetary_fg = 1
    THEN CER.rate_currency_exchange
    ELSE 1
    END AS NUMERIC) AS py_val,
 NULL AS pq_val,
 1 AS data_avbl_fg,
 1 AS prot_fg
FROM ldl_p_lew_core_ac.v_market_familygroup AS DT
 INNER JOIN ldl_p_lew_process_mstr_ac.v_lil_region AS REG ON DT.region_sid = REG.region_sid
 INNER JOIN ldl_p_lew_process_mstr_ac.v_lil_region_retailer AS RTL ON DT.client_id = RTL.client_id AND DT.retailer_sid =
    RTL.retailer_sid AND DT.region_sid = RTL.region_sid
 INNER JOIN ldl_p_lew_core_ac.v_lil_period AS PER ON DT.client_id = PER.client_id AND DT.period_sid = PER.period_sid
 INNER JOIN ldl_p_lew_process_mstr_ac.v_lil_period AS PERMS ON DT.client_id = PERMS.client_id AND DT.period_sid = PERMS
   .period_sid
 INNER JOIN ldl_p_lew_process_mstr_ac.v_lil_assort_region_cat AS ASS ON DT.client_id = ASS.client_id AND DT.region_sid =
    ASS.region_sid AND DT.assort_cat_sid = ASS.assort_cat_sid
 INNER JOIN ldl_p_lew_core_ac.v_lil_assort_category AS ASSC ON ASS.client_id = ASSC.client_id AND ASS.assort_cat_sid =
   ASSC.assort_cat_sid
 INNER JOIN ldl_p_lew_mart_cm.v_lil_currency_exch_rt AS CER ON DT.curr_cd = CER.from_currency_iso_cd
 LEFT JOIN ldl_p_lew_core_ac.v_market_familygroup AS PY ON DT.client_id = PY.client_id AND PER.period_sid_py = PY.period_sid
        AND DT.region_sid = PY.region_sid AND DT.retailer_sid = PY.retailer_sid AND DT.assort_cat_sid = PY.assort_cat_sid
     AND DT.promotion_brand_id = PY.promotion_brand_id
 LEFT JOIN ldl_p_lew_core_ac.v_lil_period AS PYPER ON PY.client_id = PYPER.client_id AND PY.period_sid = PYPER.period_sid
   
 LEFT JOIN ldl_p_lew_core_ac.v_lil_retailer_period AS RTLPER ON DT.client_id = RTLPER.client_id AND DT.retailer_sid =
      RTLPER.retailer_sid AND DT.period_sid = RTLPER.period_sid AND RTLPER.deleted_fg = 0 AND RTLPER.interface_name =
   'LIAM_FMCG_Core'
 INNER JOIN (SELECT meas_id,
   meas_cd,
   monetary_fg,
   meas_tp_id
  FROM ldl_p_lew_process_mstr_ac.v_lil_measure
  WHERE meas_cd IN ('turnover_val', 'pot_turnover_val', 'trip_cnt', 'buyer_cnt', 'pot_buyer_cnt', 'category_lidl_val',
     'category_volume_pack_lidl_val', 'category_trips_lidl_cnt', 'household_in_country_cnt', 'extrapol_qty',
     'extrapol_package_cnt', 'spend_per_trip_val', 'buy_freq', 'avg_price_per_pack_val', 'packs_per_trip_cnt',
     'pot_turnover_exploit_pct', 'loyalty_pct', 'closure_rate_pct', 'buyer_quality', 'household_penetrate_pct',
     'pot_turnover_pct', 'lidl_market_share_pct', 'category_share_pct', 'category_volume_pack_share_pct',
     'turnover_share_pct', 'lidl_buyer_turnover_val', 'lidl_buyer_turnover_pot_val', 'lidl_buyer_trip_cnt',
     'lidl_buyer_trip_pot_cnt', 'lidl_buyer_cnt', 'lidl_buyer_pot_cnt')) AS meas ON meas.meas_id NOT IN (44, 46)
WHERE COALESCE(DT.deleted_fg, 0) = 0
 AND NOT EXISTS (SELECT NULL
  FROM ldl_p_lew_process_mstr_ac.v_lil_data_mask AS DM
  WHERE client_id = DT.client_id
   AND region_sid = DT.region_sid
   AND period_sid = DT.period_sid
   AND src_assort_parent_cat_cd = LTRIM(ASSC.src_assort_parent_cat_cd)
   AND interface_name = 'LIAM_FMCG_Core'
   AND mask_data_fg = 1);


