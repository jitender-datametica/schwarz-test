CREATE TABLE CORE.T_DIM_RVM_SORT_TYPE_2 (
	RVM_SORT_TYPE_CD VARCHAR(50) NOT NULL COMMENT 'The code for the deposit machine background system sort type',
	RVM_SORT_TYPE_DESCR VARCHAR(250) NOT NULL COMMENT 'A textual default description for the direction from where the deposit machine can be emptied in German. (left / right / front / back)',
	RVM_SORT_TYPE_DESCR_EN VARCHAR(250) NOT NULL COMMENT 'A textual description for the direction from where the deposit machine can be emptied in English. (left / right / front / back)',
	RVM_SORT_TYPE_DESCR_DE VARCHAR(250) NOT NULL COMMENT 'A textual description for the direction from where the deposit machine can be emptied in German. (left / right / front / back)',
	DWH_CREATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was inserted into the table.',
	DWH_UPDATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)',
	CONSTRAINT PK_T_DIM_RVM_SORT_TYPE PRIMARY KEY (RVM_SORT_TYPE_CD)
)COMMENT='This minor dimension defines the sort types of deposit machines (e.g. Standard / MotorEnd)'
;