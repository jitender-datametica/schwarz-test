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

CREATE OR REPLACE VIEW P_LEW_MART_LEAD.V_AGG_WH_DAY_ITEM_SFO_ASIS_1 COMMENT = 'Aggregated WaWi and ELWiS Kleinbelege / Storforms'
(
  client_id                     
, wh_id                         
, dat_formdate                  
, item_id                       
, sfotype_id                    
, pcwo_reason_id                
, qty_total_sfo_asis            
, qty_total_sfo_wrtoff_zero_asis
, val_rtl_rcptline_sfo_asis     
, val_rtl_rl_net_sfo_asis       
, val_wrtoff_zero_asis          
, val_wrtoff_zero_net_asis      
, val_pr_diff_sfo_asis          
, val_pr_diff_net_sfo_asis      
, qty_total_fa_sfo_asis         
, qty_tot_sfo_wrtoff_zr_fa_asis 
, val_rtl_rcptline_fa_sfo_asis  
, val_rtl_rl_net_fa_sfo_asis    
, val_wrtoff_zero_fa_asis       
, val_wrtoff_zero_net_fa_asis   
, val_pr_diff_fa_sfo_asis       
, val_pr_diff_net_fa_sfo_asis   
, currency_iso_cd               
)
AS
SELECT
  sfo.client_id
, wh.src_wh_id      AS wh_id
, sfo.booking_dat   AS dat_formdate
, itmp.item_sid_map AS item_id
, sfo.sfotype_id
, sfo.pcwo_reason_id
, SUM(sfo.sfo_total_qty)                                                                                         AS qty_total_sfo_asis
, SUM(sfo.sfo_wrtoff_zero_qty)                                                                                   AS qty_total_sfo_wrtoff_zero_asis
, SUM(sfo.sfo_total_rtl_rl_val) / cry.exchange_rate                                                              AS val_rtl_rcptline_sfo_asis
, SUM(sfo.sfo_total_rtl_rl_net_val) / cry.exchange_rate                                                          AS val_rtl_rl_net_sfo_asis
, SUM(sfo.sfo_wrtoff_zero_rtl_rl_val) / cry.exchange_rate                                                        AS val_wrtoff_zero_asis
, SUM(sfo.sfo_wrtoff_zero_rtl_rl_net_val) / cry.exchange_rate                                                    AS val_wrtoff_zero_net_asis
, SUM(sfo.val_pr_diff_sfo) / cry.exchange_rate                                                                   AS val_pr_diff_sfo_asis
, SUM(sfo.val_pr_diff_net_sfo) / cry.exchange_rate                                                               AS val_pr_diff_net_sfo_asis
, SUM(CASE WHEN sfo.foodaction_fg = 1 THEN sfo.sfo_total_qty                  ELSE NULL END)                     AS qty_total_fa_sfo_asis
, SUM(CASE WHEN sfo.foodaction_fg = 1 THEN sfo.sfo_wrtoff_zero_qty            ELSE NULL END)                     AS qty_tot_sfo_wrtoff_zr_fa_asis
, SUM(CASE WHEN sfo.foodaction_fg = 1 THEN sfo.sfo_total_rtl_rl_val           ELSE NULL END) / cry.exchange_rate AS val_rtl_rcptline_fa_sfo_asis
, SUM(CASE WHEN sfo.foodaction_fg = 1 THEN sfo.sfo_total_rtl_rl_net_val       ELSE NULL END) / cry.exchange_rate AS val_rtl_rl_net_fa_sfo_asis
, SUM(CASE WHEN sfo.foodaction_fg = 1 THEN sfo.sfo_wrtoff_zero_rtl_rl_val     ELSE NULL END) / cry.exchange_rate AS val_wrtoff_zero_fa_asis
, SUM(CASE WHEN sfo.foodaction_fg = 1 THEN sfo.sfo_wrtoff_zero_rtl_rl_net_val ELSE NULL END) / cry.exchange_rate AS val_wrtoff_zero_net_fa_asis
, SUM(CASE WHEN sfo.foodaction_fg = 1 THEN sfo.val_pr_diff_sfo                ELSE NULL END) / cry.exchange_rate AS val_pr_diff_fa_sfo_asis
, SUM(CASE WHEN sfo.foodaction_fg = 1 THEN sfo.val_pr_diff_net_sfo            ELSE NULL END) / cry.exchange_rate AS val_pr_diff_net_fa_sfo_asis
, cry.curr_cd_from  AS currency_iso_cd
FROM p_lew_bil_ac.v_agg_store_day_item_sfo_1          AS sfo

/* Heranziehen akteller Wechselkurse */
INNER JOIN p_lew_core_ac.v_exchange_rate_known_hist_1 AS cry
ON    sfo.client_id       = cry.client_id
AND   CURRENT_DATE BETWEEN cry.active_from_dt AND cry.active_to_dt
AND   CURRENT_DATE BETWEEN cry.dwh_valid_from AND cry.dwh_valid_to

/* Einschränkung auf relevanten Kurstyp*/
INNER JOIN p_lew_core_ac.v_exchange_rate_type_1       AS c
ON    c.client_id         = cry.client_id
AND   c.x_rate_type_sid   = cry.x_rate_type_sid
AND   c.src_kurst         = '@BEWE'

/* Auflösung WH */
INNER JOIN p_lew_bil_ac.v_warehouse_1                 AS wh
ON    sfo.client_id       = wh.client_id
AND   sfo.loc_sid_wh_asis = wh.loc_sid_wh
AND   wh.dwh_actual_fg    = 1

/* Auflösung Item_1 */
INNER JOIN p_lew_core_ac.v_item_map_key_1             AS itmp
ON    itmp.client_id      = sfo.client_id
AND   itmp.item_sid       = sfo.item_sid

/* Filter out test_1 stores data */
INNER JOIN p_lew_bil_ac.v_store_1                     AS str
ON    sfo.client_id       = str.client_id
AND   sfo.loc_sid_store   = str.loc_sid_store
AND   sfo.booking_dat BETWEEN str.dwh_valid_from AND str.dwh_valid_to
AND   str.test_store_fg   = 0

GROUP BY
  sfo.client_id
, wh.src_wh_id
, sfo.booking_dat
, itmp.item_sid_map
, sfo.sfotype_id
, sfo.pcwo_reason_id
, cry.curr_cd_from
, cry.exchange_rate
;
