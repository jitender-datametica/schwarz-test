/*
#----------------------------------------------------------------------------
# © LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# History:
# NR  | DATE       | 1st AND 2nd NAME | DESCRIPTION OF CHANGES
#
# 1.1   30-06-2023   Aleksander Bialek   Adding this comment and header to the initial version which was deployed approx 15.05.2023 (Azure Devops WI:461587)
#                                       
#----------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_p_lew_mart_lead_ac.v_agg_avg_buy_price_str_day_itm_2 AS SELECT client_id,
 orig_item_nr,
 dat_valid_from,
 st_loc_sid AS loc_sid_store,
 dwh_cal_dt,
 currency_iso_cd,
 sales_net_qty,
 sales_net_val,
 ek_price_val,
 buying_prc_sales_val,
 sales_buying_diff
FROM ldl_p_lew_mart_lead.v_agg_avg_buy_price_str_day_itm_2;