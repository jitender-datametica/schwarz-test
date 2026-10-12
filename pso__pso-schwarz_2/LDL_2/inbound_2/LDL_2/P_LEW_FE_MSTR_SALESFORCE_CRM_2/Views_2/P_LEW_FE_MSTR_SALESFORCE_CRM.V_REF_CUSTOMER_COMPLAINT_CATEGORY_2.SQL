CREATE OR REPLACE VIEW P_LEW_FE_MSTR_SALESFORCE_CRM.V_REF_CUSTOMER_COMPLAINT_CATEGORY_2
(
	CLIENT_ID
	, CUST_COMPLAINT_CAT_SID
	, CUST_COMPLAINT_SRV_CENTER_CD
	, SRC_CUST_COMPLAINT_CAT_NR
	, CUST_COMPLAINT_CAT_NR
	, CUST_COMPLAINT_CAT_NAME
	, SRC_NAME
	, DWH_LOAD_ID
	, DWH_CREATED
	, DWH_UPDATED
) 
AS 
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
FROM P_LEW_CORE_AC.V_REF_CUSTOMER_COMPLAINT_CATEGORY_2;