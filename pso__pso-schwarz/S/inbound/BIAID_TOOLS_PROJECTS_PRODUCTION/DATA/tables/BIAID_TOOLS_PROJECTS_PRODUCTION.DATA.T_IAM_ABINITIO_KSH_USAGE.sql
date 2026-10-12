create or replace TABLE BIAID_TOOLS_PROJECTS_PRODUCTION.DATA.T_IAM_ABINITIO_KSH_USAGE (
	HOST VARCHAR(100),
	SYSTEM VARCHAR(30) NOT NULL,
	APPLICATION VARCHAR(100) NOT NULL,
	ALERT_TEAM_ID VARCHAR(30),
	SOLUTION_ID VARCHAR(100),
	SOLUTION_NAME VARCHAR(300),
	EXECUTABLE_ENUM VARCHAR(100) NOT NULL,
	JOB_DEFINITION VARCHAR(300) NOT NULL,
	COLLECTION_DAY DATE,
	KSH NUMBER(38,10),
	DWH_CREATED TIMESTAMP_NTZ(9) NOT NULL
)COMMENT='Table belongs to Project inf_azure_management for Kostenreporting. Ab Initio usage information (cpu usage interpreted in context of key server info) Contact: pavan.chandregowda@mail.schwarz or someone else from data platform team'
;