CREATE TRANSIENT TABLE ETL.T_TCACHE_LISY_REAL_ESTATE_ADDRESS_IMDT (
	REAL_ESTATE_SID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier (surrogate key) for the real estate object.',
	ADDR_SID NUMBER(38,0) COMMENT 'The unique identifier (surrogate key) for the address of the real estate object. This may be a street address, a phone number or an email address.',
	TEL_SID NUMBER(38,0) COMMENT 'The unique identifier (surrogate key) for the address of the real estate object. This may be a street address, a phone number or an email address.',
	SRC_SINKMODIFIEDON TIMESTAMP_NTZ(6),
	DWH_CREATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
	DWH_UPDATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last updated.',
	DWH_LOAD_ID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
	DWH_NODE_CD VARCHAR(20) NOT NULL COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.'
);
