/*
 #----------------------------------------------------------------------------
 # @ LIDL Stiftung & Co. KG - DWH / MIS
 #----------------------------------------------------------------------------
 # Interface: DDL for P_LEW_MART_MSI_AC.V_REF_CUSTOMER_COMPLAINT_CATEGORY_2
 #----------------------------------------------------------------------------
 # History:
 #  1.0  02.11.2022    Kitschke,Felix           Initial Version; AP0140749 CC-Dossier Views
 #----------------------------------------------------------------------------
 */

CREATE OR REPLACE VIEW P_LEW_MART_MSI_AC.V_REF_CUSTOMER_COMPLAINT_CATEGORY_2 AS
SELECT
	client_id
	,cust_complaint_cat_sid
	,cust_complaint_srv_center_cd
	,src_cust_complaint_cat_nr
	,cust_complaint_cat_nr
	,cust_complaint_cat_name
	,src_name
	,dwh_load_id
	,dwh_created
	,dwh_updated
FROM
	P_LEW_MART_MSI.V_REF_CUSTOMER_COMPLAINT_CATEGORY_2;