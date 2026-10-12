/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for #X_LEW_MART_CS#.V_GEN_AGG_STORE_DAY_ITEM_SFO_ASIS_2
#----------------------------------------------------------------------------
# History:
#  1.0  15.03.2021    Gunes, Oguzhan               Transfer to Snowflake.
#                                                  https://jira.schwarz/browse/DDLE-1783
#                                                  Create scripts for snowflake standardisation.
#----------------------------------------------------------------------------
*/
CREATE OR REPLACE VIEW P_LEW_MART_CS.V_GEN_AGG_STORE_DAY_ITEM_SFO_ASIS_2
/*************************************************************************************************************
* Date: 27.11.2019  User: wieberadm_asp
* View ist 1:1 aus MART_MSI und müsste in dem BIL überführt werden 
*************************************************************************************************************/
(
    client_id
  , loc_sid_store
  , src_orig_store_nr
  , booking_dat
  , cy_month
  , item_sid_map
  , sfotype_id
  , pcwo_reason_id
  , qty_total_sfo_asis
  , qty_total_sfo_wrtoff_zero_asis
  , val_rtl_rcptline_sfo_asis
  , val_rtl_rl_net_sfo_asis
  , val_wrtoff_zero_asis
  , val_wrtoff_zero_net_asis
  , price_wh_sfo_asis
  , price_wh_net_sfo_asis
  , price_str_sfo_asis
  , price_str_net_sfo_asis
  , currency_iso_cd

)
AS
   SELECT
   a.client_id,
   a.loc_sid_store,
   a.src_orig_store_nr,
   a.booking_dat,
   a.cy_month,
   itmp.item_sid_map,
   a.sfotype_id,
   a.pcwo_reason_id,
   a.sfo_total_qty_asis                                             AS qty_total_sfo_asis,
   a.sfo_wrtoff_zero_qty_asis                                       AS qty_total_sfo_wrtoff_zero_asis,
   a.sfo_total_rtl_rl_val_asis              / cry.exchange_rate     AS val_rtl_rcptline_sfo_asis,
   a.sfo_total_rtl_rl_net_val_asis          / cry.exchange_rate     AS val_rtl_rl_net_sfo_asis,
   a.sfo_wrtoff_zero_rtl_rl_val_asis        / cry.exchange_rate     AS val_wrtoff_zero_asis,
   a.sfo_wrtoff_zero_rtl_rl_net_val_asis    / cry.exchange_rate     AS val_wrtoff_zero_net_asis,
   a.price_wh_sfo_asis                      / cry.exchange_rate     AS price_wh_sfo_asis,
   a.price_wh_net_sfo_asis                  / cry.exchange_rate     AS price_wh_net_sfo_asis,
   a.price_str_sfo_asis                     / cry.exchange_rate     AS price_str_sfo_asis,
   a.price_str_net_sfo_asis                 / cry.exchange_rate     AS price_str_net_sfo_asis,
   cry.curr_cd_from                                                 AS currency_iso_cd
   FROM p_lew_bil_ac.v_agg_store_day_item_sfo_asis_2 a
   INNER JOIN p_lew_core_ac.v_exchange_rate_known_hist_2 AS cry
   ON a.client_id = cry.client_id
   AND Current_Date BETWEEN cry.active_from_dt AND cry.active_to_dt
   AND Current_Date BETWEEN cry.dwh_valid_from AND cry.dwh_valid_to
   INNER JOIN p_lew_core_ac.v_exchange_rate_type_2 c
   ON c.client_id = cry.client_id
   AND c.x_rate_type_sid = cry.x_rate_type_sid
   AND c.src_kurst = '@BEWE'
   INNER JOIN p_lew_core_ac.v_item_map_key_2 itmp
   ON itmp.client_id = a.client_id
   AND itmp.item_sid = a.item_sid
;