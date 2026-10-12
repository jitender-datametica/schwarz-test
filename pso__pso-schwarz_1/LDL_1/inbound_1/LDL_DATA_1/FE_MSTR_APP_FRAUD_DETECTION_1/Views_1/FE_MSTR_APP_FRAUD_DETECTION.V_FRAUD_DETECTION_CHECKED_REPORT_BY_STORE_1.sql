CREATE OR REPLACE VIEW FE_MSTR_APP_FRAUD_DETECTION.V_FRAUD_DETECTION_CHECKED_REPORT_BY_STORE_1
(
STORE_SID COMMENT 'The unique identifier (surrogate key) for the internal organizatio (store or sales_1 company/VGES)',
REQUEST_TMSP COMMENT 'The point in time when this record requested by the MicroStrategy-User.',
REPORT_ID COMMENT 'The unique identifier of MicroStrategy Report',
REPORT_STATUS_CD COMMENT 'The unique code indicating the status_1 of the checked report (e.g. OPEN, COMMENTED, APPROVED ).',
IS_REP_CHECKED COMMENT 'If there is a comment on report or not',
CHECKED_BY_USER_NAME COMMENT 'The end user, who sets the audit flag',
COMMENT_BY_USER COMMENT 'The comment of the user',
ANALYSIS_PERIOD_START_DT COMMENT 'The begin date of the period which receipts of the internal organization will be analysed',
ANALYSIS_PERIOD_END_DT COMMENT 'The end date of the period which receipts of the internal organization will be analysed',
DWH_CREATED_TMSP COMMENT 'The point in time when this record was created in the data warehouse.',
DWH_UPDATED_TMSP COMMENT 'The point in time when this record was created or last updated.',
DWH_LOAD_ID COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
DWH_NODE_CD COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.')
COMMENT = 'The comments of analysis at store'
AS
SELECT 
org.int_org_sid AS STORE_SID
,ord.request_tmsp
,rep.report_id
,COALESCE(main.report_status_cd,'OP') AS report_status_cd
,DECODE(COALESCE(main.report_status_cd,'OP'),'OP','offen','WO','in Bearbeitung', 'geprüft') AS is_rep_checked
,COALESCE(main.checked_by_user_name,' ') AS checked_by_user_name
,COALESCE(main.comment_by_user, ' ') AS comment_by_user
,ord.analysis_period_start_dt
,ord.analysis_period_end_dt
,COALESCE(main.dwh_created_tmsp,CURRENT_TIMESTAMP()) AS dwh_created_tmsp
,COALESCE(main.dwh_updated_tmsp,CURRENT_TIMESTAMP()) AS dwh_updated_tmsp
,COALESCE(main.dwh_load_id,10) AS dwh_load_id
,COALESCE(main.dwh_node_cd,'MANUAL') AS dwh_node_cd
FROM CORE_DIM.T_DIM_INTERNAL_ORGANIZATION_1 org
INNER JOIN CORE_APP_FRAUD_DETECTION.T_FRAUD_DETECTION_ORDER_1 ord
ON org.int_org_sid = ord.int_org_sid
AND ord.order_parameter_status_cd = 'RV' 
INNER JOIN CORE_APP_FRAUD_DETECTION.T_FRAUD_DETECTION_MSTR_REPORT_1 rep
ON 1 = 1 
LEFT JOIN CORE_APP_FRAUD_DETECTION.T_FRAUD_DETECTION_CHECKED_REPORT_1 main
ON  main.int_org_sid = org.int_org_sid
AND main.report_id = rep.report_id
AND main.request_tmsp = ord.request_tmsp
WHERE org.dwh_valid_fg
AND org.int_org_type_cd = 'STORE';
