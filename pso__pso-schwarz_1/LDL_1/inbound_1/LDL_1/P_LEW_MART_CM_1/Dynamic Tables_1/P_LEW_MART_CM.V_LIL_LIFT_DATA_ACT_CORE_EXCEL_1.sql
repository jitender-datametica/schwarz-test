CREATE OR REPLACE DYNAMIC TABLE LDL_PRODUCTION_CLONE_GOOGLE_20260608_1030.P_LEW_MART_CM.V_LIL_LIFT_DATA_ACT_CORE_EXCEL_1(
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
) target_lag = '1 hour, 30 minutes' refresh_mode = FULL initialize = ON_CREATE warehouse = WH_LDL_D_DYNAMIC_TABLE_P_LEW_MART_CM
 as
WITH periods_base AS (
    SELECT
        T1.CLIENT_ID,
        T1.PER_ID,
        T1.APPLICATION_ID,
        T1.ACTIVE_FG,
        COALESCE(T3.ACTIVE_FG, 0) AS ACTIVE_FG_PY,
        T1.TRANSACTION_TMSP
    FROM P_LEW_MART_CM.T_LIL_HISTORICAL_PERIODS_PER_CLIENT_AND_APPLICATION_1 AS T1_1
    JOIN P_LEW_MART_CM.V_LIL_PERIOD_1 AS T2
      ON T1.PER_ID = T2.PER_ID
    JOIN P_LEW_MART_CM.T_LIL_HISTORICAL_PERIODS_PER_CLIENT_AND_APPLICATION_1 AS T3
      ON T2.PY_PER_ID = T3.PER_ID
     AND T1.CLIENT_ID = T3.CLIENT_ID
     AND T1.APPLICATION_ID = T3.APPLICATION_ID
),
periods AS (
    SELECT
        CLIENT_ID,
        PER_ID,
        APPLICATION_ID,
        ACTIVE_FG,
        ACTIVE_FG_PY,
        TRANSACTION_TMSP
    FROM periods_base

    UNION ALL

    SELECT DISTINCT
        7 AS CLIENT_ID,
        PER_ID,
        APPLICATION_ID,
        ACTIVE_FG,
        1 AS ACTIVE_FG_PY,
        TRANSACTION_TMSP
    FROM periods_base
    WHERE CLIENT_ID NOT IN (3301,3302,3303)
),
 base AS (
SELECT
CAST(reg.region_id AS SMALLINT) AS client_id
,rtl.rtl_id
,CAST(CASE
        WHEN rtlper.retailer_sid_parent IS NOT NULL THEN 15
        ELSE rtl.rtl_lvl END AS SMALLINT) AS rtl_lvl
,perms.period_id AS per_id
,per.period_year
,gfk.gfk_cat_id AS lift_cat_id
,dt.promotion_brand_id AS prom_id
,CAST(TRUNC(CASE
WHEN dt.data_confidence_fg  = 1 THEN 101
WHEN (dt.data_confidence_fg  IS NULL OR dt.data_confidence_fg = 0) AND  meas.meas_id IN (49, 50, 51, 52, 53) THEN 101
ELSE 0 END) AS INTEGER) AS raw_buyer_id
,CAST(cer.to_currency_iso_cd AS CHAR(3)) AS currency_iso_cd
,meas.meas_id

,CAST(CASE WHEN meas.meas_cd = 'turnover_val' THEN (CAST(dt.turnover_val AS DECIMAL(38,11))/1000)::Decimal(23,5) END * CASE WHEN meas.monetary_fg = 1 THEN cer.rate_currency_exchange ELSE 1 END AS DECIMAL(23,5)) AS TURNOVER_VAL
,CAST(CASE WHEN meas.meas_cd = 'pot_turnover_val'  THEN (dt.pot_turnover_val/1000)::Decimal(23,5) END * CASE WHEN meas.monetary_fg = 1 THEN cer.rate_currency_exchange ELSE 1 END AS DECIMAL(23,5)) AS POT_TURNOVER_VAL
,CAST(CASE WHEN meas.meas_cd = 'turnover_category_val'  THEN (dt.turnover_category_val/1000)::Decimal(23,5) END * CASE WHEN meas.monetary_fg = 1 THEN cer.rate_currency_exchange ELSE 1 END AS DECIMAL(23,5)) AS TURNOVER_CATEGORY_VAL
,CAST(CASE WHEN meas.meas_cd = 'trip_cnt' THEN (dt.trip_cnt/1000)::Decimal(23,5) END * CASE WHEN meas.monetary_fg = 1 THEN cer.rate_currency_exchange ELSE 1 END AS DECIMAL(23,5)) AS TRIP_CNT
,CAST(CASE WHEN meas.meas_cd = 'buyer_cnt' THEN (dt.buyer_cnt/1000)::Decimal(23,5) END * CASE WHEN meas.monetary_fg = 1 THEN cer.rate_currency_exchange ELSE 1 END AS DECIMAL(23,5)) AS BUYER_CNT
,CAST(CASE WHEN meas.meas_cd = 'pot_buyer_cnt' THEN (dt.pot_buyer_cnt/1000)::Decimal(23,5) END * CASE WHEN meas.monetary_fg = 1 THEN cer.rate_currency_exchange ELSE 1 END AS DECIMAL(23,5)) AS POT_BUYER_CNT
,CAST(CASE WHEN meas.meas_cd = 'household_in_country_cnt' THEN (dt.household_in_country_cnt/1000)::Decimal(23,5) END * CASE WHEN meas.monetary_fg = 1 THEN cer.rate_currency_exchange ELSE 1 END AS DECIMAL(23,5)) AS HOUSEHOLD_IN_COUNTRY_CNT
,CAST(CASE WHEN meas.meas_cd = 'spend_per_trip_val' THEN dt.spend_per_trip_val END * CASE WHEN meas.monetary_fg = 1 THEN cer.rate_currency_exchange ELSE 1 END AS DECIMAL(23,5)) AS SPEND_PER_TRIP_VAL
,CAST(CASE WHEN meas.meas_cd = 'spend_per_buyer_val' THEN dt.spend_per_buyer_val END * CASE WHEN meas.monetary_fg = 1 THEN cer.rate_currency_exchange ELSE 1 END AS DECIMAL(23,5)) AS SPEND_PER_BUYER_VAL
,CAST(CASE WHEN meas.meas_cd = 'buy_freq' THEN dt.buy_freq END * CASE WHEN meas.monetary_fg = 1 THEN cer.rate_currency_exchange ELSE 1 END AS DECIMAL(23,5)) AS BUY_FREQ
,CAST(CASE WHEN meas.meas_cd = 'buyer_quality' THEN dt.buyer_quality END * CASE WHEN meas.monetary_fg = 1 THEN cer.rate_currency_exchange ELSE 1 END AS DECIMAL(23,5)) AS BUYER_QUALITY
,CAST(CASE WHEN meas.meas_cd = 'lidl_buyer_turnover_val' THEN (dt.lidl_buyer_turnover_val/1000)::Decimal(23,5) END * CASE WHEN meas.monetary_fg = 1 THEN cer.rate_currency_exchange ELSE 1 END AS DECIMAL(23,5)) AS LIDL_BUYER_TURNOVER_VAL
,CAST(CASE WHEN meas.meas_cd = 'loyalty_pct' THEN dt.loyalty_pct END * CASE WHEN meas.monetary_fg = 1 THEN cer.rate_currency_exchange ELSE 1 END AS DECIMAL(23,5)) AS LOYALTY_PCT
,CAST(CASE WHEN meas.meas_cd = 'category_lidl_val' THEN dt.category_lidl_val END * CASE WHEN meas.monetary_fg = 1 THEN cer.rate_currency_exchange ELSE 1 END AS DECIMAL(23,5)) AS CATEGORY_LIDL_VAL

,CAST(CASE WHEN meas.meas_cd = 'turnover_val' THEN (CAST(py.turnover_val AS DECIMAL(38,11))/1000)::Decimal(23,5) END * CASE WHEN meas.monetary_fg = 1 THEN cer.rate_currency_exchange ELSE 1 END AS DECIMAL(23,5)) AS TURNOVER_VAL_PY
,CAST(CASE WHEN meas.meas_cd = 'pot_turnover_val'  THEN (py.pot_turnover_val/1000)::Decimal(23,5) END * CASE WHEN meas.monetary_fg = 1 THEN cer.rate_currency_exchange ELSE 1 END AS DECIMAL(23,5)) AS POT_TURNOVER_VAL_PY
,CAST(CASE WHEN meas.meas_cd = 'turnover_category_val'  THEN (py.turnover_category_val/1000)::Decimal(23,5) END * CASE WHEN meas.monetary_fg = 1 THEN cer.rate_currency_exchange ELSE 1 END AS DECIMAL(23,5)) AS TURNOVER_CATEGORY_VAL_PY
,CAST(CASE WHEN meas.meas_cd = 'trip_cnt' THEN (py.trip_cnt/1000)::Decimal(23,5) END * CASE WHEN meas.monetary_fg = 1 THEN cer.rate_currency_exchange ELSE 1 END AS DECIMAL(23,5)) AS TRIP_CNT_PY
,CAST(CASE WHEN meas.meas_cd = 'buyer_cnt' THEN (py.buyer_cnt/1000)::Decimal(23,5) END * CASE WHEN meas.monetary_fg = 1 THEN cer.rate_currency_exchange ELSE 1 END AS DECIMAL(23,5)) AS BUYER_CNT_PY
,CAST(CASE WHEN meas.meas_cd = 'pot_buyer_cnt' THEN (py.pot_buyer_cnt/1000)::Decimal(23,5) END * CASE WHEN meas.monetary_fg = 1 THEN cer.rate_currency_exchange ELSE 1 END AS DECIMAL(23,5)) AS POT_BUYER_CNT_PY
,CAST(CASE WHEN meas.meas_cd = 'household_in_country_cnt' THEN (py.household_in_country_cnt/1000)::Decimal(23,5) END * CASE WHEN meas.monetary_fg = 1 THEN cer.rate_currency_exchange ELSE 1 END AS DECIMAL(23,5)) AS HOUSEHOLD_IN_COUNTRY_CNT_PY
,CAST(CASE WHEN meas.meas_cd = 'spend_per_trip_val' THEN py.spend_per_trip_val END * CASE WHEN meas.monetary_fg = 1 THEN cer.rate_currency_exchange ELSE 1 END AS DECIMAL(23,5)) AS SPEND_PER_TRIP_VAL_PY
,CAST(CASE WHEN meas.meas_cd = 'spend_per_buyer_val' THEN py.spend_per_buyer_val END * CASE WHEN meas.monetary_fg = 1 THEN cer.rate_currency_exchange ELSE 1 END AS DECIMAL(23,5)) AS SPEND_PER_BUYER_VAL_PY
,CAST(CASE WHEN meas.meas_cd = 'buy_freq' THEN py.buy_freq END * CASE WHEN meas.monetary_fg = 1 THEN cer.rate_currency_exchange ELSE 1 END AS DECIMAL(23,5)) AS BUY_FREQ_PY
,CAST(CASE WHEN meas.meas_cd = 'buyer_quality' THEN py.buyer_quality END * CASE WHEN meas.monetary_fg = 1 THEN cer.rate_currency_exchange ELSE 1 END AS DECIMAL(23,5)) AS BUYER_QUALITY_PY
,CAST(CASE WHEN meas.meas_cd = 'lidl_buyer_turnover_val' THEN (py.lidl_buyer_turnover_val/1000)::Decimal(23,5) END * CASE WHEN meas.monetary_fg = 1 THEN cer.rate_currency_exchange ELSE 1 END AS DECIMAL(23,5)) AS LIDL_BUYER_TURNOVER_VAL_PY
,CAST(CASE WHEN meas.meas_cd = 'loyalty_pct' THEN py.loyalty_pct END * CASE WHEN meas.monetary_fg = 1 THEN cer.rate_currency_exchange ELSE 1 END AS DECIMAL(23,5)) AS LOYALTY_PCT_PY
,CAST(CASE WHEN meas.meas_cd = 'category_lidl_val' THEN py.category_lidl_val END * CASE WHEN meas.monetary_fg = 1 THEN cer.rate_currency_exchange ELSE 1 END AS DECIMAL(23,5)) AS CATEGORY_LIDL_VAL_PY

,NULL AS mat_latest_fg
,CAST(COALESCE(dsde.period_name, per.period_name) AS VARCHAR(128)) AS per_desc
,CAST(COALESCE(dsen.period_name, per.period_name) AS VARCHAR(128)) AS per_desc_EN
,CAST(COALESCE(pydsde.period_name, pyper.period_name) AS VARCHAR(128)) AS py_per_desc
,CAST(COALESCE(pydsen.period_name, pyper.period_name) AS VARCHAR(128)) AS py_per_desc_EN
,CAST(0 AS BYTEINT) AS prot_fg
,periods.active_fg AS active_fg
,periods.application_id AS application_id

FROM p_lew_core_ac.v_market_subgroup_1 AS dt
INNER JOIN p_lew_process_mstr_ac.v_lil_region_1 AS reg
ON reg.region_sid = dt.region_sid
INNER JOIN p_lew_process_mstr_ac.v_lil_region_retailer_1 AS rtl
ON rtl.retailer_sid = dt.retailer_sid
AND rtl.region_sid = dt.region_sid
INNER JOIN p_lew_core_ac.v_lil_period_1 AS per
ON per.client_id = dt.client_id
AND per.period_sid = dt.period_sid
LEFT OUTER JOIN p_lew_core_ac.v_lil_period_descr_1 AS dsde
ON dsde.period_sid = per.period_sid
AND dsde.lang_cd = 'DE'
LEFT OUTER JOIN p_lew_core_ac.v_lil_period_descr_1 AS dsen
ON dsen.period_sid = per.period_sid
AND dsen.lang_cd = 'EN'
INNER JOIN p_lew_process_mstr_ac.v_lil_period_1 AS perms
ON perms.client_id = dt.client_id
AND perms.period_sid = dt.period_sid
INNER JOIN p_lew_process_mstr_ac.v_lil_gfk_category_1 AS gfk
ON gfk.client_id = dt.client_id
AND gfk.gfk_cat_sid = dt.gfk_cat_sid
INNER JOIN p_lew_mart_cm.v_lil_currency_exch_rt_1 AS cer
ON cer.from_currency_iso_cd = dt.curr_cd
LEFT OUTER JOIN p_lew_core_ac.v_market_subgroup_1 AS py
ON py.client_id = dt.client_id
AND py.period_sid = per.period_sid_py
AND py.region_sid = dt.region_sid
AND py.retailer_sid = dt.retailer_sid
AND py.gfk_cat_sid = dt.gfk_cat_sid
AND py.promotion_brand_id = dt.promotion_brand_id
LEFT OUTER JOIN p_lew_core_ac.v_lil_period_1 AS pyper
ON pyper.client_id = py.client_id
AND pyper.period_sid = py.period_sid
LEFT OUTER JOIN p_lew_core_ac.v_lil_period_descr_1 AS pydsde
ON pydsde.period_sid = pyper.period_sid
AND pydsde.lang_cd = 'DE'
LEFT OUTER JOIN p_lew_core_ac.v_lil_period_descr_1 AS pydsen
ON pydsen.period_sid = pyper.period_sid
AND pydsen.lang_cd = 'EN'
LEFT OUTER JOIN p_lew_core_ac.v_lil_retailer_period_1 AS rtlper
    ON rtlper.client_id = dt.client_id
    AND rtlper.retailer_sid = dt.retailer_sid
    AND rtlper.period_sid = dt.period_sid
    AND rtlper.deleted_fg = 0
    AND rtlper.interface_name = 'LIFT_FMCG_Core'

CROSS JOIN (SELECT
meas_id
,meas_cd
,monetary_fg
FROM p_lew_process_mstr_ac.v_lil_measure_1
       WHERE meas_cd IN (
       'turnover_val', 'pot_turnover_val', 'category_lidl_val', 'trip_cnt', 'buyer_cnt', 'pot_buyer_cnt'
       ,'household_in_country_cnt', 'spend_per_trip_val', 'buy_freq', 'pot_turnover_exploit_pct'
       ,'spend_per_trip_val', 'spend_per_buyer_val', 'turnover_category_val', 'household_penetrate_pct', 'loyalty_pct'
       ,'closure_rate_pct', 'buyer_quality', 'lidl_market_share_pct', 'lidl_buyer_turnover_val'
       ,'new_or_lost_cat_buyer_cnt', 'incr_or_decr_cat_buy_val', 'switch_between_stores_val'
       ,'net_switch_gain_val', 'net_switch_loss_val', 'val_k_gl'
     )
   ) AS meas

LEFT OUTER JOIN periods
  ON (CAST(reg.region_id AS SMALLINT) = periods.client_id
      AND perms.period_id = periods.per_id)
      
WHERE NOT meas.meas_id IN (44)
   AND COALESCE(dt.deleted_fg, 0) = 0
   AND NOT EXISTS(SELECT
NULL
FROM p_lew_process_mstr_ac.v_lil_data_mask_1 AS dm
WHERE dm.client_id = dt.client_id
AND dm.region_sid = dt.region_sid
AND dm.period_sid = dt.period_sid
AND dm.interface_name = 'LIFT_FMCG_Core'
AND dm.mask_data_fg = 1)
AND  (dt.TURNOVER_VAL IS NOT NULL OR dt.TURNOVER_CATEGORY_VAL IS NOT NULL OR dt.POT_TURNOVER_VAL IS NOT NULL OR dt.TRIP_CNT IS NOT NULL OR dt.BUYER_CNT IS NOT NULL OR dt.POT_BUYER_CNT IS NOT NULL OR dt.HOUSEHOLD_IN_COUNTRY_CNT IS NOT NULL OR dt.SPEND_PER_TRIP_VAL IS NOT NULL OR dt.SPEND_PER_BUYER_VAL IS NOT NULL OR dt.BUY_FREQ IS NOT NULL OR dt.BUYER_QUALITY IS NOT NULL OR dt.LIDL_BUYER_TURNOVER_VAL IS NOT NULL OR py.TURNOVER_VAL IS NOT NULL OR py.POT_TURNOVER_VAL IS NOT NULL OR py.TURNOVER_CATEGORY_VAL IS NOT NULL OR py.TRIP_CNT IS NOT NULL OR py.BUYER_CNT IS NOT NULL OR py.POT_BUYER_CNT IS NOT NULL OR py.HOUSEHOLD_IN_COUNTRY_CNT IS NOT NULL OR py.SPEND_PER_TRIP_VAL IS NOT NULL OR py.SPEND_PER_BUYER_VAL IS NOT NULL OR py.BUY_FREQ IS NOT NULL OR py.BUYER_QUALITY IS NOT NULL OR py.LIDL_BUYER_TURNOVER_VAL IS NOT NULL OR dt.LOYALTY_PCT IS NOT NULL OR py.LOYALTY_PCT IS NOT NULL)


UNION ALL

SELECT
CAST(reg.region_id AS SMALLINT) AS client_id
,rtl.rtl_id
,CAST(CASE
        WHEN rtlper.retailer_sid_parent IS NOT NULL THEN 15
        ELSE rtl.rtl_lvl END AS SMALLINT) AS rtl_lvl
,ptp.ltst_pseudo_period_id AS per_id
,per.period_year
,gfk.gfk_cat_id AS lift_cat_id
,dt.promotion_brand_id AS prom_id
,CAST(TRUNC(CASE
WHEN dt.data_confidence_fg  = 1 THEN 101
WHEN (dt.data_confidence_fg  IS NULL OR dt.data_confidence_fg = 0) AND  meas.meas_id IN (49, 50, 51, 52, 53) THEN 101
ELSE 0 END) AS INTEGER) AS raw_buyer_id
,CAST(cer.to_currency_iso_cd AS CHAR(3)) AS currency_iso_cd
,meas.meas_id

,CAST(CASE WHEN meas.meas_cd = 'turnover_val' THEN (CAST(dt.turnover_val AS DECIMAL(38,11))/1000)::Decimal(23,5) END * CASE WHEN meas.monetary_fg = 1 THEN cer.rate_currency_exchange ELSE 1 END AS DECIMAL(23,5)) AS TURNOVER_VAL
,CAST(CASE WHEN meas.meas_cd = 'pot_turnover_val'  THEN (dt.pot_turnover_val/1000)::Decimal(23,5) END * CASE WHEN meas.monetary_fg = 1 THEN cer.rate_currency_exchange ELSE 1 END AS DECIMAL(23,5)) AS POT_TURNOVER_VAL
,CAST(CASE WHEN meas.meas_cd = 'turnover_category_val'  THEN (dt.turnover_category_val/1000)::Decimal(23,5) END * CASE WHEN meas.monetary_fg = 1 THEN cer.rate_currency_exchange ELSE 1 END AS DECIMAL(23,5)) AS TURNOVER_CATEGORY_VAL
,CAST(CASE WHEN meas.meas_cd = 'trip_cnt' THEN (dt.trip_cnt/1000)::Decimal(23,5) END * CASE WHEN meas.monetary_fg = 1 THEN cer.rate_currency_exchange ELSE 1 END AS DECIMAL(23,5)) AS TRIP_CNT
,CAST(CASE WHEN meas.meas_cd = 'buyer_cnt' THEN (dt.buyer_cnt/1000)::Decimal(23,5) END * CASE WHEN meas.monetary_fg = 1 THEN cer.rate_currency_exchange ELSE 1 END AS DECIMAL(23,5)) AS BUYER_CNT
,CAST(CASE WHEN meas.meas_cd = 'pot_buyer_cnt' THEN (dt.pot_buyer_cnt/1000)::Decimal(23,5) END * CASE WHEN meas.monetary_fg = 1 THEN cer.rate_currency_exchange ELSE 1 END AS DECIMAL(23,5)) AS POT_BUYER_CNT
,CAST(CASE WHEN meas.meas_cd = 'household_in_country_cnt' THEN (dt.household_in_country_cnt/1000)::Decimal(23,5) END * CASE WHEN meas.monetary_fg = 1 THEN cer.rate_currency_exchange ELSE 1 END AS DECIMAL(23,5)) AS HOUSEHOLD_IN_COUNTRY_CNT
,CAST(CASE WHEN meas.meas_cd = 'spend_per_trip_val' THEN dt.spend_per_trip_val END * CASE WHEN meas.monetary_fg = 1 THEN cer.rate_currency_exchange ELSE 1 END AS DECIMAL(23,5)) AS SPEND_PER_TRIP_VAL
,CAST(CASE WHEN meas.meas_cd = 'spend_per_buyer_val' THEN dt.spend_per_buyer_val END * CASE WHEN meas.monetary_fg = 1 THEN cer.rate_currency_exchange ELSE 1 END AS DECIMAL(23,5)) AS SPEND_PER_BUYER_VAL
,CAST(CASE WHEN meas.meas_cd = 'buy_freq' THEN dt.buy_freq END * CASE WHEN meas.monetary_fg = 1 THEN cer.rate_currency_exchange ELSE 1 END AS DECIMAL(23,5)) AS BUY_FREQ
,CAST(CASE WHEN meas.meas_cd = 'buyer_quality' THEN dt.buyer_quality END * CASE WHEN meas.monetary_fg = 1 THEN cer.rate_currency_exchange ELSE 1 END AS DECIMAL(23,5)) AS BUYER_QUALITY
,CAST(CASE WHEN meas.meas_cd = 'lidl_buyer_turnover_val' THEN (dt.lidl_buyer_turnover_val/1000)::Decimal(23,5) END * CASE WHEN meas.monetary_fg = 1 THEN cer.rate_currency_exchange ELSE 1 END AS DECIMAL(23,5)) AS LIDL_BUYER_TURNOVER_VAL
,CAST(CASE WHEN meas.meas_cd = 'loyalty_pct' THEN dt.loyalty_pct END * CASE WHEN meas.monetary_fg = 1 THEN cer.rate_currency_exchange ELSE 1 END AS DECIMAL(23,5)) AS LOYALTY_PCT
,CAST(CASE WHEN meas.meas_cd = 'category_lidl_val' THEN dt.category_lidl_val END * CASE WHEN meas.monetary_fg = 1 THEN cer.rate_currency_exchange ELSE 1 END AS DECIMAL(23,5)) AS CATEGORY_LIDL_VAL

,CAST(CASE WHEN meas.meas_cd = 'turnover_val' THEN (CAST(py.turnover_val AS DECIMAL(38,11))/1000)::Decimal(23,5) END * CASE WHEN meas.monetary_fg = 1 THEN cer.rate_currency_exchange ELSE 1 END AS DECIMAL(23,5)) AS TURNOVER_VAL_PY
,CAST(CASE WHEN meas.meas_cd = 'pot_turnover_val'  THEN (py.pot_turnover_val/1000)::Decimal(23,5) END * CASE WHEN meas.monetary_fg = 1 THEN cer.rate_currency_exchange ELSE 1 END AS DECIMAL(23,5)) AS POT_TURNOVER_VAL_PY
,CAST(CASE WHEN meas.meas_cd = 'turnover_category_val'  THEN (py.turnover_category_val/1000)::Decimal(23,5) END * CASE WHEN meas.monetary_fg = 1 THEN cer.rate_currency_exchange ELSE 1 END AS DECIMAL(23,5)) AS TURNOVER_CATEGORY_VAL_PY
,CAST(CASE WHEN meas.meas_cd = 'trip_cnt' THEN (py.trip_cnt/1000)::Decimal(23,5) END * CASE WHEN meas.monetary_fg = 1 THEN cer.rate_currency_exchange ELSE 1 END AS DECIMAL(23,5)) AS TRIP_CNT_PY
,CAST(CASE WHEN meas.meas_cd = 'buyer_cnt' THEN (py.buyer_cnt/1000)::Decimal(23,5) END * CASE WHEN meas.monetary_fg = 1 THEN cer.rate_currency_exchange ELSE 1 END AS DECIMAL(23,5)) AS BUYER_CNT_PY
,CAST(CASE WHEN meas.meas_cd = 'pot_buyer_cnt' THEN (py.pot_buyer_cnt/1000)::Decimal(23,5) END * CASE WHEN meas.monetary_fg = 1 THEN cer.rate_currency_exchange ELSE 1 END AS DECIMAL(23,5)) AS POT_BUYER_CNT_PY
,CAST(CASE WHEN meas.meas_cd = 'household_in_country_cnt' THEN (py.household_in_country_cnt/1000)::Decimal(23,5) END * CASE WHEN meas.monetary_fg = 1 THEN cer.rate_currency_exchange ELSE 1 END AS DECIMAL(23,5)) AS HOUSEHOLD_IN_COUNTRY_CNT_PY
,CAST(CASE WHEN meas.meas_cd = 'spend_per_trip_val' THEN py.spend_per_trip_val END * CASE WHEN meas.monetary_fg = 1 THEN cer.rate_currency_exchange ELSE 1 END AS DECIMAL(23,5)) AS SPEND_PER_TRIP_VAL_PY
,CAST(CASE WHEN meas.meas_cd = 'spend_per_buyer_val' THEN py.spend_per_buyer_val END * CASE WHEN meas.monetary_fg = 1 THEN cer.rate_currency_exchange ELSE 1 END AS DECIMAL(23,5)) AS SPEND_PER_BUYER_VAL_PY
,CAST(CASE WHEN meas.meas_cd = 'buy_freq' THEN py.buy_freq END * CASE WHEN meas.monetary_fg = 1 THEN cer.rate_currency_exchange ELSE 1 END AS DECIMAL(23,5)) AS BUY_FREQ_PY
,CAST(CASE WHEN meas.meas_cd = 'buyer_quality' THEN py.buyer_quality END * CASE WHEN meas.monetary_fg = 1 THEN cer.rate_currency_exchange ELSE 1 END AS DECIMAL(23,5)) AS BUYER_QUALITY_PY
,CAST(CASE WHEN meas.meas_cd = 'lidl_buyer_turnover_val' THEN (py.lidl_buyer_turnover_val/1000)::Decimal(23,5) END * CASE WHEN meas.monetary_fg = 1 THEN cer.rate_currency_exchange ELSE 1 END AS DECIMAL(23,5)) AS LIDL_BUYER_TURNOVER_VAL_PY
,CAST(CASE WHEN meas.meas_cd = 'loyalty_pct' THEN py.loyalty_pct END * CASE WHEN meas.monetary_fg = 1 THEN cer.rate_currency_exchange ELSE 1 END AS DECIMAL(23,5)) AS LOYALTY_PCT_PY
,CAST(CASE WHEN meas.meas_cd = 'category_lidl_val' THEN py.category_lidl_val END * CASE WHEN meas.monetary_fg = 1 THEN cer.rate_currency_exchange ELSE 1 END AS DECIMAL(23,5)) AS CATEGORY_LIDL_VAL_PY

,NULL AS mat_latest_fg
,CAST(COALESCE(dsde.period_name, per.period_name) AS VARCHAR(128)) AS per_desc
,CAST(COALESCE(dsen.period_name, per.period_name) AS VARCHAR(128)) AS per_desc_EN
,CAST(COALESCE(pydsde.period_name, pyper.period_name) AS VARCHAR(128)) AS py_per_desc
,CAST(COALESCE(pydsen.period_name, pyper.period_name) AS VARCHAR(128)) AS py_per_desc_EN
,CAST(0 AS BYTEINT) AS prot_fg
,periods.active_fg AS active_fg
,periods.application_id AS application_id
FROM p_lew_core_ac.v_market_subgroup_1 AS dt
INNER JOIN p_lew_process_mstr_ac.v_lil_region_1 AS reg
ON reg.region_sid = dt.region_sid
INNER JOIN p_lew_process_mstr_ac.v_lil_region_retailer_1 AS rtl
ON rtl.client_id = dt.client_id
AND rtl.retailer_sid = dt.retailer_sid
AND rtl.region_sid = dt.region_sid
CROSS JOIN (SELECT
meas_id
,meas_cd
,monetary_fg
FROM p_lew_process_mstr_ac.v_lil_measure_1
       WHERE meas_cd IN (
       'turnover_val', 'pot_turnover_val', 'category_lidl_val', 'trip_cnt', 'buyer_cnt', 'pot_buyer_cnt'
       ,'household_in_country_cnt', 'spend_per_trip_val', 'buy_freq', 'pot_turnover_exploit_pct'
       ,'spend_per_trip_val', 'spend_per_buyer_val', 'turnover_category_val', 'household_penetrate_pct', 'loyalty_pct'
       ,'closure_rate_pct', 'buyer_quality', 'lidl_market_share_pct', 'lidl_buyer_turnover_val'
       ,'new_or_lost_cat_buyer_cnt', 'incr_or_decr_cat_buy_val', 'switch_between_stores_val'
       ,'net_switch_gain_val', 'net_switch_loss_val', 'val_k_gl'
     )
   ) AS meas
INNER JOIN p_lew_process_mstr_ac.v_lil_measure_class_1 AS mc
ON mc.meas_id = meas.meas_id
AND mc.class_cd IN ('LIFT1', 'LIFTGL')
INNER JOIN p_lew_core_ac.v_lil_period_1 AS per
ON per.client_id = dt.client_id
AND per.period_sid = dt.period_sid
LEFT OUTER JOIN p_lew_core_ac.v_lil_period_descr_1 AS dsde
ON dsde.period_sid = per.period_sid
AND dsde.lang_cd = 'DE'
LEFT OUTER JOIN p_lew_core_ac.v_lil_period_descr_1 AS dsen
ON dsen.period_sid = per.period_sid
AND dsen.lang_cd = 'EN'
INNER JOIN p_lew_process_mstr_ac.v_lil_period_1 AS perms
ON perms.client_id = dt.client_id
AND perms.period_sid = dt.period_sid
INNER JOIN p_lew_process_mstr_ac.v_lil_region_per_latest_1 AS rpl
ON rpl.client_id = dt.client_id
AND rpl.region_sid = dt.region_sid
AND rpl.class_cd = mc.class_cd
AND rpl.ltst_per_id = perms.period_id
INNER JOIN p_lew_process_mstr_ac.v_lil_period_type_1 AS ptp
ON ptp.period_type_id = rpl.per_tp_id
AND ptp.ltst_pseudo_period_id IS NOT NULL
INNER JOIN p_lew_process_mstr_ac.v_lil_gfk_category_1 AS gfk
ON gfk.client_id = dt.client_id
AND gfk.gfk_cat_sid = dt.gfk_cat_sid
INNER JOIN p_lew_mart_cm.v_lil_currency_exch_rt_1 AS cer
ON cer.from_currency_iso_cd = dt.curr_cd
LEFT OUTER JOIN p_lew_core_ac.v_market_subgroup_1 AS py
ON py.client_id = dt.client_id
AND py.period_sid = per.period_sid_py
AND py.region_sid = dt.region_sid
AND py.retailer_sid = dt.retailer_sid
AND py.gfk_cat_sid = dt.gfk_cat_sid
AND py.promotion_brand_id = dt.promotion_brand_id
LEFT OUTER JOIN p_lew_core_ac.v_lil_period_1 AS pyper
ON pyper.client_id = py.client_id
AND pyper.period_sid = py.period_sid
LEFT OUTER JOIN p_lew_core_ac.v_lil_period_descr_1 AS pydsde
ON pydsde.period_sid = pyper.period_sid
AND pydsde.lang_cd = 'DE'
LEFT OUTER JOIN p_lew_core_ac.v_lil_period_descr_1 AS pydsen
ON pydsen.period_sid = pyper.period_sid
AND pydsen.lang_cd = 'EN'
LEFT OUTER JOIN p_lew_core_ac.v_lil_retailer_period_1 AS rtlper
    ON rtlper.client_id = dt.client_id
    AND rtlper.retailer_sid = dt.retailer_sid
    AND rtlper.period_sid = dt.period_sid
    AND rtlper.deleted_fg = 0
    AND rtlper.interface_name = 'LIFT_FMCG_Core'
    
LEFT OUTER JOIN periods
  ON (CAST(reg.region_id AS SMALLINT) = periods.client_id
      AND ptp.ltst_pseudo_period_id = periods.per_id)

WHERE NOT meas.meas_id IN (44)
AND COALESCE(dt.deleted_fg, 0) = 0
AND NOT EXISTS(SELECT
NULL
FROM p_lew_process_mstr_ac.v_lil_data_mask_1 AS dm
WHERE dm.client_id = dt.client_id
AND dm.region_sid = dt.region_sid
AND dm.period_sid = dt.period_sid
AND dm.interface_name = 'LIFT_FMCG_Core'
AND dm.mask_data_fg = 1)
AND  (dt.TURNOVER_VAL IS NOT NULL OR dt.TURNOVER_CATEGORY_VAL IS NOT NULL OR dt.POT_TURNOVER_VAL IS NOT NULL OR dt.TRIP_CNT IS NOT NULL OR dt.BUYER_CNT IS NOT NULL OR dt.POT_BUYER_CNT IS NOT NULL OR dt.HOUSEHOLD_IN_COUNTRY_CNT IS NOT NULL OR dt.SPEND_PER_TRIP_VAL IS NOT NULL OR dt.SPEND_PER_BUYER_VAL IS NOT NULL OR dt.BUY_FREQ IS NOT NULL OR dt.BUYER_QUALITY IS NOT NULL OR dt.LIDL_BUYER_TURNOVER_VAL IS NOT NULL OR py.TURNOVER_VAL IS NOT NULL OR py.POT_TURNOVER_VAL IS NOT NULL OR py.TURNOVER_CATEGORY_VAL IS NOT NULL OR py.TRIP_CNT IS NOT NULL OR py.BUYER_CNT IS NOT NULL OR py.POT_BUYER_CNT IS NOT NULL OR py.HOUSEHOLD_IN_COUNTRY_CNT IS NOT NULL OR py.SPEND_PER_TRIP_VAL IS NOT NULL OR py.SPEND_PER_BUYER_VAL IS NOT NULL OR py.BUY_FREQ IS NOT NULL OR py.BUYER_QUALITY IS NOT NULL OR py.LIDL_BUYER_TURNOVER_VAL IS NOT NULL OR dt.LOYALTY_PCT IS NOT NULL OR py.LOYALTY_PCT IS NOT NULL)
)

