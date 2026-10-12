/*
#----------------------------------------------------------------------------
# History:
#
#  Vrs Date       Developer               Task
#  --- ---------- ----------------------- -----------------------------------
#  1.0 2024-01-04 Marcin Kikola           AP0150474 Article Hierarchy Initial version
*/


CREATE OR REPLACE VIEW ldl_p_lew_mart_lidl_digital_ac.v_agg_rcpt_hdr_store_report_ldpl_wk (currency_iso_cd
OPTIONS(description='ISO code for the currency of the client'), curr_tot_id
OPTIONS(description='Fixe Werte fur EUR=0 GBP=40 sonst Client_Id'), client_id
OPTIONS(description='Identifier for client'), wh_id OPTIONS(description='Warehouse ID'), move_to_store_id
OPTIONS(description='Filialnummer nach letztem Filialumzug'), aspect_id
OPTIONS(description='Gesellschaftsform (1 = Betriebs- 2 = Vertriebsgesellschaft)'), cy_week
OPTIONS(description='Week number'), cy_week_prev_1w OPTIONS(description='Next Week number'), store_tot_net_val
OPTIONS(description='Total net value : Current week'), store_lp_net_val
OPTIONS(description='LidlPlus net value : Current week'), store_non_lp_net_val
OPTIONS(description='Non-LidlPlus net value : Current week'), wh_tot_net_val
OPTIONS(description='Total net value at wh_id level : Current week'), wh_lp_net_val
OPTIONS(description='LidlPlus net value at wh_id level: Current week'), client_tot_net_val
OPTIONS(description='Total net value at client_id level : Current week'), client_lp_net_val
OPTIONS(description='LidlPlus net value at client_id level: Current week'), store_tot_rcpt
OPTIONS(description='Number of LidlPlus receipts : Current week'), store_lp_rcpt
OPTIONS(description='Number of total receipts : Current week'), store_non_lp_rcpt
OPTIONS(description='Number of non-LidlPlus receipts : Current week'), wh_tot_rcpt
OPTIONS(description='Number of LidlPlus receipts at wh_id level: Current week'), wh_lp_rcpt
OPTIONS(description='Number of total receipts at wh_id level: Current week'), client_tot_rcpt
OPTIONS(description='Number of LidlPlus receipts at client_id level: Current week'), client_lp_rcpt
OPTIONS(description='Number of total receipts at client_id level: Current week'), count_customer_sid
OPTIONS(description='distinct coutn of customer sid'))
OPTIONS(DESCRIPTION = `LIDLPLUS : VIEW WITH AGGREGATIONS AT WH_ID AND CLIENT_ID USED FOR STORE REPORT IN FE`) AS SELECT
 *
FROM ldl_p_lew_mart_lidl_digital.v_agg_rcpt_hdr_store_report_ldpl_wk;