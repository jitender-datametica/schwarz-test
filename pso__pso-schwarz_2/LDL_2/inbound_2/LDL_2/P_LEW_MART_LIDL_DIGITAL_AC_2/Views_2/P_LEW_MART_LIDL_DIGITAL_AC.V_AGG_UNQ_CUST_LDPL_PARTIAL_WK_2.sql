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
#  1.6 2020-11-24 Pawel Wieczork          20201117_2664_harmo_cal SD-1544
#                                         Drop columns
#                                               cwpart_tot_gros_val
#                                               cwpart_tot_net_val
#                                               cwpart_trans_time_in_mins
#                                               cwpart_items_scanned_cnt
#                                               pywpart_tot_gros_val
#                                               pywpart_tot_net_val
#                                               pywpart_trans_time_in_mins
#                                               pywpart_items_scanned_cnt
#  1.7 2022-04-04 Pawel Wieczorek         AP0092849 disable column customer_segment_cd and set it as NULL, add comments, remove org_lvl_id, tm_lvl_id
#----------------------------------------------------------------------------
*/



/* ==============================================================================
   Object DDL
   ============================================================================== */

CREATE OR REPLACE VIEW P_LEW_MART_LIDL_DIGITAL_AC.v_agg_unq_cust_ldpl_partial_wk_2
COMMENT = 'View for Unique customer on Partial Week level'
(
  aspect_id                  COMMENT 'Gesellschaftsform (1 = Betriebs- 2 = Vertriebsgesellschaft)'
, client_id                  COMMENT 'Identifier for client'
, cy_week                    COMMENT 'Week number'
, cy_week_part               COMMENT 'Part of the week, in non transit week: value 1, in transit week: in the first part of week - value 1, in the second part of week - value 2 '
, cy_week_partial_week_id    COMMENT 'Partial week unique id: cy_week || cy_week_part '
, cy_partial_week_name       COMMENT 'Partial week name'
, move_to_store_id           COMMENT 'Store ID' 
, wh_id                      COMMENT 'Warehouse ID' 
, customer_sid               COMMENT 'Surrogate Key CUSTOMER'
, lidlplus_cust_fg           COMMENT 'Lidplus customer flag' 
, currency_iso_cd            COMMENT 'ISO code for the currency of the client.'
, curr_tot_id                COMMENT 'Fixe Werte fur EUR=0, GBP=40 sonst Client_Id'              
, cwpart_cust_act            COMMENT 'Previous Year Partial Week Customer Active flag 1 for active 0 for not active'
, pywpart_cust_act           COMMENT 'Previous Year Partial Week Customer Active flag 1 for active 0 for not active'
, cwpart_wk_str_open_fg      COMMENT 'Store open flag : Current Partial week'
, cwpart_rcpts_cnt           COMMENT 'Receipts count : Current Partial week'
, cwpart_new_reg_cnt         COMMENT 'Null measure' 
, cwpart_dereg_cnt           COMMENT 'Null measure' 
, pywpart_wk_str_open_fg     COMMENT 'Store open flag : Previous year partial week'
, pywpart_rcpts_cnt          COMMENT 'Receipts count : Previous year partial week'
, pywpart_new_reg_cnt        COMMENT 'Null measure' 
, pywpart_dereg_cnt          COMMENT 'Null measure'
, load_id                    COMMENT 'Load identifier' 
, dwh_created                COMMENT 'Row create time' 
, dwh_updated                COMMENT 'Row update time'  
)
AS 
SELECT
  aspect_id
, client_id
, cy_week
, cy_week_part
, cy_week_partial_week_id
, cy_partial_week_name
, move_to_store_id
, wh_id
, customer_sid
, lidlplus_cust_fg
, currency_iso_cd
, curr_tot_id
, cwpart_cust_act
, pywpart_cust_act
, cwpart_wk_str_open_fg
, cwpart_rcpts_cnt
, cwpart_new_reg_cnt
, cwpart_dereg_cnt
, pywpart_wk_str_open_fg
, pywpart_rcpts_cnt
, pywpart_new_reg_cnt
, pywpart_dereg_cnt
, load_id
, dwh_created
, dwh_updated
FROM P_LEW_MART_LIDL_DIGITAL.v_agg_unq_cust_ldpl_partial_wk_2
;
