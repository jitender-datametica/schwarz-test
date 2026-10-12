
CREATE OR REPLACE DYNAMIC TABLE P_LEW_MART_CM.V_LIL_REGION_SPLIT_DATA_ACT
(
  client_id
, rtl_id
, rtl_lvl
, per_id
, lift_cat_id
, prom_id
, region_split_id
, raw_buyer_id
, currency_iso_cd
, meas_id
, val
, py_val
, per_desc
, per_desc_EN
, py_per_desc
, py_per_desc_EN
, prot_fg
)
TARGET_LAG = '1 hour, 30 minutes' 
REFRESH_MODE = FULL 
INITIALIZE = ON_CREATE 
WAREHOUSE = WH_LDL_%%environmentAbbreviation%%_DYNAMIC_TABLE_P_LEW_MART_CM
AS
SELECT
   CAST(reg.region_id AS SMALLINT) AS client_id
  ,rtl.rtl_id
  ,CAST(CASE
        WHEN rtlper.retailer_sid_parent IS NOT NULL THEN 15
        ELSE rtl.rtl_lvl END AS SMALLINT) AS rtl_lvl
  ,perms.period_id AS per_id
  ,gfk.gfk_cat_id AS lift_cat_id
  ,dt.promotion_brand_id AS prom_id
  ,split.region_id AS region_split_id
 ,CAST(CASE
        WHEN dt.data_confidence_fg  = 1 THEN 101
        WHEN (dt.data_confidence_fg  IS NULL OR dt.data_confidence_fg = 0) AND  meas.meas_id IN (49, 50, 51, 52, 53) THEN 101
        ELSE 0 END AS INTEGER) AS raw_buyer_id
  ,CAST(cer.to_currency_iso_cd AS CHAR(3)) AS currency_iso_cd
  ,meas.meas_id
  ,CAST(CASE
       WHEN meas.meas_cd = 'turnover_val'               THEN (CAST(dt.turnover_val AS DECIMAL(38,11))/1000)::DECIMAL(23,5)
      WHEN meas.meas_cd = 'pot_turnover_val'           THEN (dt.pot_turnover_val/1000)::DECIMAL(23,5)
      WHEN meas.meas_cd = 'category_lidl_val'          THEN (dt.category_lidl_val/1000)::DECIMAL(23,5)
      WHEN meas.meas_cd = 'trip_cnt'                   THEN (dt.trip_cnt/1000)::DECIMAL(23,5)
      WHEN meas.meas_cd = 'buyer_cnt'                  THEN (dt.buyer_cnt/1000)::DECIMAL(23,5)
      WHEN meas.meas_cd = 'pot_buyer_cnt'              THEN (dt.pot_buyer_cnt/1000)::DECIMAL(23,5)
      WHEN meas.meas_cd = 'household_in_country_cnt'   THEN (dt.household_in_country_cnt/1000)::DECIMAL(23,5)
       WHEN meas.meas_cd = 'spend_per_trip_val'         THEN dt.spend_per_trip_val
       WHEN meas.meas_cd = 'buy_freq'                   THEN dt.buy_freq
       WHEN meas.meas_cd = 'pot_turnover_exploit_pct'   THEN dt.pot_turnover_exploit_pct
       WHEN meas.meas_cd = 'spend_per_buyer_val'        THEN dt.spend_per_buyer_val
       WHEN meas.meas_cd = 'household_penetrate_pct'    THEN dt.household_penetrate_pct
       WHEN meas.meas_cd = 'loyalty_pct'                THEN dt.loyalty_pct
       WHEN meas.meas_cd = 'closure_rate_pct'           THEN dt.closure_rate_pct
       WHEN meas.meas_cd = 'buyer_quality'              THEN dt.buyer_quality
       WHEN meas.meas_cd = 'lidl_market_share_pct'      THEN dt.lidl_market_share_pct
   END *
    CASE
       WHEN meas.monetary_fg = 1 THEN cer.rate_currency_exchange
                                 ELSE 1
     END AS DECIMAL(23,5)) AS val
,CAST(CASE
       WHEN meas.meas_cd = 'turnover_val'               THEN (CAST(py.turnover_val AS DECIMAL(38,11))/1000)::DECIMAL(23,5)
      WHEN meas.meas_cd = 'pot_turnover_val'           THEN (py.pot_turnover_val/1000)::DECIMAL(23,5)
      WHEN meas.meas_cd = 'category_lidl_val'          THEN (py.category_lidl_val/1000)::DECIMAL(23,5)
      WHEN meas.meas_cd = 'trip_cnt'                   THEN (py.trip_cnt/1000)::DECIMAL(23,5)
      WHEN meas.meas_cd = 'buyer_cnt'                  THEN (py.buyer_cnt/1000)::DECIMAL(23,5)
      WHEN meas.meas_cd = 'pot_buyer_cnt'              THEN (py.pot_buyer_cnt/1000)::DECIMAL(23,5)
      WHEN meas.meas_cd = 'household_in_country_cnt'   THEN (py.household_in_country_cnt/1000)::DECIMAL(23,5)
       WHEN meas.meas_cd = 'spend_per_trip_val'         THEN py.spend_per_trip_val
       WHEN meas.meas_cd = 'buy_freq'                   THEN py.buy_freq
       WHEN meas.meas_cd = 'pot_turnover_exploit_pct'   THEN py.pot_turnover_exploit_pct
       WHEN meas.meas_cd = 'spend_per_buyer_val'        THEN py.spend_per_buyer_val
       WHEN meas.meas_cd = 'household_penetrate_pct'    THEN py.household_penetrate_pct
       WHEN meas.meas_cd = 'loyalty_pct'                THEN py.loyalty_pct
       WHEN meas.meas_cd = 'closure_rate_pct'           THEN py.closure_rate_pct
       WHEN meas.meas_cd = 'buyer_quality'              THEN py.buyer_quality
       WHEN meas.meas_cd = 'lidl_market_share_pct'      THEN py.lidl_market_share_pct
   END *
    CASE
       WHEN meas.monetary_fg = 1 THEN cer.rate_currency_exchange
                                 ELSE 1
    END AS DECIMAL(23,5)) AS py_val
  ,CAST(COALESCE(dsde.period_name, per.period_name) AS VARCHAR(128)) AS per_desc
  ,CAST(COALESCE(dsen.period_name, per.period_name) AS VARCHAR(128)) AS per_desc_EN
  ,CAST(COALESCE(pydsde.period_name, pyper.period_name) AS VARCHAR(128)) AS py_per_desc
  ,CAST(COALESCE(pydsen.period_name, pyper.period_name) AS VARCHAR(128)) AS py_per_desc_EN
  ,CAST(0 AS BYTEINT) prot_fg
