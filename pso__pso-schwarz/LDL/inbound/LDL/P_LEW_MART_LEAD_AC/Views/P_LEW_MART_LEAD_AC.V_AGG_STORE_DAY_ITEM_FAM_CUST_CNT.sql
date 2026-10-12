/*
#----------------------------------------------------------------------------
# LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for P_LEW_MART_LEAD_AC.V_AGG_STORE_DAY_ITEM_CUST_CNT
#----------------------------------------------------------------------------
# History:
# 1.0 2022-03-18  Marcin Malec        Initial Version
#                                     SPEC0148143 - Anz. Kunden | Sortimentsebene
# 1.1 2025-04-03  Bharat Yeddulapalli  Added new column to bring customer count at Store - Day Level as part of AP0257238| SPEC0304265.
#----------------------------------------------------------------------------
*/

CREATE OR REPLACE VIEW P_LEW_MART_LEAD_AC.V_AGG_STORE_DAY_ITEM_FAM_CUST_CNT
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
, sub_item_grp_sid
, subitemgroup_id
, item_fam_grp_sid
, item_familygroup_id
, aspect_id
, wh_id
, fam_cnt_customer
, store_day_item_fam_cnt_customer
)
AS
SELECT
  client_id
, loc_sid_store
, src_orig_store_nr
, move_to_store_id
, dwh_cal_dt
, cy_month
, busyear
, item_grp_int_sid
, itemgroup_int_id
, sub_item_grp_sid
, subitemgroup_id
, item_fam_grp_sid
, item_familygroup_id
, aspect_id
, wh_id
, fam_cnt_customer
, store_day_item_fam_cnt_customer
FROM P_LEW_MART_LEAD.V_AGG_STORE_DAY_ITEM_FAM_CUST_CNT
;
