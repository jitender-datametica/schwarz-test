/*
 #----------------------------------------------------------------------------
 # @ LIDL Stiftung & Co. KG - DWH / MIS
 #----------------------------------------------------------------------------
 # Interface: DDL for P_LEW_MART_MSI_AC.V_CUSTOMER_COMPLAINT_CASE
 #----------------------------------------------------------------------------
 # History:
 #  1.0  02.11.2022    Kitschke,Felix           Initial Version; AP0140749 CC-Dossier Views
 #----------------------------------------------------------------------------
 */

CREATE OR REPLACE VIEW P_LEW_MART_MSI_AC.V_CUSTOMER_COMPLAINT_CASE AS
SELECT
	client_id
	,cust_complaint_sid
	,src_cust_complaint_nr
	,cust_complaint_nr
	,case_open_dt
	,src_name
	,dwh_load_id
	,dwh_created
	,dwh_updated
FROM
	P_LEW_MART_MSI.V_CUSTOMER_COMPLAINT_CASE;