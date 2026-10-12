create or replace TABLE BIAID_TOOLS_PROJECTS_PRODUCTION.ETL_PROCESS.T_IAM_CC_LOG_2 (
	LOAD_TIMESTAMP TIMESTAMP_NTZ(6),
	ENVIRONMENT VARCHAR(2000),
	CONTENT_DATE TIMESTAMP_NTZ(6),
	STATUS_2 VARCHAR(2000)
)COMMENT='Table belongs to Project inf_azure_management for Kostenreporting. Keeps log of each CC extract and helps checking how fresh data is. Contact_2: pavan.chandregowda@mail.schwarz or someone else from data platform team'
;