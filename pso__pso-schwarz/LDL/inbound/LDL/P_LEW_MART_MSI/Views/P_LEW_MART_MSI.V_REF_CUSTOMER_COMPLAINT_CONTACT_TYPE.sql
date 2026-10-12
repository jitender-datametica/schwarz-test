/*
 #----------------------------------------------------------------------------
 # @ LIDL Stiftung & Co. KG - DWH / MIS
 #----------------------------------------------------------------------------
 # Interface: DDL for P_LEW_MART_MSI.V_REF_CUSTOMER_COMPLAINT_CONTACT_TYPE
 #----------------------------------------------------------------------------
 # History:
 #  1.0  02.11.2022    Kitschke,Felix           Initial Version; AP0140749 CC-Dossier Views
 #----------------------------------------------------------------------------
 */

CREATE OR REPLACE VIEW P_LEW_MART_MSI.V_REF_CUSTOMER_COMPLAINT_CONTACT_TYPE AS
SELECT
	cust_complaint_contact_type_cd
	,cust_complaint_contact_type_desc
	,dwh_load_id
	,dwh_created
	,dwh_updated
FROM
	P_LEW_CORE_AC.V_REF_CUSTOMER_COMPLAINT_CONTACT_TYPE;