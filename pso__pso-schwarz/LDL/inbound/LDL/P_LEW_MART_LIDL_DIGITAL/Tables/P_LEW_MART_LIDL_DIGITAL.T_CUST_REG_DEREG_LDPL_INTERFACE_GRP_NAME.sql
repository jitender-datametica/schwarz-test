create or replace TABLE LDL_PRODUCTION_CLONE_GOOGLE_20260608_1030.P_LEW_MART_LIDL_DIGITAL.T_CUST_REG_DEREG_LDPL_INTERFACE_GRP_NAME (
	REG_INTERFACE_GRP_ID NUMBER(38,0) NOT NULL COMMENT 'ID of the registration interface group through which the user registered or reregistered for the geographical area in the loyalty program by accepting the legal terms the first time.',
	REG_INTERFACE_GRP_NAME VARCHAR(100) NOT NULL COMMENT 'Name of the interface group through which the user registered or reregistered for the geographical area in the loyalty program by accepting the legal terms the first time.',
	REG_INTERFACE_GRP_DESCR VARCHAR(100) NOT NULL COMMENT 'Description of the interface group through which the user registered or reregistered for the geographical area in the loyalty program by accepting the legal terms the first time.',
	LOAD_ID NUMBER(38,0) NOT NULL COMMENT 'Load identifier',
	DWH_CREATED TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Row created time',
	DWH_UPDATED TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Row update time',
	constraint PK_CUST_REG_DEREG_LDPL_INTERFACE primary key (REG_INTERFACE_GRP_ID)
)COMMENT=' Lidlplus: Table to provide lookup for registration interface name'
;
