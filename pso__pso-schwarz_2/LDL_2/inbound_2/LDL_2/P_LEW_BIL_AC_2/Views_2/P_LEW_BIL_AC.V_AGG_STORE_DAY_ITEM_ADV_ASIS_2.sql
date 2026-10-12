/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for P_LEW_BIL_AC.V_AGG_STORE_DAY_ITEM_ADV_ASIS_2
#----------------------------------------------------------------------------
# History:
#
#  Vrs Date       Developer               Task
#  --- ---------- ----------------------- --------------------------------
#  1.0 2018-11-26 Samuel Tefera           Patch-1892_Rebuild of Advertisement Aggregation
#                                                with new source logic
#  1.1 2019-05-20 Rolf Barten             Patch-2081
#                                         change from normal v_View to n_View
#  1.2 2021-02-01 Tris Bayliff            Re_2-point to new Frisch Fische temp view
#                                         20210128_2726_QV_FrischFish_P1
#  2.0 2021-05-18 Tris Bayliff            Transfer to Snowflake
#                                         https://jira.schwarz/browse/REP2-9501
#
#----------------------------------------------------------------------------
*/

CREATE OR REPLACE VIEW P_LEW_BIL_AC.V_AGG_STORE_DAY_ITEM_ADV_ASIS_2 COMMENT = 'View on aggregate table to calculate sales_2 ratio/Abverkaufsquote of advertisements'
(
  client_id
, loc_sid_wh
, wh_id
, loc_sid_store_move_to
, src_itemgrp_int_cd
, item_sid
, dat_adv
, dat_formdate
, qty_sales
, qty_delivery
, qty_stc_real
, timestamp_mod
)
AS
SELECT
  client_id
, loc_sid_wh
, wh_id
, loc_sid_store_move_to
, src_itemgrp_int_cd
, item_sid
, dat_adv
, dat_formdate
, qty_sales
, qty_delivery
, qty_stc_real
, timestamp_mod
FROM P_LEW_BIL.T_AGG_STORE_DAY_ITEM_ADV_ASIS_2
;