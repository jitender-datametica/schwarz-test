create or replace TABLE LDL_PRODUCTION_CLONE_GOOGLE_20260608_1030.P_LEW_CORE.T_STORAGE_TEST_RESULT_GROUP_1 (
	STORAGE_TEST_RESULT_GRP_SID NUMBER(38,0) NOT NULL COMMENT 'Surrogate key for result grouping.',
	STORAGE_TEST_RESULT_GRP_TYPE_CD VARCHAR(100) NOT NULL COMMENT 'A code for the type of grouping used in storage test_1 results (general, store, user defined group, product group).',
	LOC_SID_STORE NUMBER(38,0) COMMENT 'Surrogate Key LOCATION_1 (eindeutig ueber alle Laender / Mandanten hinweg).',
	TEST_WEEK NUMBER(38,0) NOT NULL COMMENT 'Week number in which a test_1 is conducted.',
	ITEM_GRP_INT_SID NUMBER(38,0) NOT NULL COMMENT 'Surrogate Key ITEMGROUP_1 INTERNATIONAL.',
	SUB_ITEM_GRP_SID NUMBER(38,0) NOT NULL COMMENT 'Surrogate Key SUBITEMGROUP.',
	STORAGE_TEST_PROMO_TYPE_CD VARCHAR(100) NOT NULL COMMENT 'A code for promotional clusters used in storage tests (Normal, Promo).',
	USER_DEFINED_GRP_NAME VARCHAR(100) COMMENT 'A user defined group name.',
	DWH_LOAD_ID NUMBER(38,0) NOT NULL COMMENT 'The identifier of the last load run which inserted or updated this row.',
	DWH_CREATED TIMESTAMP_NTZ(9) NOT NULL COMMENT 'The timestamp when the row was inserted.',
	DWH_UPDATED TIMESTAMP_NTZ(9) NOT NULL COMMENT 'The timestamp when the row was updated the last time.',
	constraint PK_T_STORAGE_TEST_RESULT_GROUP primary key (STORAGE_TEST_RESULT_GRP_SID)
)COMMENT='A table to store different levels on which KPI are calculated in the storage tests. If an attribute is null it is not relevant for the given level.'
;
