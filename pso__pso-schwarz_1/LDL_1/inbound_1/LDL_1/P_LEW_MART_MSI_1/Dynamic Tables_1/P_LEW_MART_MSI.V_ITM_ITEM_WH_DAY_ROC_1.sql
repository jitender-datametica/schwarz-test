CREATE OR REPLACE DYNAMIC TABLE P_LEW_MART_MSI.V_ITM_ITEM_WH_DAY_ROC_1
TARGET_LAG = '1 hour, 30 minutes'  -- dummy_1 value; will be refreshed by Abinitio job
REFRESH_MODE = FULL 
INITIALIZE = ON_CREATE 
WAREHOUSE = WH_LDL_%%environmentAbbreviation%%_DYNAMIC_TABLE_P_LEW_MART_MSI
AS
SELECT
  a.client_id
, wh.src_wh_id AS wh_id
, a.item_sid   AS item_id
, a.dwh_cal_dt AS dat_formdate
, a.stock_slot_fg
, a.stock_case_size_fg
, a.qty_piece_five_weeks_fg
, a.qty_piece_vs_case_size_fg
, CAST(a.stock_slot_fg AS CHAR(1))
  || CAST(a.stock_case_size_fg AS CHAR(1))
  || CAST(a.qty_piece_five_weeks_fg AS CHAR(1))
  || CAST(a.qty_piece_vs_case_size_fg AS CHAR(1)) AS flags_combined
, a.qty_piece_stc_wh/COALESCE(itm.case_size,1)/CASE WHEN itm_wh.case_factor_euro IS NULL OR itm_wh.case_factor_euro=0 THEN 1 ELSE itm_wh.case_factor_euro END AS qty_piece_ep_wh
, a.qty_total_goodsout_avg_35_days/COALESCE(itm.case_size,1)/CASE WHEN itm_wh.case_factor_euro IS NULL OR itm_wh.case_factor_euro=0 THEN 1 ELSE itm_wh.case_factor_euro END AS qty_total_goodsout_avg_35_days_ep
, qty_piece_ep_wh*qty_piece_ep_wh/NULLIFZERO(qty_total_goodsout_avg_35_days_ep) AS rwl_nominator
, a.qty_piece_stc_wh AS qty_piece_stc_wh
, a.price_net / CAST(cry.exchange_rate AS DECIMAL(19,5)) AS price_retail_net_stc_wh
, cry.curr_cd_from AS currency_iso_cd
FROM p_lew_bil_ac.v_item_wh_day_roc_1 AS a
/* 
 # Aufloesung WH 
*/
INNER JOIN p_lew_bil_ac.v_warehouse_1 AS wh
ON  wh.client_id     = a.client_id
AND wh.loc_sid_wh    = a.loc_sid
AND wh.dwh_actual_fg = 1
/*
# selection of currency_iso_cd and exchange_rate for the price calculation
*/
INNER JOIN p_lew_core_ac.v_exchange_rate_known_hist_1 AS cry
ON  a.client_id = cry.client_id
/*
# latest rate (point in history)
*/
AND CURRENT_DATE BETWEEN cry.active_from_dt AND cry.active_to_dt
/*
# latest history (version)
*/
AND CURRENT_DATE BETWEEN cry.dwh_valid_from AND cry.dwh_valid_to
INNER JOIN p_lew_core_ac.v_exchange_rate_type_1 AS ert
ON  cry.client_id       = ert.client_id
AND cry.x_rate_type_sid = ert.x_rate_type_sid
/*
# reporting rate (slow moving)
*/
AND ert.src_kurst       = '@BEWE'
/*
# Kolliinhalt
*/
INNER JOIN p_lew_mart_lead_ac.v_itm_item_1 AS itm 
ON a.client_id = itm.client_id 
AND a.item_sid = itm.item_id
/*
# Palettenfaktor
*/
INNER JOIN p_lew_mart_msi.v_itm_item_wh_1 itm_wh
ON a.client_id = itm_wh.client_id 
AND a.item_sid = itm_wh.item_id 
AND wh.src_wh_id = itm_wh.wh_id
;