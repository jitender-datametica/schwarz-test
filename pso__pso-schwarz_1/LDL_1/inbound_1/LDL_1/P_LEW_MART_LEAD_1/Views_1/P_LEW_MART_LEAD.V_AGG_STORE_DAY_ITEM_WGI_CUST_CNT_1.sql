/*
#----------------------------------------------------------------------------
# LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for P_LEW_MART_LEAD.V_AGG_STORE_DAY_ITEM_CUST_CNT_1
#----------------------------------------------------------------------------
# History:
# 1.0 2022-03-18  Marcin Malec        Initial Version
#                                     SPEC0148143 - Anz. Kunden | Sortimentsebene
# 1.1 2025-04-03  Bharat Yeddulapalli  Added new column to bring customer count at Store - Day Level as part of AP0257238| SPEC0304265.
#----------------------------------------------------------------------------
*/

CREATE OR REPLACE VIEW P_LEW_MART_LEAD.V_AGG_STORE_DAY_ITEM_WGI_CUST_CNT_1
(
  client_id
, loc_sid_store
, src_orig_store_nr
, move_to_store_id
, dwh_cal_dt
, cy_month
, busyear
, item_grp_int_sid
, itemgroup_int_id
, aspect_id
, wh_id
, wgi_cnt_customer
, store_day_wgi_cnt_customer
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
, s.item_grp_int_sid
, s.itemgroup_int_id
, o.aspect_id
, o.wh_id
, s.wgi_cnt_customer
, s.store_day_cnt_customer AS store_day_wgi_cnt_customer
FROM P_LEW_MART_LEAD.T_AGG_STORE_DAY_ITEM_CUST_CNT_1 AS s
INNER JOIN P_LEW_MART_LEAD_AC.V_ORG_STORE_MERGE_1 AS o
ON s.client_id = o.client_id
AND s.loc_sid_store = o.store_id
INNER JOIN P_LEW_CORE_AC.V_CAL_CALENDARDAY_1 AS c
ON s.dwh_cal_dt = c.cal_dt
;
