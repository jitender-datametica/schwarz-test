CREATE TABLE CORE.T_DIM_RVM_CONFIGURATION_UPDATE_SOURCE_2 (
	RVM_CONFIG_SOURCE_CD VARCHAR(50) NOT NULL COMMENT 'The code for the deposit machine configuration source e.g. donwload article meta data 1,...',
	RVM_CONFIG_SOURCE_DESCR VARCHAR(250) NOT NULL COMMENT 'A textual default description for the configuration source in German.',
	RVM_CONFIG_SOURCE_DESCR_EN VARCHAR(250) NOT NULL COMMENT 'A textual description for the configuration source in English.',
	RVM_CONFIG_SOURCE_DESCR_DE VARCHAR(250) NOT NULL COMMENT 'A textual description for the configuration source in German.',
	DWH_CREATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was inserted into the table.',
	DWH_UPDATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)',
	CONSTRAINT PK_T_DIM_RVM_CONFIGURATION_UPDATE_SOURCE PRIMARY KEY (RVM_CONFIG_SOURCE_CD)
)COMMENT='This minor dimension defines the update source system of deposit machines'
;