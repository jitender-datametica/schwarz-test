create or replace TABLE SZD_PRODUCTION.CORE.T_DIM_CHARGE_POINT_1 (
	RESOURCE_ITEM_SID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier (surrogate key) for the charge point.',
	DWH_VALID_FROM_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record became valid.',
	DWH_VALID_TO_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was no longer valid.',
	DWH_VALID_FG BOOLEAN NOT NULL COMMENT 'An indicator showing the current record, i.e. where the current date is between dwh_valid_from and dwh_valid_to.',
	CHARGER_PROVIDER_SYSTEM_CD VARCHAR(50) COMMENT 'Natural/Business Key - The unique code of the charger provider system.',
	CHARGER_RESOURCE_ITEM_SID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier (surrogate key) for the charger.',
	CHARGE_POINT_PLUGIN_TYPE_CD VARCHAR(50) NOT NULL COMMENT 'The unique code of the charger plugin type.',
	CHARGE_POINT_PLUGIN_TYPE_NAME VARCHAR(100) NOT NULL COMMENT 'Descriptive Attribute - The name of the plugin type.',
	CHARGE_POINT_POWER_TYPE_CD VARCHAR(50) NOT NULL COMMENT 'The unique code of the charging power type.',
	CHARGE_POINT_POWER_TYPE_NAME VARCHAR(100) NOT NULL COMMENT 'Descriptive Attribute - The name of the power type.',
	CHARGE_POINT_UUID_NR VARCHAR(250) NOT NULL COMMENT 'Natural/Business Key - Technical key of the chargepoint.',
	CHARGE_POINT_CONNECTOR_POWER_MEAS NUMBER(38,5) NOT NULL COMMENT 'Descriptive Attribute - The power of the connector type in kW.',
	CHARGE_POINT_CONNECTOR_LABEL_TXT VARCHAR(1000) COMMENT 'Descriptive Attribute - The label text of the connector.',
	CHARGE_POINT_EVSE_NR VARCHAR(250) COMMENT 'Descriptive Attribute - Electric Vehicle Supply Equipment Identifier',
	CHARGE_POINT_OCPP_ID NUMBER(38,0) COMMENT 'Descriptive Attribute - The local identifier of the charge point for this charging station.',
	DWH_CREATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was inserted into the table.',
	DWH_UPDATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)',
	DWH_SRC_FILE_NAME VARCHAR(500) COMMENT 'Contains the name(s) of the input file(s) that delivered the record. It can be either the full path of the BLOG storage or the shortened file path',
	DWH_SRC_1_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The extraction timestamp of the record from the source',
	constraint PK_DIM_CHARGE_POINT primary key (RESOURCE_ITEM_SID, DWH_VALID_FROM_TMSP)
)COMMENT='Major Dimension - The charge point (plugin) of a charging station. - Source - IOT Charger'
;