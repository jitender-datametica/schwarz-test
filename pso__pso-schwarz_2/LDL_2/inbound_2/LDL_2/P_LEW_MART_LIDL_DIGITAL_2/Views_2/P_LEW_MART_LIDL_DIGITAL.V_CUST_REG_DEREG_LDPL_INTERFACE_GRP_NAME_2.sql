create or replace view LDL_PRODUCTION_CLONE_GOOGLE_20260608_1030.P_LEW_MART_LIDL_DIGITAL.V_CUST_REG_DEREG_LDPL_INTERFACE_GRP_NAME_2(
	REG_INTERFACE_GRP_ID COMMENT 'ID of the registration interface group through which the user registered or reregistered for the geographical area in the loyalty program by accepting the legal terms the first time.',
	REG_INTERFACE_GRP_NAME COMMENT 'Name of the interface group through which the user registered or reregistered for the geographical area in the loyalty program by accepting the legal terms the first time.',
	REG_INTERFACE_GRP_DESCR COMMENT 'Description of the interface group through which the user registered or reregistered for the geographical area in the loyalty program by accepting the legal terms the first time.',
	LOAD_ID COMMENT 'Load identifier',
	DWH_CREATED COMMENT 'Row created time',
	DWH_UPDATED COMMENT 'Row update time'
) COMMENT='Lidlplus view : Table that is used as lookup for registration interface attribute'
 as
SELECT
 REG_INTERFACE_GRP_ID
,REG_INTERFACE_GRP_NAME
,REG_INTERFACE_GRP_DESCR
,LOAD_ID
,DWH_CREATED
,DWH_UPDATED
FROM P_LEW_MART_LIDL_DIGITAL.T_CUST_REG_DEREG_LDPL_INTERFACE_GRP_NAME_2;
