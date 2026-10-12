create or replace TABLE BIAID_TOOLS_PROJECTS_PRODUCTION.DATA.T_IAM_AZURE_PROJECT_TRACKING_2 (
	PROJECT_ID VARCHAR(20) NOT NULL,
	PROJECT_SHORT_NAME VARCHAR(100) NOT NULL,
	TENANT VARCHAR(20),
	SECURE_LEVEL VARCHAR(10),
	CONTACT_NAME VARCHAR(100),
	CONTACT_PHONE VARCHAR(100),
	CONTACT_EMAIL VARCHAR(100),
	SOLUTION_ID VARCHAR(100),
	PSP_ELEMENT_2 VARCHAR(100),
	LOAD_CREATED TIMESTAMP_NTZ(9),
	LOAD_UPDATED TIMESTAMP_NTZ(9)
)COMMENT='Table belongs to Project inf_azure_management for Kostenreporting. Project related data (contact_2 details of main person responsible, datastore used, ids of tracking systems) Contact_2: pavan.chandregowda@mail.schwarz or someone else from data platform team'
;