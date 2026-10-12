CREATE OR REPLACE VIEW P_LEW_MART_CM.V_LIL_LIFT_PERIOD_PORTION
(
  client_id
, per_id
, lift_cat_id
, rtl_id
, rtl_lvl
, prom_id
, period_portion_id
, currency_iso_cd
, household_in_country_cnt
, turnover_val
, pot_turnover_val
, household_penetrate_pct
, buyer_cnt
, pot_buyer_cnt
, trip_cnt
, buy_freq
, spend_per_buyer_val
, spend_per_trip_val
, category_lidl_val
, pot_turnover_exploit_pct
, loyalty_pct
, closure_rate_pct
, buyer_quality
, lidl_market_share_pct
, py_household_in_country_cnt
, py_turnover_val
, py_pot_turnover_val
, py_household_penetrate_pct
, py_buyer_cnt
, py_pot_buyer_cnt
, py_trip_cnt
, py_buy_freq
, py_spend_per_buyer_val
, py_spend_per_trip_val
, py_category_lidl_val
, py_pot_turnover_exploit_pct
, py_loyalty_pct
, py_closure_rate_pct
, py_buyer_quality
, py_lidl_market_share_pct
, raw_buyer_id
, per_desc
, per_desc_EN
, py_per_desc
, py_per_desc_EN
)
AS
SELECT
  reg.region_id         AS client_id
, per.period_id         AS per_id
, gfk.gfk_cat_id        AS lift_cat_id
, rtl.rtl_id            AS rtl_id
,CAST(CASE
        WHEN rtlper.retailer_sid_parent IS NOT NULL THEN 15
        ELSE rtl.rtl_lvl END AS SMALLINT) AS rtl_lvl
, dt.promotion_brand_id AS prom_id
, dt.period_portion_id  AS period_portion_id
, cerdt.to_currency_iso_cd AS currency_iso_cd
, (dt.household_in_country_cnt/1000)::Decimal(23,5) AS household_in_country_cnt
, (dt.turnover_val * cerdt.rate_currency_exchange
                   /1000)::Decimal(23,5)            AS turnover_val
, (dt.pot_turnover_val * cerdt.rate_currency_exchange
                   /1000)::Decimal(23,5)            AS pot_turnover_val
, dt.household_penetrate_pct                        AS household_penetrate_pct
, (dt.buyer_cnt/1000)::Decimal(23,5)                AS buyer_cnt
, (dt.pot_buyer_cnt/1000)::Decimal(23,5)            AS pot_buyer_cnt
, (dt.trip_cnt/1000)::Decimal(23,5)                 AS trip_cnt
, dt.buy_freq                                       AS buy_freq
, (dt.spend_per_buyer_val *
      cerdt.rate_currency_exchange)::Decimal(23,5)  AS spend_per_buyer_val
, (dt.spend_per_trip_val *
      cerdt.rate_currency_exchange)::Decimal(23,5)  AS spend_per_trip_val
, (dt.category_lidl_val * cerdt.rate_currency_exchange
                   /1000)::Decimal(23,5)            AS category_lidl_val
, dt.pot_turnover_exploit_pct                       AS pot_turnover_exploit_pct
, dt.loyalty_pct                                    AS loyalty_pct
, dt.closure_rate_pct                               AS closure_rate_pct
, dt.buyer_quality                                  AS buyer_quality
, dt.lidl_market_share_pct                          AS lidl_market_share_pct
, (py.household_in_country_cnt/1000)::Decimal(23,5) AS py_household_in_country_cnt
, (py.turnover_val * cerpy.rate_currency_exchange
                   /1000)::Decimal(23,5)            AS py_turnover_val
, (py.pot_turnover_val * cerpy.rate_currency_exchange
                   /1000)::Decimal(23,5)            AS py_pot_turnover_val
, py.household_penetrate_pct                        AS py_household_penetrate_pct
, (py.buyer_cnt/1000)::Decimal(23,5)                AS py_buyer_cnt
, (py.pot_buyer_cnt/1000)::Decimal(23,5)            AS py_pot_buyer_cnt
, (py.trip_cnt/1000)::Decimal(23,5)                 AS py_trip_cnt
, py.buy_freq                                       AS py_buy_freq
, (py.spend_per_buyer_val *
      cerpy.rate_currency_exchange)::Decimal(23,5)  AS py_spend_per_buyer_val
, (py.spend_per_trip_val *
      cerpy.rate_currency_exchange)::Decimal(23,5)  AS py_spend_per_trip_val
, (py.category_lidl_val * cerpy.rate_currency_exchange
                   /1000)::Decimal(23,5)            AS py_category_lidl_val