SELECT 
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
FROM base

UNION ALL

SELECT -- duplication for INT
    7 AS CLIENT_ID,
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
FROM base

WHERE
    base.CLIENT_ID NOT IN (3301,3303,3302)
    
UNION ALL

SELECT -- Competitor Ranks
    act.CLIENT_ID
    , CASE 
        WHEN COMPETITOR_RANK_ID = 1 THEN 1010 
        WHEN COMPETITOR_RANK_ID = 2 THEN 1020 
        WHEN COMPETITOR_RANK_ID = 3 THEN 1030
        ELSE 0 END
        AS RTL_ID,
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
    act.ACTIVE_FG,
    APPLICATION_ID
FROM base AS act
INNER JOIN p_lew_mart_cm.t_lil_country_based_competitors_1 AS cc
    ON act.client_id = cc.client_id AND act.rtl_id = cc.retailer_id
    UNION ALL

SELECT -- Competitor Ranks for INT
    7 AS CLIENT_ID
    , CASE 
        WHEN COMPETITOR_RANK_ID = 1 THEN 1010 
        WHEN COMPETITOR_RANK_ID = 2 THEN 1020 
        WHEN COMPETITOR_RANK_ID = 3 THEN 1030
        ELSE 0 
    END AS RTL_ID
    , RTL_LVL
    , PER_ID
    , PERIOD_YEAR
    , LIFT_CAT_ID
    , PROM_ID
    , RAW_BUYER_ID
    , CURRENCY_ISO_CD
    , MEAS_ID
    , TURNOVER_VAL
    , TURNOVER_CATEGORY_VAL
    , POT_TURNOVER_VAL
    , TRIP_CNT
    , BUYER_CNT
    , POT_BUYER_CNT
    , HOUSEHOLD_IN_COUNTRY_CNT
    , SPEND_PER_TRIP_VAL
    , SPEND_PER_BUYER_VAL
    , BUY_FREQ
    , BUYER_QUALITY
    , LIDL_BUYER_TURNOVER_VAL
    , TURNOVER_VAL_PY
    , POT_TURNOVER_VAL_PY
    , TURNOVER_CATEGORY_VAL_PY
    , TRIP_CNT_PY
    , BUYER_CNT_PY
    , POT_BUYER_CNT_PY
    , HOUSEHOLD_IN_COUNTRY_CNT_PY
    , SPEND_PER_TRIP_VAL_PY
    , SPEND_PER_BUYER_VAL_PY
    , BUY_FREQ_PY
    , BUYER_QUALITY_PY
    , LIDL_BUYER_TURNOVER_VAL_PY
    , LOYALTY_PCT
    , LOYALTY_PCT_PY
    , CATEGORY_LIDL_VAL
    , CATEGORY_LIDL_VAL_PY
    , MAT_LATEST_FG
    , PER_DESC
    , PER_DESC_EN
    , PY_PER_DESC
    , PY_PER_DESC_EN
    , PROT_FG
    , act.ACTIVE_FG
    , APPLICATION_ID
FROM base AS act
INNER JOIN p_lew_mart_cm.t_lil_country_based_competitors_1 AS cc
    ON act.client_id = cc.client_id AND act.rtl_id = cc.retailer_id
WHERE
    act.CLIENT_ID NOT IN (3301, 3303, 3302)
;
