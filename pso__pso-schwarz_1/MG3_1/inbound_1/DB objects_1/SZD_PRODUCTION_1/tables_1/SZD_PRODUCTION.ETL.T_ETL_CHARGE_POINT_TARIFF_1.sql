create or replace TABLE SZD_PRODUCTION.ETL.T_ETL_CHARGE_POINT_TARIFF_1 (
	CHARGE_POINT_TARIFF_ID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier of the charge point tariff.',
	CHARGE_POINT_TARIFF_TYPE_CD VARCHAR(50) NOT NULL COMMENT 'The unique code of the charge point tariff type.',
	CHARGE_POINT_TARIFF_NAME VARCHAR(100) NOT NULL COMMENT 'Natural/Business Key - The unique name of the charge point tariff.',
	DWH_CREATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was inserted into the table.',
	DWH_UPDATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)',
	DWH_SRC_FILE_NAME VARCHAR(500) COMMENT 'Contains the name(s) of the input file(s) that delivered the record. It can be either the full path of the BLOG storage or the shortened file path',
	DWH_SRC_1_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The extraction timestamp of the record from the source',
	constraint PK_CHARGE_POINT_TARIFF primary key (CHARGE_POINT_TARIFF_ID)
);