, py.pot_turnover_exploit_pct                       AS py_pot_turnover_exploit_pct
, py.loyalty_pct                                    AS py_loyalty_pct
, py.closure_rate_pct                               AS py_closure_rate_pct
, py.buyer_quality                                  AS py_buyer_quality
, py.lidl_market_share_pct                          AS py_lidl_market_share_pct
, CAST(TRUNC(CASE
    WHEN dt.data_confidence_fg  = 1 THEN 101
    ELSE 0 END) AS INTEGER) AS raw_buyer_id
, CAST(COALESCE(dsde.period_name, cper.period_name) AS VARCHAR(128)) AS per_desc
, CAST(COALESCE(dsen.period_name, cper.period_name) AS VARCHAR(128)) AS per_desc_EN
, CAST(COALESCE(pydsde.period_name, pyper.period_name) AS VARCHAR(128)) AS py_per_desc
, CAST(COALESCE(pydsen.period_name, pyper.period_name) AS VARCHAR(128)) AS py_per_desc_EN
FROM P_LEW_CORE_AC.V_MARKET_PERIOD_PORTION AS dt
INNER JOIN P_LEW_PROCESS_MSTR_AC.V_LIL_REGION AS reg
    ON reg.region_sid = dt.region_sid
INNER JOIN P_LEW_PROCESS_MSTR_AC.V_LIL_PERIOD AS per
    ON per.client_id = dt.client_id
   AND per.period_sid = dt.period_sid
INNER JOIN P_LEW_CORE_AC.V_LIL_PERIOD AS cper
    ON cper.client_id = per.client_id
   AND cper.period_sid = per.period_sid
INNER JOIN P_LEW_CORE_AC.V_LIL_PERIOD AS pyper
    ON pyper.client_id = cper.client_id
   AND pyper.period_sid = cper.period_sid_py
INNER JOIN P_LEW_MART_CM.V_LIL_CURRENCY_EXCH_RT AS cerdt
    ON cerdt.from_currency_iso_cd = dt.curr_cd
LEFT OUTER JOIN P_LEW_CORE_AC.V_MARKET_PERIOD_PORTION AS py
    ON py.client_id = dt.client_id
   AND py.region_sid = dt.region_sid
   AND py.period_sid = cper.period_sid_py
   AND py.gfk_cat_sid = dt.gfk_cat_sid
   AND py.retailer_sid = dt.retailer_sid
   AND py.promotion_brand_id = dt.promotion_brand_id
   AND py.period_portion_id = dt.period_portion_id
   AND py.curr_cd = dt.curr_cd
LEFT OUTER JOIN P_LEW_MART_CM.V_LIL_CURRENCY_EXCH_RT AS cerpy
    ON cerpy.from_currency_iso_cd = py.curr_cd
   AND cerpy.to_currency_iso_cd = cerdt.to_currency_iso_cd
LEFT OUTER JOIN P_LEW_CORE_AC.V_LIL_PERIOD_DESCR AS dsde
    ON dsde.period_sid = cper.period_sid
    AND dsde.lang_cd = 'DE'
LEFT OUTER JOIN P_LEW_CORE_AC.V_LIL_PERIOD_DESCR AS dsen
    ON dsen.period_sid = cper.period_sid
    AND dsen.lang_cd = 'EN'
LEFT OUTER JOIN P_LEW_CORE_AC.V_LIL_PERIOD_DESCR AS pydsde
    ON pydsde.period_sid = pyper.period_sid
    AND pydsde.lang_cd = 'DE'
LEFT OUTER JOIN P_LEW_CORE_AC.V_LIL_PERIOD_DESCR AS pydsen
    ON pydsen.period_sid = pyper.period_sid
    AND pydsen.lang_cd = 'EN'
LEFT OUTER JOIN P_LEW_CORE_AC.v_lil_retailer_period AS rtlper
    ON rtlper.client_id = dt.client_id
    AND rtlper.retailer_sid = dt.retailer_sid
    AND rtlper.period_sid = dt.period_sid
    AND rtlper.deleted_fg = 0
    AND rtlper.interface_name = 'LIFT_FMCG_Period_Portion'
INNER JOIN P_LEW_PROCESS_MSTR_AC.V_LIL_GFK_CATEGORY AS gfk
    ON gfk.client_id = dt.client_id
   AND gfk.gfk_cat_sid = dt.gfk_cat_sid
INNER JOIN P_LEW_PROCESS_MSTR_AC.V_LIL_REGION_RETAILER AS rtl
    ON rtl.retailer_sid = dt.retailer_sid
    AND rtl.region_sid = dt.region_sid
LEFT OUTER JOIN (
  SELECT dm.client_id, dm.region_sid, dm.period_sid
  FROM P_LEW_PROCESS_MSTR_AC.V_LIL_DATA_MASK AS dm
  WHERE dm.interface_name = 'LIFT_FMCG_Period_Portion'
    AND dm.mask_data_fg = 1
) AS dtm
  ON dtm.client_id = dt.client_id
 AND dtm.region_sid = dt.region_sid
 AND dtm.period_sid = dt.period_sid
