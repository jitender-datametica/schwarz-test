/*
#-----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: 20180801_1778_LidlPlus_KPIs
#            1:1 DDL
#----------------------------------------------------------------------------


#----------------------------------------------------------------------------
# Subversion Infostamp END
#----------------------------------------------------------------------------
# History:
#
#  Vrs Date       Developer               Task
#  --- ---------- ----------------------- --------------------------------
#  1.0 2020-04-14 Barbara Seneta          Initial version
#                                         20200408_2447_Customer_Segment_Fact
#  1.1 2020-05-06 Barbara Seneta          Added column wh_id (it does not change granularity of the view)
#                                         20200408_2447_Customer_Segment_Facts
#  1.2 2022-04-01 Pawel Wieczorek         AP0092849 drop column customer_segment_cd , add comments and history from SVN, remove org_lvl_id, tm_lvl_id
#----------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_p_lew_mart_lidl_digital.v_agg_rcpt_hdr_ldpl_partial_wk_2 (aspect_id
OPTIONS(description='Gesellschaftsform (1 = Betriebs- 2 = Vertriebsgesellschaft)'), client_id
OPTIONS(description='Identifier for client'), move_to_store_id OPTIONS(description='Store ID'), wh_id
OPTIONS(description='Warehouse ID'), lidlplus_cust_fg OPTIONS(description='Lidplus customer flag'), cy_week
OPTIONS(description='Week number'), cy_week_part
OPTIONS(description='Part of the week, in non transit week: value 1, in transit week: in the first part of week - value 1, in the second part of week - value 2 '),
cy_week_partial_week_id OPTIONS(description='Partial week unique id: cy_week || cy_week_part '), cy_partial_week_name
OPTIONS(description='Partial week name'), currency_iso_cd
OPTIONS(description='ISO code for the currency of the client.'), curr_tot_id
OPTIONS(description='Fixe Werte fur EUR=0, GBP=40 sonst Client_Id'), cwpart_wk_str_open_fg
OPTIONS(description='Store open flag : Current Partial week'), cwpart_tot_gros_val
OPTIONS(description='Total gross value : Current Partial week'), cwpart_tot_net_val
OPTIONS(description='Total net value : Current Partial week'), cwpart_rcpts_cnt
OPTIONS(description='Receipts count : Current Partial week'), cwpart_tot_rcpt_cnt_wk
OPTIONS(description='Total receipts count : Current Partial week'), cwpart_trans_time_in_mins
OPTIONS(description='Transaction time measured in minutes : Current Partial week'), cwpart_items_scanned_cnt
OPTIONS(description='Number of items scanned : Current Partial week'), cwpart_new_reg_cnt
OPTIONS(description='Null measure'), cwpart_dereg_cnt OPTIONS(description='Null measure'), cwpart_tot_reg_cnt
OPTIONS(description='Null measure'), cwpart_discount_val OPTIONS(description='Discount value : Current Partial week'),
pywpart_wk_str_open_fg OPTIONS(description='Store open flag : Previous year partial week'), pywpart_tot_gros_val
OPTIONS(description='Total gross value : Previous year partial week'), pywpart_tot_net_val
OPTIONS(description='Total net value : Previous year partial week'), pywpart_rcpts_cnt
OPTIONS(description='Receipts count : Previous year partial week'), pywpart_tot_rcpt_cnt_wk
OPTIONS(description='Total receipts count : Previous year partial week'), pywpart_trans_time_in_mins
OPTIONS(description='Transaction time measured in minutes : Previous year partial week'), pywpart_items_scanned_cnt
OPTIONS(description='Number of items scanned : Previous year partial week'), pywpart_new_reg_cnt
OPTIONS(description='Null measure'), pywpart_dereg_cnt OPTIONS(description='Null measure'), pywpart_tot_reg_cnt
OPTIONS(description='Null measure'), pywpart_discount_val
OPTIONS(description='Discount value : Previous year partial week'), load_id OPTIONS(description='Load identifier'),
dwh_created OPTIONS(description='Row create time'), dwh_updated OPTIONS(description='Row update time'))
OPTIONS(DESCRIPTION = `LIDLPLUS : RECEIPT HEADER AGGREGATED TO PARTIAL WEEK LEVEL`) AS SELECT aspect_id,
 client_id,
 move_to_store_id,
 wh_id,
 lidlplus_cust_fg,
 cy_week,
 cy_week_part,
 cy_week_partial_week_id,
 cy_partial_week_name,
 currency_iso_cd,
 curr_tot_id,
 cwpart_wk_str_open_fg,
 cwpart_tot_gros_val,
 cwpart_tot_net_val,
 cwpart_rcpts_cnt,
 cwpart_tot_rcpt_cnt_wk,
 cwpart_trans_time_in_mins,
 cwpart_items_scanned_cnt,
 CAST(NULL AS BIGNUMERIC) AS cwpart_new_reg_cnt,
 CAST(NULL AS BIGNUMERIC) AS cwpart_dereg_cnt,
 CAST(NULL AS BIGNUMERIC) AS cwpart_tot_reg_cnt,
 cwpart_discount_val,
 pywpart_wk_str_open_fg,
 pywpart_tot_gros_val,
 pywpart_tot_net_val,
 pywpart_rcpts_cnt,
 pywpart_tot_rcpt_cnt_wk,
 pywpart_trans_time_in_mins,
 pywpart_items_scanned_cnt,
 CAST(NULL AS BIGNUMERIC) AS pywpart_new_reg_cnt,
 CAST(NULL AS BIGNUMERIC) AS pywpart_dereg_cnt,
 CAST(NULL AS BIGNUMERIC) AS pywpart_tot_reg_cnt,
 pywpart_discount_val,
 load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_mart_lidl_digital.t_agg_rcpt_hdr_ldpl_partial_wk_2 AS RH;