/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for P_LEW_MART_CS_AC.v_bo_abs_sig_day_flop10_abs_1
#----------------------------------------------------------------------------
# History:
#  1.0  15.03.2021    Gunes, Oguzhan               Transfer to Snowflake.
#                                                  https://jira.schwarz/browse/DDLE-1783
#                                                  Create scripts for snowflake standardisation.
#----------------------------------------------------------------------------
*/
CREATE OR REPLACE VIEW p_lew_mart_cs_ac.v_bo_abs_sig_day_flop10_abs_1 (
  account_manager_id
 ,account_manager_name
 ,city
 ,client_id
 ,country_desc
 ,country_id
 ,country_iso_cd
 ,currency_iso_cd
 ,dat_formdate
 ,dat_valid_from
 ,item_desc
 ,orig_item_nr
 ,orig_store_nr
 ,qty_disc_piece_weigth_ejr_asis
 ,qty_total_sfo_store
 ,sales_manager_id
 ,sales_manager_name
 ,sfo_to_val_retail_pct
 ,sfo_to_val_retail_net_pct
 ,store_desc
 ,store_id
 ,subitemgroup_id
 ,val_discount_sfo
 ,val_discount_net_sfo
 ,val_rtl_ejr_adj
 ,val_rtl_net_ejr_adj
 ,val_rtl_rl_sfo_store
 ,val_rtl_rl_net_sfo_store
 ,val_wrtoff_zero_store
 ,val_wrtoff_zero_store_net
 ,wh_desc
 ,wh_id
) AS
SELECT 
  account_manager_id
 ,account_manager_name
 ,city
 ,client_id
 ,country_desc
 ,country_id
 ,country_iso_cd
 ,currency_iso_cd
 ,dat_formdate
 ,dat_valid_from
 ,item_desc
 ,orig_item_nr
 ,orig_store_nr
 ,qty_disc_piece_weigth_ejr_asis
 ,qty_total_sfo_store
 ,sales_manager_id
 ,sales_manager_name
 ,sfo_to_val_retail_pct
 ,sfo_to_val_retail_net_pct
 ,store_desc
 ,store_id
 ,subitemgroup_id
 ,val_discount_sfo
 ,val_discount_net_sfo
 ,val_rtl_ejr_adj
 ,val_rtl_net_ejr_adj
 ,val_rtl_rl_sfo_store
 ,val_rtl_rl_net_sfo_store
 ,val_wrtoff_zero_store
 ,val_wrtoff_zero_store_net
 ,wh_desc
 ,wh_id
FROM p_lew_mart_cs.v_bo_abs_sig_day_flop10_abs_1
;