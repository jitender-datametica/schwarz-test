create or replace TABLE LDL_PRODUCTION_CLONE_GOOGLE_20260608_1030.P_LEW_CORE.T_WAREHOUSE_WORK_BREAK_2 (
	CLIENT_ID NUMBER(38,0) NOT NULL COMMENT 'DWH-Mandant_2; FK auf CLIENT',
	WORK_PACKAGE_SID NUMBER(38,0) NOT NULL COMMENT 'Surrogate identifier to be created (client, warehouse and warehouse work package_2 (WHO)).',
	WORK_BREAK_SEQ NUMBER(38,0) NOT NULL COMMENT 'For each break during work package_2 work (Client+LGNUM+WHO per record) the sequence of breaks is stored (gets generated on data input).',
	WH_LOC_SID NUMBER(38,0) NOT NULL COMMENT 'Warehouse; FK auf LOCATION_2',
	WORK_BREAK_START_DT DATE COMMENT 'Date when the break was started.',
	WORK_BREAK_START_TMSP TIMESTAMP_NTZ(9) COMMENT 'The point in time when the break was started.',
	WORK_BREAK_END_DT DATE COMMENT 'Date when the break was ended.',
	WORK_BREAK_END_TMSP TIMESTAMP_NTZ(9) COMMENT 'The point in time when the break was ended.',
	DWH_LOAD_ID NUMBER(38,0) NOT NULL COMMENT 'The identifier of the last load run which inserted or updated this row.',
	DWH_CREATED TIMESTAMP_NTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
	DWH_UPDATED TIMESTAMP_NTZ(9) NOT NULL COMMENT 'The point in time when this record was last updated.',
	constraint PK_T_WAREHOUSE_WORK_BREAK primary key (WORK_BREAK_SEQ, WORK_PACKAGE_SID)
)COMMENT='The table holds the break time for warehouse work package.'
;
