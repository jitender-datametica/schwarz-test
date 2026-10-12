create or replace TABLE LDL_PRODUCTION_CLONE_GOOGLE_20260608_1030.P_LEW_CORE.T_REF_PICK_MAIN_AREA (
	PICK_MAIN_AREA_NR NUMBER(38,0) NOT NULL COMMENT 'Picking main area ID that consolidates the picking area.',
	PICK_MAIN_AREA_DESCR VARCHAR(250) COMMENT 'Description of the picking main area.',
	DWH_LOAD_ID NUMBER(38,0) NOT NULL COMMENT 'The identifier of the last load run which inserted or updated this row.',
	DWH_CREATED TIMESTAMP_NTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
	DWH_UPDATED TIMESTAMP_NTZ(9) NOT NULL COMMENT 'The point in time when this record was last updated.',
	constraint PK_T_REF_PICK_MAIN_AREA primary key (PICK_MAIN_AREA_NR)
)COMMENT='Reference table of picking area to the picking main area. Picking main areas are groupings of picking areas.'
;
