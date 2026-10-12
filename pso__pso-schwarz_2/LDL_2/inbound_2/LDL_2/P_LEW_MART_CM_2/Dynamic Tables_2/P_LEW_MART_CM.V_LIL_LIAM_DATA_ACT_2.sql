
CREATE OR REPLACE DYNAMIC TABLE P_LEW_MART_CM.V_LIL_LIAM_DATA_ACT_2
(
client_id
, clnt_rtl_id
, rtl_id
, rtl_lvl
, per_id
, liam_parnt_clnt_cat_id
, liam_clnt_cat_id
, prom_id
, raw_buyer_id
, currency_iso_cd
, meas_id
, meas_tp_id
, val
, py_val
, pq_val
, data_avbl_fg
, prot_fg
)
TARGET_LAG = '1 hour, 30 minutes' 
REFRESH_MODE = FULL 
INITIALIZE = ON_CREATE 
WAREHOUSE = WH_LDL_%%environmentAbbreviation%%_DYNAMIC_TABLE_P_LEW_MART_CM
AS
SELECT
   CAST(reg.region_id AS SMALLINT) AS client_id
  ,NULL AS clnt_rtl_id
  ,rtl.rtl_id
  ,CAST(CASE
        WHEN rtlper.retailer_sid_parent IS NOT NULL THEN 15
        ELSE rtl.rtl_lvl END AS SMALLINT) AS rtl_lvl
  ,perms.period_id AS per_id
  ,CAST(SUBSTR(ass.assort_region_cat_id,1,13)||'00005000000000' AS CHAR(27)) AS liam_parnt_clnt_cat_id
  ,CAST(ass.assort_region_cat_id AS CHAR(27)) AS liam_clnt_cat_id
  ,dt.promotion_brand_id AS prom_id
  ,CAST(CASE dt.data_confidence_fg WHEN 1 THEN 101 ELSE 0 END AS INTEGER) AS raw_buyer_id
  ,CAST(cer.to_currency_iso_cd AS CHAR(3)) AS currency_iso_cd
  ,meas.meas_id
  ,CAST(meas.meas_tp_id AS SMALLINT)  AS meas_tp_id
  ,CAST(CASE meas.meas_cd
       WHEN 'turnover_val'             THEN (Cast(dt.turnover_val AS DECIMAL(38,9))/1000)::DECIMAL(23,5)
       WHEN 'pot_turnover_val'        THEN (dt.pot_turnover_val/1000)::DECIMAL(23,5)
       WHEN 'trip_cnt'       THEN (dt.trip_cnt/1000)::DECIMAL(23,5)
       WHEN 'buyer_cnt' THEN (dt.buyer_cnt/1000)::DECIMAL(23,5)
       WHEN 'pot_buyer_cnt'      THEN (dt.pot_buyer_cnt/1000)::DECIMAL(23,5)
       WHEN 'category_lidl_val'     THEN (dt.category_lidl_val/1000)::DECIMAL(23,5)
       WHEN 'category_volume_pack_lidl_val'    THEN (dt.category_volume_pack_lidl_val/1000)::DECIMAL(23,5)
       WHEN 'category_trips_lidl_cnt'  THEN (dt.category_trips_lidl_cnt/1000)::DECIMAL(23,5)
       WHEN 'household_in_country_cnt' THEN (dt.household_in_country_cnt/1000)::DECIMAL(23,5)
       WHEN 'extrapol_qty'       THEN dt.extrapol_qty
       WHEN 'extrapol_package_cnt'      THEN (dt.extrapol_package_cnt/1000)::DECIMAL(23,5)
       WHEN 'spend_per_trip_val'   THEN dt.spend_per_trip_val
       WHEN 'buy_freq' THEN dt.buy_freq
       WHEN 'avg_price_per_pack_val' THEN dt.avg_price_per_pack_val
       WHEN 'packs_per_trip_cnt' THEN dt.packs_per_trip_cnt
       WHEN 'pot_turnover_exploit_pct' THEN dt.pot_turnover_exploit_pct
       WHEN 'loyalty_pct' THEN dt.loyalty_pct
       WHEN 'closure_rate_pct' THEN dt.closure_rate_pct
       WHEN 'buyer_quality' THEN dt.buyer_quality
       WHEN 'household_penetrate_pct' THEN dt.household_penetrate_pct
       WHEN 'pot_turnover_pct' THEN dt.pot_turnover_pct
       WHEN 'lidl_market_share_pct' THEN dt.lidl_market_share_pct
       WHEN 'category_share_pct' THEN dt.category_share_pct
       WHEN 'category_volume_pack_share_pct' THEN dt.category_volume_pack_share_pct
       WHEN 'turnover_share_pct' THEN dt.turnover_share_pct
       WHEN 'lidl_buyer_turnover_val' THEN (dt.lidl_buyer_turnover_val/1000)::DECIMAL(23,5)
       WHEN 'lidl_buyer_turnover_pot_val' THEN (dt.lidl_buyer_turnover_pot_val/1000)::DECIMAL(23,5)
       WHEN 'lidl_buyer_trip_cnt' THEN (dt.lidl_buyer_trip_cnt/1000)::DECIMAL(23,5)
       WHEN 'lidl_buyer_trip_pot_cnt' THEN (dt.lidl_buyer_trip_pot_cnt/1000)::DECIMAL(23,5)
       WHEN 'lidl_buyer_cnt' THEN (dt.lidl_buyer_cnt/1000)::DECIMAL(23,5)
       WHEN 'lidl_buyer_pot_cnt' THEN (dt.lidl_buyer_pot_cnt/1000)::DECIMAL(23,5)
     END *
     CASE
       WHEN meas.monetary_fg = 1 THEN cer.rate_currency_exchange
                              ELSE 1
       END AS DECIMAL(23,5)) AS val