WHERE COALESCE(dt.deleted_fg, 0) = 0
  AND dtm.client_id IS NULL

UNION ALL
SELECT
  reg.region_id         AS client_id
, ptp.ltst_pseudo_period_id AS per_id
, gfk.gfk_cat_id        AS lift_cat_id
, rtl.rtl_id            AS rtl_id
,CAST(CASE
        WHEN rtlper.retailer_sid_parent IS NOT NULL THEN 15
        ELSE rtl.rtl_lvl END AS SMALLINT) AS rtl_lvl
, dt.promotion_brand_id AS prom_id
, dt.period_portion_id  AS period_portion_id
, cerdt.to_currency_iso_cd   AS currency_iso_cd

, (dt.household_in_country_cnt/1000)::Decimal(23,5) AS household_in_country_cnt
, (dt.turnover_val * cerdt.rate_currency_exchange
                   /1000)::Decimal(23,5)            AS turnover_val
, (dt.pot_turnover_val * cerdt.rate_currency_exchange
                   /1000)::Decimal(23,5)            AS pot_turnover_val
, dt.household_penetrate_pct                        AS household_penetrate_pct
, (dt.buyer_cnt/1000)::Decimal(23,5)                AS buyer_cnt
, (dt.pot_buyer_cnt/1000)::Decimal(23,5)            AS pot_buyer_cnt
, (dt.trip_cnt/1000)::Decimal(23,5)                 AS trip_cnt
, dt.buy_freq                                       AS buy_freq
, (dt.spend_per_buyer_val *
      cerdt.rate_currency_exchange)::Decimal(23,5)  AS spend_per_buyer_val
, (dt.spend_per_trip_val *
      cerdt.rate_currency_exchange)::Decimal(23,5)  AS spend_per_trip_val
, (dt.category_lidl_val * cerdt.rate_currency_exchange
                   /1000)::Decimal(23,5)            AS category_lidl_val
, dt.pot_turnover_exploit_pct                       AS pot_turnover_exploit_pct
, dt.loyalty_pct                                    AS loyalty_pct
, dt.closure_rate_pct                               AS closure_rate_pct
, dt.buyer_quality                                  AS buyer_quality
, dt.lidl_market_share_pct                          AS lidl_market_share_pct

, (py.household_in_country_cnt/1000)::Decimal(23,5) AS py_household_in_country_cnt
, (py.turnover_val * cerpy.rate_currency_exchange
                   /1000)::Decimal(23,5)            AS py_turnover_val
, (py.pot_turnover_val * cerpy.rate_currency_exchange
                   /1000)::Decimal(23,5)            AS py_pot_turnover_val
, py.household_penetrate_pct                        AS py_household_penetrate_pct
, (py.buyer_cnt/1000)::Decimal(23,5)                AS py_buyer_cnt
, (py.pot_buyer_cnt/1000)::Decimal(23,5)            AS py_pot_buyer_cnt
, (py.trip_cnt/1000)::Decimal(23,5)                 AS py_trip_cnt
, py.buy_freq                                       AS py_buy_freq
, (py.spend_per_buyer_val *
      cerpy.rate_currency_exchange)::Decimal(23,5)  AS py_spend_per_buyer_val
, (py.spend_per_trip_val *
      cerpy.rate_currency_exchange)::Decimal(23,5)  AS py_spend_per_trip_val
, (py.category_lidl_val * cerpy.rate_currency_exchange
                   /1000)::Decimal(23,5)            AS py_category_lidl_val
, py.pot_turnover_exploit_pct                       AS py_pot_turnover_exploit_pct
, py.loyalty_pct                                    AS py_loyalty_pct
, py.closure_rate_pct                               AS py_closure_rate_pct
, py.buyer_quality                                  AS py_buyer_quality
, py.lidl_market_share_pct                          AS py_lidl_market_share_pct

, CAST(TRUNC(CASE
    WHEN dt.data_confidence_fg  = 1 THEN 101
    ELSE 0 END) AS INTEGER) AS raw_buyer_id
, CAST(COALESCE(dsde.period_name, cper.period_name) AS VARCHAR(128)) AS per_desc
, CAST(COALESCE(dsen.period_name, cper.period_name) AS VARCHAR(128)) AS per_desc_EN
, CAST(COALESCE(pydsde.period_name, pyper.period_name) AS VARCHAR(128)) AS py_per_desc
, CAST(COALESCE(pydsen.period_name, pyper.period_name) AS VARCHAR(128)) AS py_per_desc_EN
FROM P_LEW_CORE_AC.V_MARKET_PERIOD_PORTION AS dt
INNER JOIN P_LEW_PROCESS_MSTR_AC.V_LIL_REGION AS reg
    ON reg.region_sid = dt.region_sid
