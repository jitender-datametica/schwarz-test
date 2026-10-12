create or replace TABLE SZD_PRODUCTION.CORE.T_DIM_RVM_PREV_ACTIONS_TYPE_1 (
	RVM_PREV_ACTION_TYPE_ID NUMBER(38,0) NOT NULL COMMENT 'The code defining the type of preventive maintenance activity for a deposit machine.',
	RVM_PREV_ACTION_TYPE_DESCR VARCHAR(250) NOT NULL COMMENT 'A textual default description for the type of preventive maintenance activity for a deposit machine in German.',
	RVM_PREV_ACTION_TYPE_DESCR_EN VARCHAR(250) NOT NULL COMMENT 'A textual description for the type of preventive maintenance activity for a deposit machine in English',
	RVM_PREV_ACTION_TYPE_DESCR_DE VARCHAR(250) NOT NULL COMMENT 'A textual description for the type of preventive maintenance activity for a deposit machine in German.',
	DWH_CREATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was inserted into the table.',
	DWH_UPDATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)',
	constraint PK_T_DIM_RVM_PREV_ACTIONS_TYPE primary key (RVM_PREV_ACTION_TYPE_ID)
)COMMENT='This minor dimension lists the types of preventive maintenance activities that can be carried out for deposit machines.'
;