,CAST(CASE meas.meas_cd
       WHEN 'turnover_val'             THEN (Cast(py.turnover_val AS DECIMAL(38,9))/1000)::DECIMAL(23,5)
       WHEN 'pot_turnover_val'        THEN (py.pot_turnover_val/1000)::DECIMAL(23,5)
       WHEN 'trip_cnt'       THEN (py.trip_cnt/1000)::DECIMAL(23,5)
       WHEN 'buyer_cnt' THEN (py.buyer_cnt/1000)::DECIMAL(23,5)
       WHEN 'pot_buyer_cnt'      THEN (py.pot_buyer_cnt/1000)::DECIMAL(23,5)
       WHEN 'category_lidl_val'     THEN (py.category_lidl_val/1000)::DECIMAL(23,5)
       WHEN 'category_volume_pack_lidl_val'    THEN (py.category_volume_pack_lidl_val/1000)::DECIMAL(23,5)
       WHEN 'category_trips_lidl_cnt'  THEN (py.category_trips_lidl_cnt/1000)::DECIMAL(23,5)
       WHEN 'household_in_country_cnt' THEN (py.household_in_country_cnt/1000)::DECIMAL(23,5)
       WHEN 'extrapol_qty'       THEN py.extrapol_qty
       WHEN 'extrapol_package_cnt'      THEN (py.extrapol_package_cnt/1000)::DECIMAL(23,5)
       WHEN 'spend_per_trip_val'   THEN py.spend_per_trip_val
       WHEN 'buy_freq' THEN py.buy_freq
       WHEN 'avg_price_per_pack_val' THEN py.avg_price_per_pack_val
       WHEN 'packs_per_trip_cnt' THEN py.packs_per_trip_cnt
       WHEN 'pot_turnover_exploit_pct' THEN py.pot_turnover_exploit_pct
       WHEN 'loyalty_pct' THEN py.loyalty_pct
       WHEN 'closure_rate_pct' THEN py.closure_rate_pct
       WHEN 'buyer_quality' THEN py.buyer_quality
       WHEN 'household_penetrate_pct' THEN py.household_penetrate_pct
       WHEN 'pot_turnover_pct' THEN py.pot_turnover_pct
       WHEN 'lidl_market_share_pct' THEN py.lidl_market_share_pct
       WHEN 'category_share_pct' THEN py.category_share_pct
       WHEN 'category_volume_pack_share_pct' THEN py.category_volume_pack_share_pct
       WHEN 'turnover_share_pct' THEN py.turnover_share_pct
       WHEN 'lidl_buyer_turnover_val' THEN (py.lidl_buyer_turnover_val/1000)::DECIMAL(23,5)
       WHEN 'lidl_buyer_turnover_pot_val' THEN (py.lidl_buyer_turnover_pot_val/1000)::DECIMAL(23,5)
       WHEN 'lidl_buyer_trip_cnt' THEN (py.lidl_buyer_trip_cnt/1000)::DECIMAL(23,5)
       WHEN 'lidl_buyer_trip_pot_cnt' THEN (py.lidl_buyer_trip_pot_cnt/1000)::DECIMAL(23,5)
       WHEN 'lidl_buyer_cnt' THEN (py.lidl_buyer_cnt/1000)::DECIMAL(23,5)
       WHEN 'lidl_buyer_pot_cnt' THEN (py.lidl_buyer_pot_cnt/1000)::DECIMAL(23,5)
     END *
     CASE
       WHEN meas.monetary_fg = 1 THEN cer.rate_currency_exchange
                              ELSE 1
    END AS DECIMAL(23,5)) AS py_val
  ,NULL AS pq_val
  ,CAST(CASE WHEN val IS NULL THEN 0 ELSE 1 END AS BYTEINT) AS data_avbl_fg
  ,CAST(1 AS BYTEINT) AS prot_fg
