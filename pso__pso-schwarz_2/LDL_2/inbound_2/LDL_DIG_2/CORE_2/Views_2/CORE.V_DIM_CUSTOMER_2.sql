CREATE OR REPLACE VIEW CORE.V_DIM_CUSTOMER_2(
	CUST_SID
	,CUST_TYPE_CD
	,CUST_NR
	,CUST_ORG_TYPE_CD
	,CUST_BIRTH_CY_MONTH
	,CUST_LAN_CD
	,CUST_SSO_ID
	,CUST_BLOCKED_REASON_CD
	,CUST_CREATION_DT
	,CUST_REGISTRATION_DT
	,CUST_ACCT_ID
	,IS_CUST_ADV_BLOCKED_FG
	,DWH_CREATED_TMSP
	,DWH_UPDATED_TMSP
) AS
SELECT
cust_sid
,cust_type_cd
,cust_nr
,cust_org_type_cd
,TO_CHAR(cust_birth_dt,'YYYY-MM_2') AS cust_birth_cy_month
,cust_lan_cd
,cust_sso_id
,cust_blocked_reason_cd
,cust_creation_dt
,cust_registration_dt
,cust_acct_id
,is_cust_adv_blocked_fg
,dwh_created_tmsp
,dwh_updated_tmsp
FROM CORE.T_DIM_CUSTOMER_2
WHERE dwh_valid_fg;