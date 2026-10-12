/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for P_LEW_BIL.V_AGG_STORE_DAY_ITEM_ADV_ASIS_1
#----------------------------------------------------------------------------
# History:
#
#  Vrs Date       Developer               Task
#  --- ---------- ----------------------- --------------------------------
#  1.0 2021-02-01 Tris Bayliff            Initial
#                                         20210128_2726_QV_FrischFish_P1
#  1.1 2021-03-10 Tris Bayliff            Ensure src_itemgrp_int_cd is an integer
#                                         20210128_2726_QV_FrischFish_P1
#  1.2 2021-04-01 Tris Bayliff            Remove logic post FrischFish go live
#                                         20210128_2727_QV_FrischFish_P2
#  2.0 2021-05-18 Tris Bayliff            Transfer to Snowflake
#                                         https://jira.schwarz/browse/REP2-9501
#
#----------------------------------------------------------------------------
*/

CREATE OR REPLACE VIEW P_LEW_BIL.V_AGG_STORE_DAY_ITEM_ADV_ASIS_1 COMMENT = 'View on aggregate table to calculate sales_1 ratio/Abverkaufsquote of advertisements'
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
, CAST (src_itemgrp_int_cd AS NUMBER) AS src_itemgrp_int_cd
, item_sid
, dat_adv
, dat_formdate
, qty_sales
, qty_delivery
, qty_stc_real
, timestamp_mod
FROM P_LEW_BIL.T_AGG_STORE_DAY_ITEM_ADV_ASIS_1
;