FROM P_LEW_CORE_AC.v_market_familygroup_2 AS dt
INNER JOIN P_LEW_PROCESS_MSTR_AC.v_lil_region_2 AS reg
ON reg.region_sid = dt.region_sid
INNER JOIN P_LEW_PROCESS_MSTR_AC.v_lil_region_retailer_2 AS rtl
ON rtl.client_id = dt.client_id
AND rtl.retailer_sid = dt.retailer_sid
AND rtl.region_sid = dt.region_sid
INNER JOIN P_LEW_CORE_AC.v_lil_period_2 AS per
ON per.client_id = dt.client_id
AND per.period_sid = dt.period_sid
INNER JOIN P_LEW_PROCESS_MSTR_AC.v_lil_period_2 AS perms
ON perms.client_id = dt.client_id
AND perms.period_sid = dt.period_sid
INNER JOIN P_LEW_PROCESS_MSTR_AC.v_lil_assort_region_cat_2 AS ass
ON ass.client_id = dt.client_id
AND ass.region_sid = dt.region_sid
AND ass.assort_cat_sid = dt.assort_cat_sid
INNER JOIN P_LEW_CORE_AC.v_lil_assort_category_2 AS assc
ON assc.client_id = ass.client_id
AND assc.assort_cat_sid = ass.assort_cat_sid
INNER JOIN P_LEW_MART_CM.v_lil_currency_exch_rt_2 AS cer
ON cer.from_currency_iso_cd = dt.curr_cd
LEFT OUTER JOIN P_LEW_CORE_AC.v_market_familygroup_2 AS py
ON py.client_id = dt.client_id
AND py.period_sid = per.period_sid_py
AND py.region_sid = dt.region_sid
AND py.retailer_sid = dt.retailer_sid
AND py.assort_cat_sid = dt.assort_cat_sid
AND py.promotion_brand_id = dt.promotion_brand_id
LEFT OUTER JOIN P_LEW_CORE_AC.v_lil_period_2 AS pyper
ON pyper.client_id = py.client_id
AND pyper.period_sid = py.period_sid
LEFT OUTER JOIN P_LEW_CORE_AC.v_lil_retailer_period_2 AS rtlper
    ON rtlper.client_id = dt.client_id
    AND rtlper.retailer_sid = dt.retailer_sid
    AND rtlper.period_sid = dt.period_sid
    AND rtlper.deleted_fg = 0
    AND rtlper.interface_name = 'LIAM_FMCG_Core'
CROSS JOIN (
    SELECT
        meas_id
      , meas_cd
      , monetary_fg
      , meas_tp_id
    FROM P_LEW_PROCESS_MSTR_AC.v_lil_measure_2
    WHERE meas_cd IN (
          'turnover_val', 'pot_turnover_val', 'trip_cnt', 'buyer_cnt', 'pot_buyer_cnt', 'category_lidl_val', 'category_volume_pack_lidl_val'
         ,'category_trips_lidl_cnt', 'household_in_country_cnt', 'extrapol_qty', 'extrapol_package_cnt', 'spend_per_trip_val', 'buy_freq'
         ,'avg_price_per_pack_val', 'packs_per_trip_cnt', 'pot_turnover_exploit_pct', 'loyalty_pct', 'closure_rate_pct', 'buyer_quality'
         ,'household_penetrate_pct', 'pot_turnover_pct', 'lidl_market_share_pct', 'category_share_pct', 'category_volume_pack_share_pct'
         ,'turnover_share_pct', 'lidl_buyer_turnover_val', 'lidl_buyer_turnover_pot_val', 'lidl_buyer_trip_cnt', 'lidl_buyer_trip_pot_cnt'
         ,'lidl_buyer_cnt', 'lidl_buyer_pot_cnt'
      )
    ) AS meas
    WHERE NOT meas.meas_id IN (44,46)
    AND COALESCE(dt.deleted_fg, 0) = 0
    AND NOT EXISTS(
    SELECT NULL
    FROM P_LEW_PROCESS_MSTR_AC.v_lil_data_mask_2 AS dm
    WHERE dm.client_id = dt.client_id
    AND dm.region_sid = dt.region_sid
    AND dm.period_sid = dt.period_sid
    AND dm.src_assort_parent_cat_cd = LTRIM(assc.src_assort_parent_cat_cd)
    AND dm.interface_name = 'LIAM_FMCG_Core'
    AND dm.mask_data_fg = 1);
