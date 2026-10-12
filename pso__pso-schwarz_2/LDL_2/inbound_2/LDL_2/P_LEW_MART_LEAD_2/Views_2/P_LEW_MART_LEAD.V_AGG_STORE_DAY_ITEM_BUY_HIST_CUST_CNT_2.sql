/*
#----------------------------------------------------------------------------
# LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for P_LEW_MART_LEAD.V_AGG_STORE_DAY_ITEM_BUY_HIST_CUST_CNT_2
#----------------------------------------------------------------------------
# History:
# 1.0 2023-01-11  Marcin Malec        Initial Version
#                                     SPEC0148143 - Anz. Kunden | Sortimentsebene
# 2.4 2025-04-03  Bharat Yeddulapalli  Added new column to bring customer count at Store - Day Level as part of AP0257238| SPEC0304265.
#
#----------------------------------------------------------------------------
*/

CREATE OR REPLACE VIEW P_LEW_MART_LEAD.V_AGG_STORE_DAY_ITEM_BUY_HIST_CUST_CNT_2
(
  client_id
, loc_sid_store
, src_orig_store_nr
, move_to_store_id
, dwh_cal_dt
, cy_month
, busyear
, aspect_id
, wh_id
, buying_list_type_id_hist
, buy_list_hist_cnt_customer
, store_day_buy_list_hist_cnt_customer
)
AS
SELECT DISTINCT
  s.client_id
, s.loc_sid_store
, o.orig_store_nr AS src_orig_store_nr
, o.move_to_store_id
, s.dwh_cal_dt
, s.cy_month
, c.busyear
, o.aspect_id
, o.wh_id
, s.buying_list_type_id_hist
, s.buy_list_hist_cnt_customer
, s.store_day_cnt_customer AS store_day_buy_list_hist_cnt_customer
FROM P_LEW_MART_LEAD.T_AGG_STORE_DAY_ITEM_CUST_CNT_2 AS s
INNER JOIN P_LEW_MART_LEAD_AC.V_ORG_STORE_MERGE_2 AS o
ON s.client_id = o.client_id
AND s.loc_sid_store = o.store_id
INNER JOIN P_LEW_CORE_AC.V_CAL_CALENDARDAY_2 AS c
ON s.dwh_cal_dt = c.cal_dt
;
