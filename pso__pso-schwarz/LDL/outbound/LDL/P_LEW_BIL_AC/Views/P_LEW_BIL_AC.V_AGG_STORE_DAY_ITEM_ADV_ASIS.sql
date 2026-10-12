/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for P_LEW_BIL_AC.V_AGG_STORE_DAY_ITEM_ADV_ASIS
#----------------------------------------------------------------------------
# History:
#
#  Vrs Date       Developer               Task
#  --- ---------- ----------------------- --------------------------------
#  1.0 2018-11-26 Samuel Tefera           Patch-1892_Rebuild of Advertisement Aggregation
#                                                with new source logic
#  1.1 2019-05-20 Rolf Barten             Patch-2081
#                                         change from normal v_View to n_View
#  1.2 2021-02-01 Tris Bayliff            Re-point to new Frisch Fische temp view
#                                         20210128_2726_QV_FrischFish_P1
#  2.0 2021-05-18 Tris Bayliff            Transfer to Snowflake
#                                         https://jira.schwarz/browse/REP2-9501
#
#----------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_p_lew_bil_ac.v_agg_store_day_item_adv_asis (client_id, loc_sid_wh, wh_id,
loc_sid_store_move_to, src_itemgrp_int_cd, item_sid, dat_adv, dat_formdate, qty_sales, qty_delivery, qty_stc_real,
timestamp_mod)
OPTIONS(DESCRIPTION = `VIEW ON AGGREGATE TABLE TO CALCULATE SALES RATIO/ABVERKAUFSQUOTE OF ADVERTISEMENTS`) AS SELECT
 client_id,
 loc_sid_wh,
 wh_id,
 loc_sid_store_move_to,
 src_itemgrp_int_cd,
 item_sid,
 dat_adv,
 dat_formdate,
 qty_sales,
 qty_delivery,
 qty_stc_real,
 timestamp_mod
FROM ldl_p_lew_bil.t_agg_store_day_item_adv_asis;