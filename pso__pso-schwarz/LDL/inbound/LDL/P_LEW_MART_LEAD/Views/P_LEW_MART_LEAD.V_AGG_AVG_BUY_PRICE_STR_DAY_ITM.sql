create or replace view LDL_PRODUCTION.P_LEW_MART_LEAD.V_AGG_AVG_BUY_PRICE_STR_DAY_ITM(
	CLIENT_ID,
	ORIG_ITEM_NR,
	DAT_VALID_FROM,
	ST_LOC_SID,
	DWH_CAL_DT,
	SALES_NET_QTY,
	SALES_NET_VAL,
	EK_PRICE_VAL,
	BUYING_PRC_SALES_VAL,
	SALES_BUYING_DIFF,
	CURRENCY_ISO_CD
) as
WITH cte_str_wh
AS 
(
 SELECT org_str.client_id
 , org_str.st_loc_sid
 , osm.move_to_st_loc_sid 
 , wh.src_wh_id AS wh_id
 , wh.loc_sid_wh AS loc_sid_wh
 , osm.aspect_id
FROM p_lew_core_ac.V_WAWI_ORG_STORE_ACT AS org_str
LEFT JOIN p_lew_core_ac.V_WAWI_ORG_ALL_STORE_RELOC_ACT AS s_mov
ON org_str.client_id = s_mov.client_id
AND org_str.st_loc_sid = s_mov.st_loc_sid
LEFT JOIN p_lew_core_ac.v_wawi_org_all_store_merge_act AS osm
ON s_mov.client_id = osm.client_id
AND s_mov.move_to_st_loc_sid = osm.move_to_st_loc_sid
INNER JOIN p_lew_bil_ac.v_warehouse AS wh
ON osm.wh_loc_sid = wh.loc_sid_wh
AND osm.client_id = wh.client_id
AND wh.dwh_actual_fg = 1
AND osm.aspect_id  = 1
GROUP BY 1,2,3,4,5,6)
, cte_agg_pos_store_orig_itm_day 
AS (
SELECT 
    ejr.client_id
  , itm.orig_item_nr
  , itm.dat_valid_from
  , st_loc_sid
  , loc_sid_wh
  , ejr.dwh_cal_dt
  , QUARTER(ejr.dwh_cal_dt) dat_quarter
  , SUM(CASE WHEN discount_sid = -1 THEN sales_weight_qty+sales_piece_qty+return_qty ELSE 0 END) sales_net_qty
  , SUM((sales_net_val+return_net_val)/cry.rate_currency_exchange) sales_net_val  
  FROM p_lew_bil_ac.v_agg_pos_store_item_day ejr
  INNER JOIN p_lew_core_ac.v_wawi_ref_client_currency_rate AS cry
  ON  ejr.client_id = cry.client_id
  AND CURRENT_DATE BETWEEN cry.dat_rec_start AND cry.dat_rec_end
  INNER JOIN p_lew_mart_lead_ac.v_itm_item itm
  ON ejr.client_id = itm.client_id
  AND ejr.item_sid = itm.item_id
  INNER JOIN cte_str_wh str
  ON ejr.client_id = str.client_id
  AND ejr.loc_sid_store = str.st_loc_sid  
  WHERE ejr.dwh_cal_dt BETWEEN (SELECT MIN(cal_dt) FROM p_lew_core_ac.v_cal_calendarday WHERE busyear_seq = -3) AND CURRENT_DATE()-601
  AND currency_iso_cd = 'EUR'
  GROUP BY 
    ejr.client_id
  , st_loc_sid
  , loc_sid_wh
  , itm.orig_item_nr
  , itm.dat_valid_from
  , ejr.dwh_cal_dt
  HAVING NULLIFZERO(sales_net_qty) IS NOT NULL 
  AND NULLIFZERO(SUM((sales_net_val+return_net_val)/cry.rate_currency_exchange)) IS NOT NULL
  ), cte_avg_buy_pric_str
AS (
SELECT 
  ejr.client_id 
, st_loc_sid   
, ejr.orig_item_nr 
, ejr.dat_valid_from 
, ejr.dwh_cal_dt 
, sales_net_qty 
, sales_net_val
, ek_price_val
  FROM cte_agg_pos_store_orig_itm_day ejr
  INNER JOIN p_lew_mart_lead.t_agg_avg_buy_val_qty_wh_day_itm ek_prc
  ON ejr.client_id = ek_prc.client_id
  AND ejr.orig_item_nr = ek_prc.orig_item_nr
  AND ejr.dat_valid_from = ek_prc.dat_valid_from
  AND ejr.loc_sid_wh = ek_prc.loc_sid_wh
  AND ejr.dwh_cal_dt = ek_prc.dwh_cal_dt
WHERE ejr.dwh_cal_dt < CURRENT_DATE()-600
UNION ALL 
SELECT 
  client_id 
, st_loc_sid   
, orig_item_nr 
, dat_valid_from 
, dwh_cal_dt 
, sales_net_qty 
, sales_net_val
, ek_price_val
  FROM p_lew_mart_lead.t_agg_avg_buy_price_str_day_itm
WHERE dwh_cal_dt BETWEEN CURRENT_DATE()-600 AND CURRENT_DATE()
  )
, cte_curr0
AS (
SELECT
  client_id	
, currency_iso_cd	
, to_currency_iso_cd
, rate_currency_exchange	
FROM p_lew_core_ac.v_wawi_ref_client_currency_rate
WHERE currency_iso_cd='EUR'
AND CURRENT_DATE() BETWEEN dat_rec_start AND dat_rec_end
), cte_curr1
AS (
SELECT client_id
, 'EUR' AS currency_iso_cd
, 'EUR' AS to_currency_iso_cd
, 1.00 AS rate_currency_exchange
FROM cte_curr0
), cte_curr
AS (
SELECT
  client_id	
, currency_iso_cd	
, to_currency_iso_cd
, rate_currency_exchange
FROM cte_curr0
UNION  
SELECT
  client_id	
, currency_iso_cd	
, to_currency_iso_cd
, rate_currency_exchange
FROM cte_curr1
)
SELECT 
  we.client_id
, orig_item_nr
, dat_valid_from
, st_loc_sid
, dwh_cal_dt
, sales_net_qty
, sales_net_val * rate_currency_exchange AS sales_net_val
, ek_price_val * rate_currency_exchange AS ek_price_val
, (ek_price_val * rate_currency_exchange)*sales_net_qty buying_prc_sales_val
, (we.sales_net_val * rate_currency_exchange)-buying_prc_sales_val sales_buying_diff
, to_currency_iso_cd AS currency_iso_cd
FROM cte_avg_buy_pric_str we
JOIN cte_curr curr
  ON we.client_id=curr.client_id;
