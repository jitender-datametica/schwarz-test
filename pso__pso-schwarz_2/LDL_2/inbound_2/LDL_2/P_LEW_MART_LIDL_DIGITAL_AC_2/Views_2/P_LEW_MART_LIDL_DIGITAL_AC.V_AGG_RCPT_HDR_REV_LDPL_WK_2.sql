/*
 * History:
 * 
 * 1.0 2022-01-31 Marcin Kikola         #276052 Initial versions
 * 
 */



CREATE OR REPLACE VIEW P_LEW_MART_LIDL_DIGITAL_AC.V_AGG_RCPT_HDR_REV_LDPL_WK_2
COMMENT = 'Lidlplus : View with aggregations at levels of wh_id and client_id used for Store Report in FE'
(
   currency_iso_cd COMMENT 'ISO code for the currency of the client'
 , curr_tot_id COMMENT 'Fixe Werte fur EUR=0 GBP=40 sonst Client_Id'
 , client_id COMMENT 'Identifier for client'
 , wh_id COMMENT 'Warehouse ID'
 , move_to_store_id COMMENT 'Filialnummer nach letztem Filialumzug'
 , aspect_id COMMENT 'Gesellschaftsform (1 = Betriebs- 2 = Vertriebsgesellschaft)'
 , cy_week COMMENT 'Week number'
 , tot_net_val COMMENT 'Total net value : Current week'
 , lp_net_val COMMENT 'LidlPlus net value : Current week'
 , wh_tot_net_val COMMENT 'Total net value at wh_id level : Current week'
 , wh_lp_net_val COMMENT 'LidlPlus net value at wh_id level: Current week'
 , client_tot_net_val COMMENT 'Total net value at client_id level : Current week'
 , client_lp_net_val COMMENT 'LidlPlus net value at client_id level: Current week'
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
 , tot_net_val
 , lp_net_val
 , wh_tot_net_val
 , wh_lp_net_val
 , client_tot_net_val
 , client_lp_net_val 
 FROM P_LEW_MART_LIDL_DIGITAL.V_AGG_RCPT_HDR_REV_LDPL_WK_2
;
