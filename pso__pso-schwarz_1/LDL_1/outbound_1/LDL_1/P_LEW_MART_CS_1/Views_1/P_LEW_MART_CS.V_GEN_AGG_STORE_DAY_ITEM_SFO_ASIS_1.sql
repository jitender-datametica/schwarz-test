/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for #X_LEW_MART_CS#.V_GEN_AGG_STORE_DAY_ITEM_SFO_ASIS_1
#----------------------------------------------------------------------------
# History:
#  1.0  15.03.2021    Gunes, Oguzhan               Transfer to Snowflake.
#                                                  https://jira.schwarz/browse/DDLE-1783
#                                                  Create scripts for snowflake standardisation.
#----------------------------------------------------------------------------
*/


/* * Date: 27.11.2019  User: wieberadm_asp
* View ist 1:1 aus MART_MSI und müsste in dem BIL überführt werden 
************************************************************************************************************ */
CREATE OR REPLACE VIEW ldl_p_lew_mart_cs.v_gen_agg_store_day_item_sfo_asis_1 (client_id, loc_sid_store, src_orig_store_nr
, booking_dat, cy_month, item_sid_map, sfotype_id, pcwo_reason_id, qty_total_sfo_asis, qty_total_sfo_wrtoff_zero_asis,
val_rtl_rcptline_sfo_asis, val_rtl_rl_net_sfo_asis, val_wrtoff_zero_asis, val_wrtoff_zero_net_asis, price_wh_sfo_asis,
price_wh_net_sfo_asis, price_str_sfo_asis, price_str_net_sfo_asis, currency_iso_cd) AS SELECT A.client_id,
 A.loc_sid_store,
 A.src_orig_store_nr,
 A.booking_dat,
 A.cy_month,
 ITMP.item_sid_map,
 A.sfotype_id,
 A.pcwo_reason_id,
 A.sfo_total_qty_asis AS qty_total_sfo_asis,
 A.sfo_wrtoff_zero_qty_asis AS qty_total_sfo_wrtoff_zero_asis,
  A.sfo_total_rtl_rl_val_asis / CRY.exchange_rate AS val_rtl_rcptline_sfo_asis,
  A.sfo_total_rtl_rl_net_val_asis / CRY.exchange_rate AS val_rtl_rl_net_sfo_asis,
  A.sfo_wrtoff_zero_rtl_rl_val_asis / CRY.exchange_rate AS val_wrtoff_zero_asis,
  A.sfo_wrtoff_zero_rtl_rl_net_val_asis / CRY.exchange_rate AS val_wrtoff_zero_net_asis,
  A.price_wh_sfo_asis / CRY.exchange_rate AS price_wh_sfo_asis,
  A.price_wh_net_sfo_asis / CRY.exchange_rate AS price_wh_net_sfo_asis,
  A.price_str_sfo_asis / CRY.exchange_rate AS price_str_sfo_asis,
  A.price_str_net_sfo_asis / CRY.exchange_rate AS price_str_net_sfo_asis,
 CRY.curr_cd_from AS currency_iso_cd
FROM ldl_p_lew_bil_ac.v_agg_store_day_item_sfo_asis_1 AS A
 INNER JOIN ldl_p_lew_core_ac.v_exchange_rate_known_hist_1 AS CRY ON A.client_id = CRY.client_id AND CURRENT_DATE BETWEEN
    CRY.active_from_dt AND CRY.active_to_dt AND CURRENT_DATE BETWEEN CRY.dwh_valid_from AND CRY.dwh_valid_to
 INNER JOIN ldl_p_lew_core_ac.v_exchange_rate_type_1 AS C ON CRY.client_id = C.client_id AND CRY.x_rate_type_sid = C.x_rate_type_sid
     AND C.src_kurst = '@BEWE'
 INNER JOIN ldl_p_lew_core_ac.v_item_map_key_1 AS ITMP ON A.client_id = ITMP.client_id AND A.item_sid = ITMP.item_sid;