create or replace TABLE SZD_PRODUCTION.ETL.T_ETL_FACT_RVM_PREV_ACTIONS_2 (
	RVM_SID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier (surrogate key) for the despotie machine which is located in a store',
	PREV_ACTION_DT DATE NOT NULL COMMENT 'The date when preventive maintenance was carried out on the deposit machine.',
	PREV_ACTION_TM TIME(9) NOT NULL COMMENT 'The time when preventive maintenance was carried out on the deposit machine.',
	RVM_PREV_ACTION_TYPE_ID NUMBER(38,0) NOT NULL COMMENT 'The code defining the type of preventive maintenance activity for a deposit machine.',
	DWH_UPDATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)',
	DWH_CREATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was inserted into the table.',
	constraint PK_T_FACT_RVM_PREV_ACTIONS primary key (RVM_SID, PREV_ACTION_DT, PREV_ACTION_TM)
);