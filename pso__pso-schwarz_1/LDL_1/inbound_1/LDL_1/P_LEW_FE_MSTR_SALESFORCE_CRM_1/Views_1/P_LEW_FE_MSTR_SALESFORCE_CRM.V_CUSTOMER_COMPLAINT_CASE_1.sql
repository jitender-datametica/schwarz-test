CREATE OR REPLACE VIEW P_LEW_FE_MSTR_SALESFORCE_CRM.V_CUSTOMER_COMPLAINT_CASE_1
(
	CLIENT_ID
	, CUST_COMPLAINT_SID
	, SRC_CUST_COMPLAINT_NR
	, CUST_COMPLAINT_NR
	, CASE_OPEN_DT
	, SRC_NAME
	, DWH_LOAD_ID
	, DWH_CREATED
	, DWH_UPDATED
) 
AS  
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
FROM P_LEW_CORE_AC.V_CUSTOMER_COMPLAINT_CASE_1;