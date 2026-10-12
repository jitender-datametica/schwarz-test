create or replace TABLE LDL_PRODUCTION_CLONE_GOOGLE_20260608_1030.P_LEW_CORE.T_REF_BUILDING_STATUS_2 cluster by (CLIENT_ID)(
	CLIENT_ID NUMBER(38,0) NOT NULL COMMENT 'unique identifier of the DWH client / slice',
	BUILDING_STATUS_ID NUMBER(38,0) NOT NULL COMMENT 'building status_2 describing the lifecycle; IMS_ESB: object.status_2-development.status.id',
	BUILDING_STATUS_DESCR VARCHAR(100) COLLATE 'en-ci' COMMENT 'building status_2 description; IMS_ESB: status_2    master-data.objects_status.object_status.name.lang\n                                                                                      status_* master-data.objects_status.object_status.name.name (lang=*)\n            ',
	DWH_LOAD_ID NUMBER(38,0) NOT NULL COMMENT 'Identifier of the last run which inserted or updated the record. -1 means manually inserted.',
	DWH_CREATED TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Creation timestamp of the record in the DWH.',
	DWH_UPDATED TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Timestamp of the last update of the record in the DWH.',
	constraint PK_T_REF_BUILDING_STATUS primary key (CLIENT_ID, BUILDING_STATUS_ID)
)COMMENT='$Revision: 0000 $. Description of building status_2 representing the building lifecycle from initialization, via opening to closing (and steps in between); but also building rejected or finally closed '
;
