/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for lew_mart_lead.v_agg_wh_day_item_sfo_asis.
#----------------------------------------------------------------------------
# Subversion Infostamp Start          (DO NOT EDIT INFOSTAMP)
#----------------------------------------------------------------------------
# History:
#  1.0  01.07.2019    Chandramani Kumbhale     Initial version.
#                                              VIEW migrated from MSI layer to LEAD layer for LEAD reports.
#                                              https://jira-lidl-public.pixsoftware.de/browse/IDMO-1975
#                                              20190701_2138_MCD_Obj_Migrt_To_Lead_Rep5
#  1.1  30.11.2020    Chandramani Kumbhale     Filtered out test_1 stores data
#                                              Logic from BIL layer till MART layer has been clubbed together in this view itself since views were on WH level
#                                              https://jira.schwarz/browse/REP4-8061
#                                              20201124_2673_Filter_Out_Test_Stores
#  1.2  15.02.2021    Michael Morris           Transfer to Snowflake
#                                              https://jira.schwarz/browse/REP4-8587
#----------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_p_lew_mart_lead.v_agg_wh_day_item_sfo_asis_1 (client_id, wh_id, dat_formdate, item_id,
sfotype_id, pcwo_reason_id, qty_total_sfo_asis, qty_total_sfo_wrtoff_zero_asis, val_rtl_rcptline_sfo_asis,
val_rtl_rl_net_sfo_asis, val_wrtoff_zero_asis, val_wrtoff_zero_net_asis, val_pr_diff_sfo_asis, val_pr_diff_net_sfo_asis
, qty_total_fa_sfo_asis, qty_tot_sfo_wrtoff_zr_fa_asis, val_rtl_rcptline_fa_sfo_asis, val_rtl_rl_net_fa_sfo_asis,
val_wrtoff_zero_fa_asis, val_wrtoff_zero_net_fa_asis, val_pr_diff_fa_sfo_asis, val_pr_diff_net_fa_sfo_asis,
currency_iso_cd) OPTIONS(DESCRIPTION = `AGGREGATED WAWI AND ELWIS KLEINBELEGE / STORFORMS`) AS
/* Heranziehen akteller Wechselkurse */ SELECT SFO.client_id,
 WH.src_wh_id AS wh_id,
 SFO.booking_dat AS dat_formdate,
 ITMP.item_sid_map AS item_id,
 SFO.sfotype_id,
 SFO.pcwo_reason_id,
 SUM(SFO.sfo_total_qty) AS qty_total_sfo_asis,
 SUM(SFO.sfo_wrtoff_zero_qty) AS qty_total_sfo_wrtoff_zero_asis,
  SUM(SFO.sfo_total_rtl_rl_val) / CRY.exchange_rate AS val_rtl_rcptline_sfo_asis,
  SUM(SFO.sfo_total_rtl_rl_net_val) / CRY.exchange_rate AS val_rtl_rl_net_sfo_asis,
  SUM(SFO.sfo_wrtoff_zero_rtl_rl_val) / CRY.exchange_rate AS val_wrtoff_zero_asis,
  SUM(SFO.sfo_wrtoff_zero_rtl_rl_net_val) / CRY.exchange_rate AS val_wrtoff_zero_net_asis,
  SUM(SFO.val_pr_diff_sfo) / CRY.exchange_rate AS val_pr_diff_sfo_asis,
  SUM(SFO.val_pr_diff_net_sfo) / CRY.exchange_rate AS val_pr_diff_net_sfo_asis,
 SUM(CASE
   WHEN SFO.foodaction_fg = 1
   THEN SFO.sfo_total_qty
   ELSE NULL
   END) AS qty_total_fa_sfo_asis,
 SUM(CASE
   WHEN SFO.foodaction_fg = 1
   THEN SFO.sfo_wrtoff_zero_qty
   ELSE NULL
   END) AS qty_tot_sfo_wrtoff_zr_fa_asis,
  SUM(CASE
    WHEN SFO.foodaction_fg = 1
    THEN SFO.sfo_total_rtl_rl_val
    ELSE NULL
    END) / CRY.exchange_rate AS val_rtl_rcptline_fa_sfo_asis,
  SUM(CASE
    WHEN SFO.foodaction_fg = 1
    THEN SFO.sfo_total_rtl_rl_net_val
    ELSE NULL
    END) / CRY.exchange_rate AS val_rtl_rl_net_fa_sfo_asis,
  SUM(CASE
    WHEN SFO.foodaction_fg = 1
    THEN SFO.sfo_wrtoff_zero_rtl_rl_val
    ELSE NULL
    END) / CRY.exchange_rate AS val_wrtoff_zero_fa_asis,
  SUM(CASE
    WHEN SFO.foodaction_fg = 1
    THEN SFO.sfo_wrtoff_zero_rtl_rl_net_val
    ELSE NULL
    END) / CRY.exchange_rate AS val_wrtoff_zero_net_fa_asis,
  SUM(CASE
    WHEN SFO.foodaction_fg = 1
    THEN SFO.val_pr_diff_sfo
    ELSE NULL
    END) / CRY.exchange_rate AS val_pr_diff_fa_sfo_asis,
  SUM(CASE
    WHEN SFO.foodaction_fg = 1
    THEN SFO.val_pr_diff_net_sfo
    ELSE NULL
    END) / CRY.exchange_rate AS val_pr_diff_net_fa_sfo_asis,
 CRY.curr_cd_from AS currency_iso_cd
FROM ldl_p_lew_bil_ac.v_agg_store_day_item_sfo_1 AS SFO
 INNER JOIN ldl_p_lew_core_ac.v_exchange_rate_known_hist_1 AS CRY ON SFO.client_id = CRY.client_id AND CURRENT_DATE
    BETWEEN CRY.active_from_dt AND CRY.active_to_dt AND CURRENT_DATE BETWEEN CRY.dwh_valid_from AND CRY.dwh_valid_to
   /* Einschränkung auf relevanten Kurstyp */
 INNER JOIN ldl_p_lew_core_ac.v_exchange_rate_type_1 AS C ON CRY.client_id = C.client_id AND CRY.x_rate_type_sid = C.x_rate_type_sid
     AND C.src_kurst = '@BEWE' /* Auflösung WH */
 INNER JOIN ldl_p_lew_bil_ac.v_warehouse_1 AS WH ON SFO.client_id = WH.client_id AND SFO.loc_sid_wh_asis = WH.loc_sid_wh
  AND WH.dwh_actual_fg = 1 /* Auflösung Item_1 */
 INNER JOIN ldl_p_lew_core_ac.v_item_map_key_1 AS ITMP ON SFO.client_id = ITMP.client_id AND SFO.item_sid
   /* Filter out test_1 stores data */ = ITMP.item_sid
 INNER JOIN ldl_p_lew_bil_ac.v_store_1 AS STR ON SFO.client_id = STR.client_id AND SFO.loc_sid_store = STR.loc_sid_store
   AND SFO.booking_dat BETWEEN STR.dwh_valid_from AND STR.dwh_valid_to AND STR.test_store_fg = 0
GROUP BY SFO.client_id,
 wh_id,
 dat_formdate,
 item_id,
 SFO.sfotype_id,
 SFO.pcwo_reason_id,
 currency_iso_cd,
 CRY.exchange_rate;