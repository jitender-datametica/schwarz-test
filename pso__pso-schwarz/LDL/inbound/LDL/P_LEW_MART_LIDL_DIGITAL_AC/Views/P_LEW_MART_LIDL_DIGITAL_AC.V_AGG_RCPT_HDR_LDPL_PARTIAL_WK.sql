/*
#-----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: 20180801_1778_LidlPlus_KPIs
#            1:1 DDL
#----------------------------------------------------------------------------

#----------------------------------------------------------------------------





#----------------------------------------------------------------------------

#----------------------------------------------------------------------------
# History:
#
#  Vrs Date       Developer               Task
#  --- ---------- ----------------------- --------------------------------
#  1.0 2020-04-14 Barbara Seneta          Initial version
#                                         20200408_2447_Customer_Segment_Fact
#  1.1 2020-05-06 Barbara Seneta          Added column wh_id (it does not change granularity of the view)
#                                         20200408_2447_Customer_Segment_Facts
#  1.2 2022-04-04 Pawel Wieczorek         AP0092849 disable column customer_segment_cd and set it as NULL, add comments, remove org_lvl_id, tm_lvl_id
#----------------------------------------------------------------------------
*/



/* ==============================================================================
   Object DDL
   ============================================================================== */

CREATE OR REPLACE VIEW P_LEW_MART_LIDL_DIGITAL_AC.v_agg_rcpt_hdr_ldpl_partial_wk
COMMENT = 'Lidlplus : Receipt header aggregated to partial week level'
(
  aspect_id                  COMMENT 'Gesellschaftsform (1 = Betriebs- 2 = Vertriebsgesellschaft)'
, client_id                  COMMENT 'Identifier for client'
, move_to_store_id           COMMENT 'Store ID'
, wh_id                      COMMENT 'Warehouse ID'
, lidlplus_cust_fg           COMMENT 'Lidplus customer flag' 
, cy_week                    COMMENT 'Week number'
, cy_week_part               COMMENT 'Part of the week, in non transit week: value 1, in transit week: in the first part of week - value 1, in the second part of week - value 2 '
, cy_week_partial_week_id    COMMENT 'Partial week unique id: cy_week || cy_week_part '
, cy_partial_week_name       COMMENT 'Partial week name'
, currency_iso_cd            COMMENT 'ISO code for the currency of the client.'
, curr_tot_id                COMMENT 'Fixe Werte fur EUR=0, GBP=40 sonst Client_Id'
, cwpart_wk_str_open_fg      COMMENT 'Store open flag : Current Partial week'
, cwpart_tot_gros_val        COMMENT 'Total gross value : Current Partial week'
, cwpart_tot_net_val         COMMENT 'Total net value : Current Partial week'
, cwpart_rcpts_cnt           COMMENT 'Receipts count : Current Partial week'
, cwpart_tot_rcpt_cnt_wk     COMMENT 'Total receipts count : Current Partial week'
, cwpart_trans_time_in_mins  COMMENT 'Transaction time measured in minutes : Current Partial week'
, cwpart_items_scanned_cnt   COMMENT 'Number of items scanned : Current Partial week'
, cwpart_new_reg_cnt         COMMENT 'Null measure'
, cwpart_dereg_cnt           COMMENT 'Null measure'
, cwpart_tot_reg_cnt         COMMENT 'Null measure'
, cwpart_discount_val        COMMENT 'Discount value : Current Partial week'
, pywpart_wk_str_open_fg     COMMENT 'Store open flag : Previous year partial week'                       
, pywpart_tot_gros_val       COMMENT 'Total gross value : Previous year partial week'                     
, pywpart_tot_net_val        COMMENT 'Total net value : Previous year partial week'                       
, pywpart_rcpts_cnt          COMMENT 'Receipts count : Previous year partial week'                        
, pywpart_tot_rcpt_cnt_wk    COMMENT 'Total receipts count : Previous year partial week'                  
, pywpart_trans_time_in_mins COMMENT 'Transaction time measured in minutes : Previous year partial week'  
, pywpart_items_scanned_cnt  COMMENT 'Number of items scanned : Previous year partial week'               
, pywpart_new_reg_cnt        COMMENT 'Null measure'                                                 
, pywpart_dereg_cnt          COMMENT 'Null measure'                                                 
, pywpart_tot_reg_cnt        COMMENT 'Null measure'                                                 
, pywpart_discount_val       COMMENT 'Discount value : Previous year partial week'                        
, load_id                    COMMENT 'Load identifier' 
, dwh_created                COMMENT 'Row create time' 
, dwh_updated                COMMENT 'Row update time' 
)
AS 
SELECT
  aspect_id
, client_id
, move_to_store_id
, wh_id
, lidlplus_cust_fg
, cy_week
, cy_week_part
, cy_week_partial_week_id
, cy_partial_week_name
, currency_iso_cd
, curr_tot_id
, cwpart_wk_str_open_fg
, cwpart_tot_gros_val
, cwpart_tot_net_val
, cwpart_rcpts_cnt
, cwpart_tot_rcpt_cnt_wk
, cwpart_trans_time_in_mins
, cwpart_items_scanned_cnt
, cwpart_new_reg_cnt
, cwpart_dereg_cnt
, cwpart_tot_reg_cnt
, cwpart_discount_val
, pywpart_wk_str_open_fg
, pywpart_tot_gros_val
, pywpart_tot_net_val
, pywpart_rcpts_cnt
, pywpart_tot_rcpt_cnt_wk
, pywpart_trans_time_in_mins
, pywpart_items_scanned_cnt
, pywpart_new_reg_cnt
, pywpart_dereg_cnt
, pywpart_tot_reg_cnt
, pywpart_discount_val
, load_id
, dwh_created
, dwh_updated
FROM P_LEW_MART_LIDL_DIGITAL.v_agg_rcpt_hdr_ldpl_partial_wk
;
