/*
 #----------------------------------------------------------------------------
 # @ LIDL Stiftung & Co. KG - DWH / MIS
 #----------------------------------------------------------------------------
 # Interface: DDL for P_LEW_MART_MSI_AC.V_REF_CUSTOMER_COMPLAINT_SALES_CHANNEL
 #----------------------------------------------------------------------------
 # History:
 #  1.0  02.11.2022    Kitschke,Felix           Initial Version; AP0140749 CC-Dossier Views
 #----------------------------------------------------------------------------
 */

CREATE OR REPLACE VIEW P_LEW_MART_MSI_AC.V_REF_CUSTOMER_COMPLAINT_SALES_CHANNEL AS
SELECT
	cust_complaint_sales_channel_cd
	,cust_complaint_sales_channel_desc
	,dwh_load_id
	,dwh_created
	,dwh_updated
FROM
	P_LEW_MART_MSI.V_REF_CUSTOMER_COMPLAINT_SALES_CHANNEL;