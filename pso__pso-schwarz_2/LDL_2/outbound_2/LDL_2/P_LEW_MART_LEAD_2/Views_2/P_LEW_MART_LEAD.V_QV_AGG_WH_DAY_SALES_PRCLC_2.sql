/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for P_LEW_MART_LEAD.T_QV_AGG_WH_DAY_SALES_PRCLC_2
#----------------------------------------------------------------------------
# History:
#
#  Vrs Date       Developer               Task
#  --- ---------- ----------------------- --------------------------------
#  1.0 2020-06-24 Prasanna Ranjan         20200309_2424_QuickView_remove_dum
#  2.0 2021-04-09 Tris Bayliff            Transfer to Snowflake
#                                         https://jira.schwarz/browse/REP2-9207
#
#----------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_p_lew_mart_lead.v_qv_agg_wh_day_sales_prclc_2 (client_id, client_desc, country_group_id,
country_group_desc, gl_region_id, gl_region_desc, wh_id, wh_desc, aspect_id, aspect_desc, currency_iso_cd, curr_tot_id,
dat_formdate, val_retail_net_asis, val_retail_net_asis_py, cnt_customer_asis, cnt_customer_asis_py,
val_retail_gross_asis, val_retail_gross_asis_py, cnt_customer_adj_asis, cnt_customer_adj_asis_py,
cnt_customer_adj_asis_ppy, val_retail_net_adj_asis, val_retail_net_adj_asis_py, val_retail_net_adj_asis_ppy,
val_retail_gross_adj_asis, val_retail_gross_adj_asis_py, val_retail_gross_adj_asis_ppy, val_rtl_gro_extrapol_asis,
val_rtl_net_extrapol_asis) OPTIONS(DESCRIPTION = `QUICKVIEW VIEW : DATA IS PROVIDED BY WH AND DAY.`) AS SELECT client_id
 ,
 client_desc,
 country_group_id,
 country_group_desc,
 gl_region_id,
 gl_region_desc,
 wh_id,
 wh_desc,
 aspect_id,
 aspect_desc,
 currency_iso_cd,
 curr_tot_id,
 dat_formdate,
 val_retail_net_asis,
 val_retail_net_asis_py,
 cnt_customer_asis,
 cnt_customer_asis_py,
 val_retail_gross_asis,
 val_retail_gross_asis_py,
 cnt_customer_adj_asis,
 cnt_customer_adj_asis_py,
 cnt_customer_adj_asis_ppy,
 val_retail_net_adj_asis,
 val_retail_net_adj_asis_py,
 val_retail_net_adj_asis_ppy,
 val_retail_gross_adj_asis,
 val_retail_gross_adj_asis_py,
 val_retail_gross_adj_asis_ppy,
 val_rtl_gro_extrapol_asis,
 val_rtl_net_extrapol_asis
FROM ldl_p_lew_mart_lead.t_qv_agg_wh_day_sales_prclc_2;