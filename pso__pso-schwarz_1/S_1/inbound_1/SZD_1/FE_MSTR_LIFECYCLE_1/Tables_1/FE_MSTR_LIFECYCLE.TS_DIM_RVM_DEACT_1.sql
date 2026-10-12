CREATE TABLE FE_MSTR_LIFECYCLE.TS_DIM_RVM_DEACT_1 (
	RVM_SID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier (surrogate key) for the despotie machine which is located in a store',
	RVM_ACTIVE_ID NUMBER(38,0) NOT NULL COMMENT 'The ID which is set by the MSTR Transaction Service Report',
	INACTIVE_DT DATE NOT NULL COMMENT 'The date when the machine was inactivated, set by MSTR Transaction Service Report.',
	INSERTED_TMSP TIMESTAMP_NTZ(9) NOT NULL COMMENT 'The date, the entry was technically inserted by the MSTR Transaction Service Report',
	CONSTRAINT PK_TS_DIM_RVM_DEACT PRIMARY KEY (RVM_SID, INSERTED_TMSP)
)COMMENT='Data from the MSTR Transaction Service Report';