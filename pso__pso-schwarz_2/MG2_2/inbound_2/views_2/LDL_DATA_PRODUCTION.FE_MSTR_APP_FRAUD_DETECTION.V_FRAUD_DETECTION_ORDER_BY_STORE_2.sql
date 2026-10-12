create or replace view LDL_DATA_PRODUCTION.FE_MSTR_APP_FRAUD_DETECTION.V_FRAUD_DETECTION_ORDER_BY_STORE_2(
	STORE_SID COMMENT 'The unique identifier (surrogate key) for the internal organization.',
	COUNTRY_ORG_CD COMMENT 'The code of the business country_2 for which this country_2 organization is responsible. (The business country_2 is not identical to a political country.)',
	INT_ORG_NR COMMENT 'The number which identifies the sales_2 company (VGES) /Store to which this store is related.',
	INT_ORG_TYPE_CD COMMENT 'The code identifying the discriminators for internal organizations.',
	REQUESTOR_USER_NAME COMMENT 'The MicroStrategy-User who requests fraud detection analysis for organization unit_2 in ZKP-Solution',
	REQUEST_TMSP COMMENT 'The point in time when this record requested by the MicroStrategy-User.',
	APPROVER_USER_NAME COMMENT 'The MicroStrategy-User who approves the fraud detection analysis for organization unit_2 in ZKP-Solution',
	APPROVED_TMSP COMMENT 'The point in time when this record approved by the MicroStrategy-User.',
	ANALYSIS_PERIOD_START_DT COMMENT 'The begin date of the period which receipts of the internal organization will be analysed',
	ANALYSIS_PERIOD_END_DT COMMENT 'The end date of the period which receipts of the internal organization will be analysed',
	ORDER_PARAMETER_STATUS_CD COMMENT 'The status_2 of a order parameter if it is approved, requested or denied.',
	ORDER_REASON_CD COMMENT 'The revision reason code for an analysis, if it is for threshold definition or fraud analysis',
	AUDIT_USER_NAME COMMENT 'The MicroStrategy-User who prooves and start the audit.',
	AUDIT_TMSP COMMENT 'The point in time when this record approved by the MicroStrategy-User or the audit got started from the MicroStrategy-User ',
	CANCEL_SCENARIO_GRP_FG COMMENT 'An indicator showing the analysis should proove the cancel scenarios group.',
	DEPOSIT_SCENARIO_GRP_FG COMMENT 'An indicator showing the analysis should proove the deposit scenarios group',
	RETURN_SCENARIO_GRP_FG COMMENT 'An indicator showing the analysis should proove the return scenario group',
	ABORT_SCENARIO_GRP_SUSPEND_FG COMMENT 'An indicator showing the analysis should proove the abourt/suspend scenario group',
	DISCOUNT_SCENARIO_GRP_FG COMMENT 'An indicator showing the analysis should proove the discount scenario group',
	OTHER_SCENARIO_GRP_FG COMMENT 'xxx_2 An indicator showing the analysis should proove the other scenario group',
	TEST_FG COMMENT 'An indicator showing the analysis is a test_2 case',
	DWH_CREATED_TMSP COMMENT 'The point in time when this record was created in the data warehouse.',
	DWH_UPDATED_TMSP COMMENT 'The point in time when this record was created or last updated.',
	DWH_LOAD_ID COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
	DWH_NODE_CD COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.'
) COMMENT='The current entries for the stores'
 as SELECT
main.int_org_sid AS store_sid
,main.country_org_cd AS country_org_cd
,main.int_org_nr AS int_org_nr
,main.int_org_type_cd AS int_org_type_cd
,main.requestor_user_name AS requestor_user_name
,main.request_tmsp AS request_tmsp
,main.approver_user_name AS approver_user_name
,main.approved_tmsp AS approved_tmsp
,main.analysis_period_start_dt AS analysis_period_start_dt
,main.analysis_period_end_dt AS analysis_period_end_dt
,main.order_parameter_status_cd AS order_parameter_status_cd
,main.order_reason_cd AS order_reason_cd
,main.audit_user_name AS audit_user_name
,main.audit_tmsp AS audit_tmsp
,main.cancel_scenario_grp_fg AS cancel_scenario_grp_fg
,main.deposit_scenario_grp_fg AS deposit_scenario_grp_fg
,main.return_scenario_grp_fg AS return_scenario_grp_fg
,main.abort_scenario_grp_suspend_fg AS abort_scenario_grp_suspend_fg
,main.discount_scenario_grp_fg AS discount_scenario_grp_fg
,main.other_scenario_grp_fg AS other_scenario_grp_fg
,main.test_fg AS test_fg
,main.dwh_created_tmsp AS dwh_created_tmsp
,main.dwh_updated_tmsp AS dwh_updated_tmsp
,main.dwh_load_id AS dwh_load_id
,main.dwh_node_cd AS dwh_node_cd
FROM CORE_APP_FRAUD_DETECTION.T_FRAUD_DETECTION_ORDER_2 main
WHERE main.int_org_type_cd = 'STORE' ;