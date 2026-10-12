create or replace TABLE LDL_PRODUCTION_CLONE_GOOGLE_20260608_1030.P_LEW_CORE.T_REF_WORK_GROUP_2 (
	WH_WORK_GRP_NR VARCHAR(100) NOT NULL COMMENT 'Queue identifier from EWM which is used to group work package_2 and task.',
	WH_WORK_GRP_DESCR VARCHAR(250) COMMENT 'Description of the WH work group.',
	PICK_AREA_NR NUMBER(38,0) NOT NULL COMMENT 'Picking area ID as per WAMAS.',
	DWH_LOAD_ID NUMBER(38,0) NOT NULL COMMENT 'The identifier of the last load run which inserted or updated this row.',
	DWH_CREATED TIMESTAMP_NTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
	DWH_UPDATED TIMESTAMP_NTZ(9) NOT NULL COMMENT 'The point in time when this record was last updated.',
	constraint PK_T_REF_WORK_GROUP primary key (WH_WORK_GRP_NR)
)COMMENT='The table holds references of EWM Queue to WAMAS Pick Area.\n             This is a global mapping that business will maintain.'
;
