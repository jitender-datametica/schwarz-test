CREATE TABLE CORE.T_DIM_RVM_TYPE (
	RVM_TYPE_CD VARCHAR(50) NOT NULL COMMENT 'The code by which this type of deposit machine is identied, as assigned by the manufacturer.',
	MANUFACTURER_SID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier (surrogate key) for a company which produces deposit machines.',
	RVM_TYPE_NAME VARCHAR(100) NOT NULL COMMENT 'The code by which this type of deposit machine is identied, as assigned by the manufacturer.',
	DWH_CREATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was inserted into the table.',
	DWH_UPDATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)',
	CONSTRAINT PK_T_DIM_RVM_TYPE PRIMARY KEY (RVM_TYPE_CD, MANUFACTURER_SID) NOT ENFORCED
)COMMENT='This minor entity defines the types of deposit machines offered by each manufacturer.'
;