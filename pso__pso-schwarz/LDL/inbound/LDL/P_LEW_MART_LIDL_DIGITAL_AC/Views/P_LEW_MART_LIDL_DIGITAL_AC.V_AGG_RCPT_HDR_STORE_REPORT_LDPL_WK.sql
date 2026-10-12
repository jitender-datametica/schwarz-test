/*
#----------------------------------------------------------------------------
# History:
#
#  Vrs Date       Developer               Task
#  --- ---------- ----------------------- -----------------------------------
#  1.0 2024-01-04 Marcin Kikola           AP0150474 Article Hierarchy Initial version
*/

CREATE OR REPLACE VIEW P_LEW_MART_LIDL_DIGITAL_AC.V_AGG_RCPT_HDR_STORE_REPORT_LDPL_WK
COMMENT = 'Lidlplus : View with aggregations at wh_id and client_id used for Store Report in FE'
(
   currency_iso_cd COMMENT 'ISO code for the currency of the client'
 , curr_tot_id COMMENT 'Fixe Werte fur EUR=0 GBP=40 sonst Client_Id'
 , client_id COMMENT 'Identifier for client'
 , wh_id COMMENT 'Warehouse ID'
 , move_to_store_id COMMENT 'Filialnummer nach letztem Filialumzug'
 , aspect_id COMMENT 'Gesellschaftsform (1 = Betriebs- 2 = Vertriebsgesellschaft)'
 , cy_week COMMENT 'Week number'
 , cy_week_prev_1w COMMENT 'Next Week number'
 , store_tot_net_val COMMENT 'Total net value : Current week'
 , store_lp_net_val COMMENT 'LidlPlus net value : Current week'
 , store_non_lp_net_val COMMENT 'Non-LidlPlus net value : Current week'
 , wh_tot_net_val COMMENT 'Total net value at wh_id level : Current week'
 , wh_lp_net_val COMMENT 'LidlPlus net value at wh_id level: Current week'
 , client_tot_net_val COMMENT 'Total net value at client_id level : Current week'
 , client_lp_net_val COMMENT 'LidlPlus net value at client_id level: Current week'
 , store_tot_rcpt COMMENT 'Number of LidlPlus receipts : Current week'
 , store_lp_rcpt COMMENT 'Number of total receipts : Current week'
 , store_non_lp_rcpt COMMENT 'Number of non-LidlPlus receipts : Current week'
 , wh_tot_rcpt COMMENT 'Number of LidlPlus receipts at wh_id level: Current week'
 , wh_lp_rcpt COMMENT 'Number of total receipts at wh_id level: Current week'
 , client_tot_rcpt COMMENT 'Number of LidlPlus receipts at client_id level: Current week'
 , client_lp_rcpt COMMENT 'Number of total receipts at client_id level: Current week'
 , count_customer_sid COMMENT 'distinct coutn of customer sid'
 )
 AS
 SELECT 
   currency_iso_cd
 , curr_tot_id
 , client_id
 , wh_id
 , move_to_store_id
 , aspect_id
 , cy_week
 , cy_week_prev_1w
 , store_tot_net_val
 , store_lp_net_val
 , store_non_lp_net_val
 , wh_tot_net_val
 , wh_lp_net_val
 , client_tot_net_val
 , client_lp_net_val
 , store_tot_rcpt
 , store_lp_rcpt
 , store_non_lp_rcpt
 , wh_tot_rcpt
 , wh_lp_rcpt
 , client_tot_rcpt
 , client_lp_rcpt
 , count_customer_sid
 FROM P_LEW_MART_LIDL_DIGITAL.V_AGG_RCPT_HDR_STORE_REPORT_LDPL_WK
 ;