INNER JOIN P_LEW_PROCESS_MSTR_AC.V_LIL_PERIOD AS per
    ON per.client_id = dt.client_id
   AND per.period_sid = dt.period_sid
INNER JOIN P_LEW_CORE_AC.V_LIL_PERIOD AS cper
    ON cper.client_id = per.client_id
   AND cper.period_sid = per.period_sid
INNER JOIN P_LEW_PROCESS_MSTR_AC.V_LIL_REGION_PER_LATEST AS rpl
   ON rpl.client_id = dt.client_id
  AND rpl.region_sid = dt.region_sid
  AND rpl.class_cd = 'LIFTPP'
  AND rpl.ltst_per_id = per.period_id
INNER JOIN P_LEW_PROCESS_MSTR_AC.V_LIL_PERIOD_TYPE AS ptp
    ON ptp.period_type_id = rpl.per_tp_id
    AND ptp.ltst_pseudo_period_id IS NOT NULL
INNER JOIN P_LEW_CORE_AC.V_LIL_PERIOD AS pyper
    ON pyper.client_id = cper.client_id
   AND pyper.period_sid = cper.period_sid_py
INNER JOIN P_LEW_MART_CM.V_LIL_CURRENCY_EXCH_RT AS cerdt
    ON cerdt.from_currency_iso_cd = dt.curr_cd
LEFT OUTER JOIN P_LEW_CORE_AC.V_MARKET_PERIOD_PORTION AS py
    ON py.client_id = dt.client_id
   AND py.region_sid = dt.region_sid
   AND py.period_sid = cper.period_sid_py
   AND py.gfk_cat_sid = dt.gfk_cat_sid
   AND py.retailer_sid = dt.retailer_sid
   AND py.promotion_brand_id = dt.promotion_brand_id
   AND py.period_portion_id = dt.period_portion_id
   AND py.curr_cd = dt.curr_cd
LEFT OUTER JOIN P_LEW_MART_CM.V_LIL_CURRENCY_EXCH_RT AS cerpy
    ON cerpy.from_currency_iso_cd = py.curr_cd
   AND cerpy.to_currency_iso_cd = cerdt.to_currency_iso_cd
LEFT OUTER JOIN P_LEW_CORE_AC.V_LIL_PERIOD_DESCR AS dsde
    ON dsde.period_sid = cper.period_sid
    AND dsde.lang_cd = 'DE'
LEFT OUTER JOIN P_LEW_CORE_AC.V_LIL_PERIOD_DESCR AS dsen
    ON dsen.period_sid = cper.period_sid
    AND dsen.lang_cd = 'EN'
LEFT OUTER JOIN P_LEW_CORE_AC.V_LIL_PERIOD_DESCR AS pydsde
    ON pydsde.period_sid = pyper.period_sid
    AND pydsde.lang_cd = 'DE'
LEFT OUTER JOIN P_LEW_CORE_AC.V_LIL_PERIOD_DESCR AS pydsen
    ON pydsen.period_sid = pyper.period_sid
    AND pydsen.lang_cd = 'EN'
LEFT OUTER JOIN P_LEW_CORE_AC.v_lil_retailer_period AS rtlper
    ON rtlper.client_id = dt.client_id
    AND rtlper.retailer_sid = dt.retailer_sid
    AND rtlper.period_sid = dt.period_sid
    AND rtlper.deleted_fg = 0
    AND rtlper.interface_name = 'LIFT_FMCG_Period_Portion'
INNER JOIN P_LEW_PROCESS_MSTR_AC.V_LIL_GFK_CATEGORY AS gfk
    ON gfk.client_id = dt.client_id
   AND gfk.gfk_cat_sid = dt.gfk_cat_sid
INNER JOIN P_LEW_PROCESS_MSTR_AC.V_LIL_REGION_RETAILER AS rtl
    ON rtl.retailer_sid = dt.retailer_sid
    AND rtl.region_sid = dt.region_sid
LEFT OUTER JOIN (
  SELECT dm.client_id, dm.region_sid, dm.period_sid
  FROM P_LEW_PROCESS_MSTR_AC.V_LIL_DATA_MASK AS dm
  WHERE dm.interface_name = 'LIFT_FMCG_Period_Portion'
    AND dm.mask_data_fg = 1
) AS dtm
  ON dtm.client_id = dt.client_id
 AND dtm.region_sid = dt.region_sid
 AND dtm.period_sid = dt.period_sid
WHERE COALESCE(dt.deleted_fg, 0) = 0
  AND dtm.client_id IS NULL
;
