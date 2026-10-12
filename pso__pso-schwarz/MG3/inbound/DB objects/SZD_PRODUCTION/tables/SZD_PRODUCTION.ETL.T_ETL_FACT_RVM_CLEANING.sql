create or replace TABLE SZD_PRODUCTION.ETL.T_ETL_FACT_RVM_CLEANING (
	RVM_SID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier (surrogate key) for the despotie machine which is located in a store',
	BEGIN_OF_CLEANING_DT DATE NOT NULL COMMENT 'The date when the deposit machine was cleaned.',
	BEGIN_OF_CLEANING_TM TIME(9) NOT NULL COMMENT 'The time when preventive maintenance was carried out on the deposit machine.',
	CLEANING_TYPE_CD VARCHAR(50) NOT NULL COMMENT 'The code for the cleaning type',
	CLEANING_STATUS_CD VARCHAR(50) NOT NULL COMMENT 'The code for the cleaning status',
	END_OF_CLEANING_DT DATE NOT NULL COMMENT 'The timestamp for the end of cleaning of the deposit machine',
	END_OF_CLEANING_TM TIME(9) NOT NULL COMMENT 'The time for the end of cleaning of the deposit machine',
	CLEANING_DUR_SEC_CNT NUMBER(38,0) NOT NULL COMMENT 'The analytical fact for the cleaning duration time',
	DWH_CREATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was inserted into the table.',
	DWH_UPDATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)',
	constraint PK_T_FACT_RVM_CLEANING primary key (RVM_SID, BEGIN_OF_CLEANING_DT, BEGIN_OF_CLEANING_TM)
);