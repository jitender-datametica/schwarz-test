create or replace TABLE SZD_PRODUCTION.ETL.T_ETL_CHARGEPOINTS_CHARGE_POINT_CONNECTOR_TYPE_1 (
	CHARGE_POINT_CONNECTOR_TYPE_ID NUMBER(38,0) NOT NULL COMMENT 'The unique code of the connector type.',
	CHARGE_POINT_CONNECTOR_TYPE_NAME VARCHAR(100) NOT NULL COMMENT 'Natural/Business Key - The name of the connector type.',
	CHARGE_POINT_CONNECTOR_TYPE_POWER_MEAS NUMBER(38,5) NOT NULL COMMENT 'The power of the connector type in kW.',
	POWER_TYPE_CD VARCHAR(50) NOT NULL COMMENT 'The code for the type of power.',
	DWH_CREATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was inserted into the table.',
	DWH_UPDATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)',
	DWH_SRC_FILE_NAME VARCHAR(500) COMMENT 'Contains the name(s) of the input file(s) that delivered the record. It can be either the full path of the BLOG storage or the shortened file path',
	DWH_SRC_1_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The extraction timestamp of the record from the source',
	constraint PK_CHARGE_POINT_CONNECTOR_TYPE primary key (CHARGE_POINT_CONNECTOR_TYPE_ID)
);