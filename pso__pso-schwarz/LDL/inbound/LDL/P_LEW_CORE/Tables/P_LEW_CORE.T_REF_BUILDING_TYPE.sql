create or replace TABLE LDL_PRODUCTION_CLONE_GOOGLE_20260608_1030.P_LEW_CORE.T_REF_BUILDING_TYPE cluster by (CLIENT_ID)(
	CLIENT_ID NUMBER(38,0) NOT NULL COMMENT 'unique identifier of the DWH client / slice',
	BUILDING_TYPE_ID NUMBER(38,0) NOT NULL COMMENT 'building type code; IMS_ESB: object.info.type',
	BUILDING_TYPE_DESCR VARCHAR(100) COLLATE 'en-ci' COMMENT 'description of the building type; IMS_ESB: business initial load',
	DWH_LOAD_ID NUMBER(38,0) NOT NULL COMMENT 'Identifier of the last run which inserted or updated the record. -1 means manually inserted.',
	DWH_CREATED TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Creation timestamp of the record in the DWH.',
	DWH_UPDATED TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Timestamp of the last update of the record in the DWH.',
	constraint PK_T_REF_BUILDING_TYPE primary key (CLIENT_ID, BUILDING_TYPE_ID)
)COMMENT='$Revision: 0000 $. Description of building types, such as Store, Warehouse, Apartment, ...'
;