FROM P_LEW_CORE_AC.v_market_region_split AS dt
INNER JOIN P_LEW_PROCESS_MSTR_AC.v_lil_region AS reg
    ON reg.region_sid = dt.region_sid
INNER JOIN P_LEW_PROCESS_MSTR_AC.v_lil_region AS split
    ON split.region_sid = dt.region_sid_split
INNER JOIN P_LEW_PROCESS_MSTR_AC.v_lil_region_retailer AS rtl
    ON rtl.retailer_sid = dt.retailer_sid
    AND rtl.region_sid = dt.region_sid
INNER JOIN P_LEW_CORE_AC.v_lil_period AS per
    ON per.client_id = dt.client_id
    AND per.period_sid = dt.period_sid
LEFT OUTER JOIN P_LEW_CORE_AC.v_lil_period_descr AS dsde
    ON dsde.period_sid = per.period_sid
    AND dsde.lang_cd = 'DE'
LEFT OUTER JOIN P_LEW_CORE_AC.v_lil_period_descr AS dsen
    ON dsen.period_sid = per.period_sid
    AND dsen.lang_cd = 'EN'
INNER JOIN P_LEW_PROCESS_MSTR_AC.v_lil_period AS perms
    ON perms.client_id = dt.client_id
    AND perms.period_sid = dt.period_sid
INNER JOIN P_LEW_PROCESS_MSTR_AC.v_lil_gfk_category AS gfk
    ON gfk.client_id = dt.client_id
    AND gfk.gfk_cat_sid = dt.gfk_cat_sid
INNER JOIN P_LEW_MART_CM.v_lil_currency_exch_rt AS cer
    ON cer.from_currency_iso_cd = dt.curr_cd
LEFT OUTER JOIN P_LEW_CORE_AC.v_market_region_split AS py
    ON py.client_id = dt.client_id
    AND py.period_sid = per.period_sid_py
    AND py.region_sid = dt.region_sid
    AND py.retailer_sid = dt.retailer_sid
    AND py.gfk_cat_sid = dt.gfk_cat_sid
    AND py.promotion_brand_id = dt.promotion_brand_id
    AND py.region_sid_split = dt.region_sid_split
LEFT OUTER JOIN P_LEW_CORE_AC.v_lil_period AS pyper
    ON pyper.client_id = py.client_id
    AND pyper.period_sid = py.period_sid
LEFT OUTER JOIN P_LEW_CORE_AC.v_lil_period_descr AS pydsde
    ON pydsde.period_sid = pyper.period_sid
    AND pydsde.lang_cd = 'DE'
LEFT OUTER JOIN P_LEW_CORE_AC.v_lil_period_descr AS pydsen
    ON pydsen.period_sid = pyper.period_sid
    AND pydsen.lang_cd = 'EN'
LEFT OUTER JOIN P_LEW_CORE_AC.v_lil_retailer_period AS rtlper
    ON rtlper.client_id = dt.client_id
    AND rtlper.retailer_sid = dt.retailer_sid
    AND rtlper.period_sid = dt.period_sid
    AND rtlper.deleted_fg = 0
    AND rtlper.interface_name = 'LIFT_FMCG_RegionSplit'
CROSS JOIN (
    SELECT
        meas_id
      , meas_cd
      , monetary_fg
        FROM P_LEW_PROCESS_MSTR_AC.v_lil_measure
        WHERE meas_cd IN (
        'turnover_val', 'pot_turnover_val', 'category_lidl_val', 'trip_cnt', 'buyer_cnt', 'pot_buyer_cnt'
        ,'household_in_country_cnt', 'spend_per_trip_val', 'buy_freq', 'pot_turnover_exploit_pct'
        ,'spend_per_trip_val', 'spend_per_buyer_val', 'household_penetrate_pct', 'loyalty_pct'
        ,'closure_rate_pct', 'buyer_quality', 'lidl_market_share_pct'
      )
    ) AS meas
WHERE NOT meas.meas_id IN (44)
    AND dt.deleted_fg = 0
    AND NOT EXISTS(
        SELECT NULL
        FROM P_LEW_PROCESS_MSTR_AC.v_lil_data_mask AS dm
        WHERE dm.client_id = dt.client_id
        AND dm.region_sid = dt.region_sid
        AND dm.period_sid = dt.period_sid
        AND dm.interface_name = 'LIFT_FMCG_RegionSplit'
        AND dm.mask_data_fg = 1)
    AND val IS NOT NULL
    ;
