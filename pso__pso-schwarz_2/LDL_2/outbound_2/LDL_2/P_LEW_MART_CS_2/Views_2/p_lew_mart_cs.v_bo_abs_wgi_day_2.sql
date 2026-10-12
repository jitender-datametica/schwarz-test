/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for #X_LEW_MART_CS#.v_bo_abs_wgi_day_2
#----------------------------------------------------------------------------
# History:
#  1.0  15.03.2021    Gunes, Oguzhan               Transfer to Snowflake.
#                                                  https://jira.schwarz/browse/DDLE-1783
#                                                  Create scripts for snowflake standardisation.
#----------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_p_lew_mart_cs.v_bo_abs_wgi_day_2 (client_id, country_desc, country_id, country_iso_cd, store_id
, orig_store_nr, store_desc, city, wh_id, wh_desc, sales_manager_id, sales_manager_name, account_manager_id,
account_manager_name, item_wgi_id, dat_formdate, week_page_by, currency_iso_cd, val_rtl_rl_sfo_store_asis,
val_rtl_rl_net_sfo_store_asis, val_wrtoff_zero_asis, val_wrtoff_zero_net_asis, val_discount_sfo_asis,
val_discount_net_sfo_asis, val_rtl_ejr_adj_asis, val_rtl_net_ejr_adj_asis, sfo_to_val_retail_pct,
sfo_to_val_retail_net_pct) AS SELECT client_id,
 country_desc,
 country_id,
 country_iso_cd,
 store_id,
 orig_store_nr,
 store_desc,
 city,
 wh_id,
 wh_desc,
 sales_manager_id,
 sales_manager_name,
 account_manager_id,
 account_manager_name,
 item_wgi_id,
 dat_formdate,
 week_page_by,
 currency_iso_cd,
 val_rtl_rl_sfo_store_asis,
 val_rtl_rl_net_sfo_store_asis,
 val_wrtoff_zero_asis,
 val_wrtoff_zero_net_asis,
 val_discount_sfo_asis,
 val_discount_net_sfo_asis,
 val_rtl_ejr_adj_asis,
 val_rtl_net_ejr_adj_asis,
 sfo_to_val_retail_pct,
 sfo_to_val_retail_net_pct
FROM ldl_p_lew_mart_msi.v_bo_abs_wgi_day_2;