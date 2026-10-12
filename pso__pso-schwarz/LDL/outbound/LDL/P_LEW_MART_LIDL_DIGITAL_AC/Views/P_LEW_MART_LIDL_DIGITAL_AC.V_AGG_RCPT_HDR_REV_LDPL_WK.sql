/*
 * History:
 * 
 * 1.0 2022-01-31 Marcin Kikola         #276052 Initial versions
 * 
 */


CREATE OR REPLACE VIEW ldl_p_lew_mart_lidl_digital_ac.v_agg_rcpt_hdr_rev_ldpl_wk (currency_iso_cd
OPTIONS(description='ISO code for the currency of the client'), curr_tot_id
OPTIONS(description='Fixe Werte fur EUR=0 GBP=40 sonst Client_Id'), client_id
OPTIONS(description='Identifier for client'), wh_id OPTIONS(description='Warehouse ID'), move_to_store_id
OPTIONS(description='Filialnummer nach letztem Filialumzug'), aspect_id
OPTIONS(description='Gesellschaftsform (1 = Betriebs- 2 = Vertriebsgesellschaft)'), cy_week
OPTIONS(description='Week number'), tot_net_val OPTIONS(description='Total net value : Current week'), lp_net_val
OPTIONS(description='LidlPlus net value : Current week'), wh_tot_net_val
OPTIONS(description='Total net value at wh_id level : Current week'), wh_lp_net_val
OPTIONS(description='LidlPlus net value at wh_id level: Current week'), client_tot_net_val
OPTIONS(description='Total net value at client_id level : Current week'), client_lp_net_val
OPTIONS(description='LidlPlus net value at client_id level: Current week'))
OPTIONS(DESCRIPTION = `LIDLPLUS : VIEW WITH AGGREGATIONS AT LEVELS OF WH_ID AND CLIENT_ID USED FOR STORE REPORT IN FE`)
AS SELECT *
FROM ldl_p_lew_mart_lidl_digital.v_agg_rcpt_hdr_rev_ldpl_wk;