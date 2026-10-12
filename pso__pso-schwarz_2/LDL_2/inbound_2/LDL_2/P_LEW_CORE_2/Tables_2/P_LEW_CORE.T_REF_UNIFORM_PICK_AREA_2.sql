create or replace TABLE LDL_PRODUCTION_CLONE_GOOGLE_20260608_1030.P_LEW_CORE.T_REF_UNIFORM_PICK_AREA_2 (
	PICK_AREA_NR NUMBER(38,0) NOT NULL COMMENT 'Picking area ID as per WAMAS.',
	PICK_AREA_DESCR VARCHAR(250) COMMENT 'Description of the picking area.',
	PICK_MAIN_AREA_NR NUMBER(38,0) NOT NULL COMMENT 'Main picking area ID.',
	DWH_LOAD_ID NUMBER(38,0) NOT NULL COMMENT 'The identifier of the last load run which inserted or updated this row.',
	DWH_CREATED TIMESTAMP_NTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
	DWH_UPDATED TIMESTAMP_NTZ(9) NOT NULL COMMENT 'The point in time when this record was last updated.',
	constraint PK_T_REF_UNIFORM_PICK_AREA primary key (PICK_AREA_NR)
)COMMENT='The table holds picking area information like high rack (Hochregal), freezer, chiller, etc.. from the global input.'
;
