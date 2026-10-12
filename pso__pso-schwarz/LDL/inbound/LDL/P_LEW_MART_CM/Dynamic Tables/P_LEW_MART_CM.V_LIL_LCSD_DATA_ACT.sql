
CREATE OR REPLACE DYNAMIC TABLE P_LEW_MART_CM.V_LIL_LCSD_DATA_ACT
(
client_id
, clnt_rtl_id
, rtl_id
, rtl_lvl
, per_id
, lift_cat_id
, prom_id
, lcsd_id
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
,NULL AS clnt_rtl_id
,rtl.rtl_id
,CAST(CASE
        WHEN rtlper.retailer_sid_parent IS NOT NULL THEN 15
        ELSE rtl.rtl_lvl END AS SMALLINT) AS rtl_lvl
,perms.period_id AS per_id
,gfk.gfk_cat_id AS lift_cat_id
,1 AS prom_id
,dt.lcsd_id
,CAST(TRUNC(CASE dt.data_confidence_fg WHEN 1 THEN 101 ELSE 0 END) AS INTEGER) AS raw_buyer_id
,CAST(cer.to_currency_iso_cd AS CHAR(3)) AS currency_iso_cd
,meas.meas_id
,CAST(CASE meas.meas_cd
        WHEN 'turnover_val'                       THEN (CAST(dt.turnover_val AS DECIMAL(38,9))/1000)::DECIMAL(23,5)
       WHEN 'pot_turnover_val'                   THEN (dt.pot_turnover_val/1000)::DECIMAL(23,5)
       WHEN 'trip_cnt'                  THEN (dt.trip_cnt/1000)::DECIMAL(23,5)
       WHEN 'buyer_cnt'                 THEN (dt.buyer_cnt/1000)::DECIMAL(23,5)
       WHEN 'household_in_country_cnt'                THEN (dt.household_in_country_cnt/1000)::DECIMAL(23,5)
       WHEN 'spend_per_trip_val'              THEN dt.spend_per_trip_val
       WHEN 'buy_freq'                   THEN dt.buy_freq
       WHEN 'pot_turnover_exploit_pct'             THEN dt.pot_turnover_exploit_pct
       WHEN 'household_penetrate_pct'                  THEN dt.household_penetrate_pct
       WHEN 'turnover_total_val'                 THEN dt.turnover_total_val
       WHEN 'buyer_of_retailer_cnt'               THEN dt.buyer_of_retailer_cnt
       WHEN 'turnover_share_pct'               THEN dt.turnover_share_pct
       WHEN 'buyer_share_pct'               THEN dt.buyer_share_pct
       WHEN 'turnover_change_pct'              THEN dt.turnover_change_pct
       WHEN 'pot_turnover_change_pct'          THEN dt.pot_turnover_change_pct
       WHEN 'trip_cnt_change_pct'             THEN dt.trip_cnt_change_pct
       WHEN 'buyer_cnt_change_pct'            THEN dt.buyer_cnt_change_pct
       WHEN 'household_in_country_cnt_change_pct'       THEN dt.household_in_country_cnt_change_pct
       WHEN 'raw_buyer_change_pct'        THEN dt.raw_buyer_change_pct
       WHEN 'spend_per_trip_change_pct'   THEN dt.spend_per_trip_change_pct
       WHEN 'buy_freq_change_pct'        THEN dt.buy_freq_change_pct
       WHEN 'pot_turnover_exploit_change_pct'          THEN dt.pot_turnover_exploit_change_pct
       WHEN 'turnover_share_change_pct'            THEN dt.turnover_share_change_pct
       WHEN 'buyer_share_change_pct'            THEN dt.buyer_share_change_pct
       WHEN 'household_penetrate_change_pct'               THEN dt.household_penetrate_change_pct
     END *
     CASE
       WHEN meas.monetary_fg = 1 THEN cer.rate_currency_exchange
                                 ELSE 1
    END AS DECIMAL(23,5)) AS val
,CAST(CASE meas.meas_cd
       WHEN 'turnover_val'                       THEN (CAST(py.turnover_val AS DECIMAL(38,9))/1000)::DECIMAL(23,5)
       WHEN 'pot_turnover_val'                   THEN (py.pot_turnover_val/1000)::DECIMAL(23,5)
       WHEN 'trip_cnt'                  THEN (py.trip_cnt/1000)::DECIMAL(23,5)
       WHEN 'buyer_cnt'                 THEN (py.buyer_cnt/1000)::DECIMAL(23,5)
       WHEN 'household_in_country_cnt'                THEN (py.household_in_country_cnt/1000)::DECIMAL(23,5)
       WHEN 'spend_per_trip_val'              THEN py.spend_per_trip_val
       WHEN 'buy_freq'                   THEN py.buy_freq
       WHEN 'pot_turnover_exploit_pct'             THEN py.pot_turnover_exploit_pct
       WHEN 'household_penetrate_pct'                  THEN py.household_penetrate_pct
       WHEN 'turnover_total_val'                 THEN py.turnover_total_val
       WHEN 'buyer_of_retailer_cnt'               THEN py.buyer_of_retailer_cnt
       WHEN 'turnover_share_pct'               THEN py.turnover_share_pct
       WHEN 'buyer_share_pct'               THEN py.buyer_share_pct
       WHEN 'turnover_change_pct'              THEN py.turnover_change_pct
       WHEN 'pot_turnover_change_pct'          THEN py.pot_turnover_change_pct
       WHEN 'trip_cnt_change_pct'             THEN py.trip_cnt_change_pct
       WHEN 'buyer_cnt_change_pct'            THEN py.buyer_cnt_change_pct
       WHEN 'household_in_country_cnt_change_pct'       THEN py.household_in_country_cnt_change_pct
       WHEN 'raw_buyer_change_pct'        THEN py.raw_buyer_change_pct
       WHEN 'spend_per_trip_change_pct'   THEN py.spend_per_trip_change_pct
       WHEN 'buy_freq_change_pct'        THEN py.buy_freq_change_pct
       WHEN 'pot_turnover_exploit_change_pct'          THEN py.pot_turnover_exploit_change_pct
       WHEN 'turnover_share_change_pct'            THEN py.turnover_share_change_pct
       WHEN 'buyer_share_change_pct'            THEN py.buyer_share_change_pct
       WHEN 'household_penetrate_change_pct'               THEN py.household_penetrate_change_pct
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
FROM p_lew_core_ac.v_market_household_loyalty AS dt
INNER JOIN p_lew_process_mstr_ac.v_lil_region AS reg
ON reg.region_sid = dt.region_sid
INNER JOIN p_lew_process_mstr_ac.v_lil_region_retailer AS rtl
ON rtl.client_id = dt.client_id
AND rtl.retailer_sid = dt.retailer_sid
AND rtl.region_sid = dt.region_sid
INNER JOIN p_lew_core_ac.v_lil_period AS per
ON per.client_id = dt.client_id
AND per.period_sid = dt.period_sid
LEFT OUTER JOIN p_lew_core_ac.v_lil_period_descr AS dsde
ON dsde.period_sid = per.period_sid
AND dsde.lang_cd = 'DE'
LEFT OUTER JOIN p_lew_core_ac.v_lil_period_descr AS dsen
ON dsen.period_sid = per.period_sid
AND dsen.lang_cd = 'EN'
INNER JOIN p_lew_process_mstr_ac.v_lil_period AS perms
ON perms.client_id = dt.client_id
AND perms.period_sid = dt.period_sid
INNER JOIN p_lew_process_mstr_ac.v_lil_gfk_category AS gfk
ON gfk.client_id = dt.client_id
AND gfk.gfk_cat_sid = dt.gfk_cat_sid
INNER JOIN p_lew_mart_cm.v_lil_currency_exch_rt AS cer
ON cer.from_currency_iso_cd = dt.curr_cd
LEFT OUTER JOIN p_lew_core_ac.v_market_household_loyalty AS py
ON py.client_id = dt.client_id
AND py.period_sid = per.period_sid_py
AND py.region_sid = dt.region_sid
AND py.retailer_sid = dt.retailer_sid
AND py.gfk_cat_sid = dt.gfk_cat_sid
AND py.lcsd_id = dt.lcsd_id
LEFT OUTER JOIN p_lew_core_ac.v_lil_period AS pyper
ON pyper.client_id =py.client_id
AND pyper.period_sid = py.period_sid
LEFT OUTER JOIN p_lew_core_ac.v_lil_period_descr AS pydsde
ON pydsde.period_sid = pyper.period_sid
AND pydsde.lang_cd = 'DE'
LEFT OUTER JOIN p_lew_core_ac.v_lil_period_descr AS pydsen
ON pydsen.period_sid = pyper.period_sid
AND pydsen.lang_cd = 'EN'
LEFT OUTER JOIN p_lew_core_ac.v_lil_retailer_period AS rtlper
    ON rtlper.client_id = dt.client_id
    AND rtlper.retailer_sid = dt.retailer_sid
    AND rtlper.period_sid = dt.period_sid
    AND rtlper.deleted_fg = 0
    AND rtlper.interface_name = 'LIFT_FMCG_LCSD'
CROSS JOIN (SELECT
meas_id
,meas_cd
,monetary_fg
FROM p_lew_process_mstr_ac.v_lil_measure
      WHERE meas_cd IN ( 'turnover_val', 'pot_turnover_val', 'trip_cnt', 'buyer_cnt', 'household_in_country_cnt'
      ,'spend_per_trip_val', 'buy_freq', 'pot_turnover_exploit_pct', 'household_penetrate_pct'
      ,'turnover_total_val', 'buyer_of_retailer_cnt', 'turnover_share_pct', 'buyer_share_pct', 'turnover_change_pct'
      ,'pot_turnover_change_pct', 'trip_cnt_change_pct', 'buyer_cnt_change_pct'
      ,'household_in_country_cnt_change_pct', 'raw_buyer_change_pct', 'spend_per_trip_change_pct'
      ,'buy_freq_change_pct', 'pot_turnover_exploit_change_pct', 'turnover_share_change_pct'
      ,'buyer_share_change_pct', 'household_penetrate_change_pct'
     )
   ) AS meas
   WHERE meas.meas_id NOT IN (43,44)
   AND COALESCE(dt.deleted_fg, 0) = 0
   /* AND val IS NOT NULL */
   AND NOT EXISTS(SELECT
NULL
FROM p_lew_process_mstr_ac.v_lil_data_mask AS dm
WHERE dm.client_id = dt.client_id
AND dm.region_sid = dt.region_sid
AND dm.period_sid = dt.period_sid
AND dm.interface_name = 'LIFT_FMCG_LCSD'
AND dm.mask_data_fg = 1)
;
