CREATE TABLE p_lew_core.t_customer_complaint_case_1 (
	CLIENT_ID NUMBER(38,0) NOT NULL COMMENT 'DWH-Mandant_1; FK auf CLIENT',
	CUST_COMPLAINT_SID NUMBER(38,0) NOT NULL COMMENT 'Surrogate Key for customer compaint case',
	SRC_CUST_COMPLAINT_NR VARCHAR(250) NOT NULL COMMENT 'The unique key generated in Salesforce if a case is added to the SF database.',
	CUST_COMPLAINT_NR NUMBER(38,0) COMMENT 'Customer compaint case number as shown to user',
	CASE_OPEN_DT DATE COMMENT 'The first time an agent accepts the case and starts working on it. in UTC Time.',
	SRC_NAME VARCHAR(100) COMMENT 'Source System Name (Salesforce or BSI )',
	DWH_LOAD_ID NUMBER(38,0) NOT NULL,
	DWH_CREATED TIMESTAMP_NTZ(9) NOT NULL,
	DWH_UPDATED TIMESTAMP_NTZ(9) NOT NULL,
	CONSTRAINT PK_T_CUSTOMER_COMPLAINT_CASE PRIMARY KEY (CUST_COMPLAINT_SID)
)COMMENT='The table contais customer complait cases opened in Salesforce or BSI systems as a result of a customer reporting issues via mail , web-form or phone'
;