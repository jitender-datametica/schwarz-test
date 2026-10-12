/*
#-------------------------------------------------------------------------------
# © LIDL Stiftung & Co. KG
#-------------------------------------------------------------------------------
# Interface : DDL for V_AGG_STORE_HOUR_SALES_CNT_BGES
#-------------------------------------------------------------------------------
# Description:  This view provides aggregated Bon Totals and Umsatz with 
#               the granularity of client/store/day/hour.
#               The aspect_id is fixed to 1 (BGES)
#-------------------------------------------------------------------------------
# Encoding. UTF8noBom
#-------------------------------------------------------------------------------
# History:
#  1.0  2023-02-16 K Lukaszewska      Initial Version
#  1.1	2023-03-07 M Rek				 Performance oriented re-design
#  1.2  2023-04-03 Prasanna Ranjan	 Re-Desing to access table
#-------------------------------------------------------------------------------
*/

CREATE OR REPLACE VIEW P_LEW_MART_LEAD_AC.V_AGG_STORE_HOUR_SALES_CNT_BGES(
	CLIENT_ID COMMENT 'MIS Client ID',
	MOVE_TO_STORE_ID COMMENT 'S-Key Location, here - der Filiale',
	DAT_FORMDATE COMMENT 'Reference date',
	TIME_HOUR_ID COMMENT 'Stunde ID: 01 - 24',
	LAST_12_CY_WEEK_FG COMMENT	'Flag indicating if in last 12 weeks',
	CNT_CUSTOMER_ASIS COMMENT 'Number of receipts'
) COMMENT= 'Dynamic view for number of receipts and Umsatz EJR with half-hourly granularity'
 AS
SELECT DISTINCT 
		 client_id
       , move_to_store_id
       , dat_formdate                           																													
       , time_hour_id
	   , last_12_cy_week_fg
	   , cnt_customer_asis										
  FROM P_LEW_MART_LEAD.T_AGG_STORE_HOUR_SALES_CNT_BGES;